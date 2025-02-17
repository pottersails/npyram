# -*- coding: utf-8 -*-
"""
Created on Sun Feb 16 21:03:17 2025

@author: jim
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

# call compiled fortran
gauss(2, a, b)

# print pivoted result
print(a)
print(b)
