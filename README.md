This repository is one of several efforts to modernize the well-known underwater acoustic propagation model RAM.  There exists fully python implementations of this code, notably 'PyRAM', and this repository is not meant to reproduce that or similar efforts. By contrast, this effort is meant to wrap the original compiled fortran code
into python modules, which could be leveraged by existing projects to improve performance (by offloading computation from python to fortran).  However, this effort may be adapted to a complete python/RAM implementation if that makes sense. 


The overall approach is to:

- modernize the fortran code with explict typing and in/out intents where necessary
- wrap the computationally heavy components using f2py into a python module
- offer a portable api to the original fundamental subroutines (e.g. martc, solve, pade, etc.)

The result will be the same well-known and efficent computation, but with a modern and direct python interface.

## Steps to get f2py compiling on windows/conda

### install dependencies and create env
```
conda create -n f2pyenv python=3.13
conda activate f2pyenv
conda install -c conda-forge gfortran meson numpy
```
Note that spyder-kernels does not impact f2py's functionality, but installing git did appear to break it. 
### example compilation

```
f2py -c -m pivot pivot.f
```

### example with library links
```
f2py -c -m pivot pivot.f --fcompiler=gfortran --link-libgcc --link-quadmath --link-libgfortran
```

### importing and using

The above f2py commands will build a .pyd library named according to the pattern module.env-details.pyd
The pivot example above produced `pivot.cp313t-win_amd64.pyd`.  When you attempt to import pivot, python looks for a module with a name that matches the current python environment.  Therefore, as long as the environment is identical, the import should work.

Below is an example of using pivot (though in this case the module was compiled to 'ram'

```python
import numpy as np
from src.ram import pivot

print(pivot.__doc__)

# build fortran compliant in/out numpy arrays
# dtype matches fortrans complex*16
# order="f" resolves errors related to the data not being fortran contigious

a = np.array(np.random.rand(3, 3), dtype="cdouble", order="F")
b = np.array(
    np.random.rand(
        3,
    ),
    dtype="cdouble",
    order="F",
)

# show input arrays
print(a)
print(b)

# call compiled fortran
pivot(1, a, b)

# print pivoted result
print(a)
print(b)
``
