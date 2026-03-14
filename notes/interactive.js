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
          // The pyodide.js script defines a global 'loadPyodide' function
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
    // Target both lowercase and uppercase variations
    const codeBlocks = document.querySelectorAll('pre code.language-Python, pre code.language-python');
    
    codeBlocks.forEach((block) => {
      const parent = block.parentElement;
      if (!parent || parent.dataset.interactive === 'true') return;
      parent.dataset.interactive = 'true';

      // Ensure relative positioning for button placement
      parent.style.position = 'relative';

      // Add Run button
      const runBtn = document.createElement('button');
      runBtn.className = 'run-btn';
      runBtn.innerHTML = 'Run';
      
      const codeText = block.textContent;
      // Detect libraries that can't run in browser
      const isUnsupported = /dolfin|foam|OpenFOAM|meshio|util\.py|mark_boundaries/i.test(codeText);

      if (isUnsupported) {
          runBtn.disabled = true;
          runBtn.title = "This snippet requires engineering libraries (FEniCS/OpenFOAM) that cannot run in a browser.";
          runBtn.textContent = 'Desktop Only';
      }

      parent.appendChild(runBtn);

      // Add Output console
      const output = document.createElement('div');
      output.className = 'python-output';
      output.innerHTML = '<div class="output-header">Output</div><div class="output-content"></div>';
      parent.appendChild(output);

      runBtn.addEventListener('click', async (e) => {
        e.preventDefault();
        if (runBtn.disabled) return;
        
        const content = output.querySelector('.output-content');
        output.classList.add('active');
        content.innerHTML = '<span class="pyodide-loader"></span> Loading environment...';
        runBtn.disabled = true;

        try {
          const py = await getPyodide();
          content.innerHTML = ''; // Clear loader
          
          // Capture output
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
              content.innerHTML = '<span style="opacity:0.5; font-style:italic;">[Execution finished with no output]</span>';
          }
        } catch (err) {
          content.innerHTML += `<span class="terminal-error">Python Error: ${err.message}</span>`;
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
    // If somehow already loaded (e.g. async)
    setupCodeBlocks();
  }
})();
