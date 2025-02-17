from setuptools import setup
from numpy.distutils.core import setup as np_setup
from numpy.distutils.core import Extension as np_Extension

extensions = [
    np_Extension(name='npyram.interface',
                 sources=['npyram/interface.f90', 'original_versions/ram1.5p.f'])
]

np_setup(
    name='npyram',
    version='0.1.0',
    description='Python interface to RAM1.5P Fortran code',
    author='Your Name',
    author_email='your.email@example.com',
    packages=['npyram'],
    ext_modules=extensions,
    install_requires=['numpy'],
    setup_requires=['numpy'],
)