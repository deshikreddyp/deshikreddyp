$mapping = @{
    'ale-move.html' = 'Geometry & Mesh';
    'behind-cfd.html' = 'Computational Modeling (Numerical Methods)';
    'boundary-layer-problem.html' = 'Computational Modeling (Numerical Methods)';
    'checkpoint-restart-in-legacy-fenics.html' = 'FEniCS';
    'classification-of-pdes.html' = 'Computational Modeling (Numerical Methods)';
    'coleman-noll-procedure.html' = 'Computational Modeling (Numerical Methods)';
    'dealing-with-complex-geometries-in-cfd.html' = 'Geometry & Mesh';
    'fenics-interpolation-across-non-matching-meshes.html' = 'FEniCS';
    'flow-boundary-conditions.html' = 'Boundary Conditions';
    'fluid-structure-interaction-ale.html' = 'Computational Modeling (Numerical Methods)';
    'fpl-project.html' = 'Computational Modeling (Numerical Methods)';
    'front-tracking-method.html' = 'Computational Modeling (Numerical Methods)';
    'fsi-solver-notes-and-preconditioner-study.html' = 'Linear Algebra/Solvers';
    'fundamentals-of-differential-equations.html' = 'Computational Modeling (Numerical Methods)';
    'getting-started.html' = 'Computational Modeling (Numerical Methods)';
    'governing-equations.html' = 'Computational Modeling (Numerical Methods)';
    'inflation-bl.html' = 'Geometry & Mesh';
    'installing-gmsh-on-cluster.html' = 'HPC';
    'lagrange-multipliers.html' = 'Linear Algebra/Solvers';
    'latex-plug-in-for-inkscape.html' = 'Computational Modeling (Numerical Methods)';
    'level-set-method.html' = 'Computational Modeling (Numerical Methods)';
    'markboundaries-py.html' = 'FEniCS';
    'numerical-solution-of-parabolic-and-elliptic-differ.html' = 'Computational Modeling (Numerical Methods)';
    'o2-h2-reactant-fractions.html' = 'Computational Modeling (Numerical Methods)';
    'petsc-fieldsplit-preconditioner-notes.html' = 'Linear Algebra/Solvers';
    'petsc-gamg-preconditioner-notes.html' = 'Linear Algebra/Solvers';
    'pressure-poisson-equation-incompressibility-constr.html' = 'Linear Algebra/Solvers';
    'pressure.html' = 'Computational Modeling (Numerical Methods)';
    'quadrature-rule-riemann-lebesgue-integration.html' = 'Computational Modeling (Numerical Methods)';
    'reference-values.html' = 'Computational Modeling (Numerical Methods)';
    'reynolds-grashof-prandtl-eckert-nusselt-number.html' = 'Computational Modeling (Numerical Methods)';
    'some-good-resources-on-newton-raphson-method.html' = 'Computational Modeling (Numerical Methods)';
    'static-pressure.html' = 'Computational Modeling (Numerical Methods)';
    'stl-to-brep-stl2brep-py.html' = 'Geometry & Mesh';
    'temperature.html' = 'Computational Modeling (Numerical Methods)';
    'the-generalized-minimal-residual-gmres-method.html' = 'Linear Algebra/Solvers';
    'thoughts-on-solving-system-of-linear-equations.html' = 'Linear Algebra/Solvers';
    'variational-form-of-ns.html' = 'FEniCS';
    'velocity-of-fluid.html' = 'Computational Modeling (Numerical Methods)';
    'velocity-potential.html' = 'Computational Modeling (Numerical Methods)';
    'volume-of-fluid-method-vof.html' = 'Computational Modeling (Numerical Methods)';
    'volume-of-fluid.html' = 'Computational Modeling (Numerical Methods)';
    'what-is-boussinesq-approximation.html' = 'Computational Modeling (Numerical Methods)'
}

foreach ($file in $mapping.Keys) {
    $path = "c:\Users\deshi\Documents\GitHub\deshikreddyp\notes\$file"
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path)
        $newCat = $mapping[$file]
        # Regex to match the category line
        $pattern = '<p class="small">Category: .*?</p>'
        $replacement = '<p class="small">Category: ' + $newCat + '</p>'
        $newContent = $content -replace $pattern, $replacement
        [System.IO.File]::WriteAllText($path, $newContent)
        Write-Host "Updated $file to $newCat"
    }
}
