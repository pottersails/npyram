This repository is an effort to modernize the well-known underwater acoustic propagation model RAM.  The overall approach is to:

- modernize the fortran code with explict typing and in/out intents
- wrap the computationally heavy components using f2py into a python module
- reconstruct the core functionality in python

The result will be the same well-known and computationally efficient propagation model, but with a modern and direct python interface which avoids file IO.

## Steps to get f2py compiling on windows/conda

### install dependencies and create env
```
conda create -n f2pyenv python=3.13
conda activate f2pyenv
conda install -c conda-forge gfortran meson numpy
```

### example compilation

```
f2py -c -m pivot pivot.f
```
