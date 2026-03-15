/**
 * interactive.js - Client-side Python Interpreter using Pyodide
 * Adds "Run" buttons to <code> blocks and handles execution.
 */

(function() {
  let pyodideInstance = null;
  let loadingPromise = null;

  async function getPyodide() {
    if (pyodideInstance) return pyodideInstance;
    if (loadingPromise) return loadingPromise;

    loadingPromise = new Promise((resolve, reject) => {
      const script = document.createElement('script');
      script.src = "https://cdn.jsdelivr.net/pyodide/v0.26.4/full/pyodide.js";
      script.onload = async () => {
        try {
          pyodideInstance = await loadPyodide({
            indexURL: "https://cdn.jsdelivr.net/pyodide/v0.26.4/full/"
          });
          resolve(pyodideInstance);
        } catch (err) {
          reject(err);
        }
      };
      script.onerror = () => reject(new Error("Failed to load Pyodide script from CDN"));
      document.head.appendChild(script);
    });

    return loadingPromise;
  }

  function setupCodeBlocks() {
    // Target pre blocks that contain code
    const pres = document.querySelectorAll('pre');
    
    pres.forEach((pre) => {
      if (pre.dataset.interactive === 'true') return;
      
      const code = pre.querySelector('code');
      if (!code) return;

      // Only add to blocks that look like Python or are multi-line and don't look like OpenFOAM dicts
      const isPython = code.classList.contains('language-Python') || code.classList.contains('language-python');
      const isMultiline = code.textContent.trim().split('\n').length > 1;
      
      if (!isPython && !isMultiline) return;
      if (code.textContent.includes('version 2.0') && code.textContent.includes('{')) return; // Likely OpenFOAM dict

      pre.dataset.interactive = 'true';

      // Create a wrapper
      const container = document.createElement('div');
      container.className = 'code-container';
      pre.parentNode.insertBefore(container, pre);
      container.appendChild(pre);

      // Reset pre positioning to avoid button placement issues
      pre.style.position = 'static';
      pre.style.margin = '0';

      // Add Run button
      const runBtn = document.createElement('button');
      runBtn.className = 'run-btn';
      runBtn.innerHTML = 'Run';
      
      const codeText = code.textContent;
      
      // Engineering library check
      const isUnsupported = /import\s+(dolfin|fenics|fenics_adjoint|meshio|dolfinx|ufl|ffc|basix|gmsh)/i.test(codeText) || 
                            /from\s+(dolfin|fenics|fenics_adjoint|meshio|dolfinx|gmsh)/i.test(codeText) ||
                            /system\(["'](foam|blockMesh|snappyHexMesh)/i.test(codeText);

      if (isUnsupported) {
          runBtn.disabled = true;
          runBtn.innerHTML = 'Desktop Only';
          runBtn.title = "This code requires libraries (FEniCS/gmsh/OpenFOAM) not available in standard Python.";
          runBtn.style.opacity = '0.5';
      }

      container.appendChild(runBtn);

      // Add Output console
      const output = document.createElement('div');
      output.className = 'python-output';
      output.innerHTML = '<div class="output-header">Output</div><div class="output-content"></div>';
      container.appendChild(output);

      runBtn.addEventListener('click', async (e) => {
        e.preventDefault();
        if (runBtn.disabled) return;
        
        const content = output.querySelector('.output-content');
        output.classList.add('active');
        content.innerHTML = '<span class="pyodide-loader"></span> Loading Python environment...';
        runBtn.disabled = true;
        runBtn.innerHTML = 'Running...';

        try {
          const py = await getPyodide();
          content.innerHTML = '';
          
          let stdout = "";
          py.setStdout({ batched: (str) => {
              stdout += str + '\n';
              content.innerText = stdout;
          }});
          
          py.setStderr({ batched: (str) => {
              content.innerHTML += `<span class="terminal-error">${str}</span>\n`;
          }});

          await py.runPythonAsync(codeText);
          
          if (content.innerText.trim() === '' && !content.querySelector('.terminal-error')) {
              content.innerHTML = '<span style="opacity:0.4; font-style:italic;">[No output]</span>';
          }
        } catch (err) {
          content.innerHTML += `<span class="terminal-error">Error: ${err.message}</span>`;
        } finally {
          runBtn.disabled = false;
          runBtn.innerHTML = 'Run Again';
        }
      });
    });
  }

  // Initialize
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', setupCodeBlocks);
  } else {
    setupCodeBlocks();
  }
})();
