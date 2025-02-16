This repository is an effort to modernize the well-known underwater acoustic propagation model RAM.  The overall approach is to:

- modernize the fortran code with explict typing and in/out intents
- wrap the computationally heavy components using f2py into a python module
- reconstruct the core functionality in python

The result will be the same well-known and computationally efficient propagation model, but with a modern and direct python interface.
