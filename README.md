# Deshik Reddy Putluru

Ph.D. candidate in Mechanical Engineering at Purdue (Gomez Lab). I write high-fidelity finite-element solvers for multiphysics systems, build reduced-order models, and develop scientific machine learning surrogates. Most of my work is C++ and Python on HPC clusters.

[Portfolio](https://deshikreddyp.github.io/deshikreddyp/index.html) · [Projects](https://deshikreddyp.github.io/deshikreddyp/projects.html) · [CV](https://deshikreddyp.github.io/deshikreddyp/resume.pdf) · [LinkedIn](https://www.linkedin.com/in/deshik-reddy-putluru) · [Google Scholar](https://scholar.google.com/citations?user=9HtoRMgAAAAJ&hl=en)

## What I build

- **FEM solvers:** mixed-dimensional FSI, VMS/SUPG stabilization, ALE mesh motion, and custom Newton–Krylov solvers in PETSc, including a preconditioner 3× faster than GAMG
- **Reduced-order models and surrogates:** a 1-hour drug-transport prediction cut from 20 h to 1 s, and Gaussian-process surrogates trained on 200 Sobol-sampled cluster runs
- **Physics-informed ML:** PINNs in JAX/Equinox, with `jit`/`vmap` and Navier–Stokes residuals computed by autodiff
- **Geometry and meshing pipelines:** STL → BREP, OpenCascade, Gmsh
- **HPC workflows:** MPI, Slurm, automated parameter sweeps

## Selected repositories

| Repo | What it does | Stack |
|---|---|---|
| [segment-surfaces](https://github.com/deshikreddyp/segment-surfaces) | CLI tools for converting STL meshes to BREP and grouping boundary faces into Gmsh physical groups | Python · Gmsh |
| [CascadeCutter](https://github.com/deshikreddyp/CascadeCutter) | Fuses STEP geometries and exports connected BREP results | Python · OpenCascade |
| [codex-science-skills](https://github.com/deshikreddyp/codex-science-skills) | Reusable workflows for scientific-computing post-processing, Slurm job prep, and technical docs | Python |
| [me697-scientific-machine-learning](https://github.com/deshikreddyp/me697-scientific-machine-learning) | SciML function-approximation notebooks | JAX |
| [myInterPhaseChangeFoam_TestCase](https://github.com/deshikreddyp/myInterPhaseChangeFoam_TestCase) | Cavitating-bullet test case for a custom phase-change solver | C++ · OpenFOAM |
| [Structural-FEM](https://github.com/deshikreddyp/Structural-FEM) | Finite-element code for 1D axial-bar problems | MATLAB |

## Tech stack

**Languages:** C++ · Python · MATLAB · SQL  
**Numerics & HPC:** PETSc · MPI · Slurm · FEniCS · OpenFOAM  
**ML:** JAX · Equinox · Gaussian processes · PCA  
**Geometry & visualization:** OpenCascade · Gmsh · ParaView · PyVista  
**Tools:** Git · Linux

## Research

My thesis covers fluid–structure interaction and drug transport in the spinal canal. Latest paper: *Mixed-dimensional FSI simulations reveal key mechanisms of CSF dynamics in the spinal canal*, Fluids and Barriers of the CNS (2025). [DOI](https://doi.org/10.1186/s12987-025-00691-4)
