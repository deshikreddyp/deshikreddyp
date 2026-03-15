$mappings = @{
    'ale-move.html' = @('ALE', 'Meshing')
    'behind-cfd.html' = @()
    'boundary-layer-problem.html' = @('Navier-Stokes')
    'checkpoint-restart-in-legacy-fenics.html' = @('FEniCS')
    'classification-of-pdes.html' = @()
    'coleman-noll-procedure.html' = @()
    'dealing-with-complex-geometries-in-cfd.html' = @('GMSH')
    'fenics-interpolation-across-non-matching-meshes.html' = @('FEniCS')
    'flow-boundary-conditions.html' = @('Navier-Stokes')
    'fluid-structure-interaction-ale.html' = @('FSI', 'ALE')
    'fpl-project.html' = @()
    'front-tracking-method.html' = @('Multiphase')
    'fsi-solver-notes-and-preconditioner-study.html' = @('FSI', 'PETSc', 'Preconditioning')
    'fundamentals-of-differential-equations.html' = @()
    'getting-started.html' = @()
    'governing-equations.html' = @('Navier-Stokes')
    'inflation-bl.html' = @('GMSH', 'Meshing')
    'installing-gmsh-on-cluster.html' = @('GMSH', 'HPC')
    'lagrange-multipliers.html' = @('FEniCS')
    'latex-plug-in-for-inkscape.html' = @('LaTeX')
    'level-set-method.html' = @('Multiphase')
    'markboundaries-py.html' = @('FEniCS', 'Python')
    'numerical-solution-of-parabolic-and-elliptic-differ.html' = @()
    'o2-h2-reactant-fractions.html' = @()
    'petsc-fieldsplit-preconditioner-notes.html' = @('PETSc', 'FSI', 'Preconditioning')
    'petsc-gamg-preconditioner-notes.html' = @('PETSc', 'Multigrid')
    'pressure-poisson-equation-incompressibility-constr.html' = @('Navier-Stokes')
    'pressure.html' = @()
    'quadrature-rule-riemann-lebesgue-integration.html' = @()
    'reference-values.html' = @()
    'reynolds-grashof-prandtl-eckert-nusselt-number.html' = @()
    'some-good-resources-on-newton-raphson-method.html' = @()
    'static-pressure.html' = @()
    'stl-to-brep-stl2brep-py.html' = @('GMSH', 'Python')
    'temperature.html' = @()
    'the-generalized-minimal-residual-gmres-method.html' = @('PETSc', 'Krylov')
    'thoughts-on-solving-system-of-linear-equations.html' = @('PETSc', 'Krylov')
    'variational-form-of-ns.html' = @('FEniCS', 'Navier-Stokes')
    'velocity-of-fluid.html' = @()
    'velocity-potential.html' = @()
    'volume-of-fluid-method-vof.html' = @('Multiphase')
    'volume-of-fluid.html' = @('Multiphase')
    'what-is-boussinesq-approximation.html' = @('Boussinesq')
}

$notesPath = "c:\Users\deshi\Documents\GitHub\deshikreddyp\notes"
$indexPath = "c:\Users\deshi\Documents\GitHub\deshikreddyp\notes.html"

# Update individual files
foreach ($file in $mappings.Keys) {
    $path = Join-Path $notesPath $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        $tags = [string]::Join(", ", $mappings[$file])
        
        # Update data-tags attribute
        $content = $content -replace 'data-tags="[^"]*"', "data-tags=`"$tags`""
        
        # Update Category list in body (optional but good for consistency)
        # Assuming format: <p class="small">Category: CategoryName</p>
        # We don't want to mess up the 6 categories, but maybe the user wants tags shown there too? 
        # The user said "consolidate categories into six core areas". 
        # Currently the pages show "Category: CategoryName". Let's keep that.
        
        Set-Content $path $content -NoNewline
        Write-Host "Updated tags in $file"
    }
}

# Now we need to update the notesData in notes.html
# This is trickier with regex because of the array structure.
# I'll just rewrite the notesData block in notes.html manually in the next tool call to be safe, 
# or I can try a more robust regex if I'm confident.
# Given the size, I'll just do it via replace_file_content in the next step.
