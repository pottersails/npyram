# -*- coding: utf-8 -*-
"""
f2py -c -m ram subroutines/pivot.f subroutines/gauss.f --fcompiler=gfortran --link-libgcc --link-quadmath --link-libgfortran
"""

import numpy as np
from src.ram import gauss

print(gauss.__doc__)

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

# call compiled fortran with n=2
gauss(2, a, b)

# print pivoted result
print(a)
print(b)
