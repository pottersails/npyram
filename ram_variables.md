# Variables in `ram.f`
## Input Parameter definitions
- `freq` frequency (Hz)
- `zs` source depth (meters)
- `zr` reciever depth (for TL.line)
- `rmax` maximum range (meters)
- `dr` range step (meters?)
- `ndr` range step for ouput
- `zmax` maximum depth (meters)
- `dz` depth step (meters?)
- `ndz` depth step for output
- `zmplt` maximum depth for plotting
- `c0` reference sound speed (m/s)
- `npd` number of pade steps
- `ns` stability constraint
- `rs` radius of stability
- `z` `cw` water sound speed profile (m/s)
- `z` `cb` bottom sound speed profile (m/s), z defined relative to bathymetry
- `z` `rhob` bottom density profile
- `z` `attn` compressional attenuation coefficient of seabed (dB/wavelength) 
- `rp` range point for range dependent profiles

## Initial Program Definitions
- `mr` `mz` `mp`, number of points in bathymetry, depth grid, and pade terms, respectively. mz and mp importantly define (at least the intial) matrix dimensions
All of these are curiously hard coded as mr=1000 (or 100), mz=80000, mp=30, depending on ram version
Following these definitions, all of the arrays are initialized to these dimensions (but not yet given types), inlcuding:
  - `rb(mr)` `zb(mr)` which are likely the arrays defining the bathymetry (e.g. rb = range bottom, zb = depth of bottom)
  - all of the profiles: `cw(mz)` `cb(mz)` `rhob(mz)` `attn(mz)` `alpw(mz)` `alpb(mz)`; where: alpw = sqrt(cw/c0), alphb = sqrt(rhob*cb/c0)
  - the matrix coefficients: `f1(mz)` `f2(mz)` `f3(mz)`
  - wave numbers squared: `ksq(mz)` `ksqw(mz)` `ksqb(mz)`
  - field vectors: `u(mz)` `v(mz)`, not u is the complex field solution at the current step, and v is intermediate step used in the matrix solution
  - tridiagonal matrices: `r1(mz,mp)` `r2(mz,mp)` `r3(mz,mp)` `s1(mz,mp)` `s2(mz,mp)` `s3(mz,mp)`, note the matrices have dimensions depth x pade terms  
  - pade coefficients: `pd1(mp)` `pd(mp)`
  - transmission loss at step: `tlg(mz)`

Prior to calling setup, the code has only defined mr, mz, and mp
## Global Variables in the Program

- ### Complex Variables
- `ci`: Modified in `ram`, `setup`, `profl`, `updat`, `selfs`, `epade`, `guerre`
- `ksq`, `ksqb`, `u`, `v`, `r1`, `r2`, `r3`, `s1`, `s2`, `s3`, `pd1`, `pd2`: Modified in `ram`, `setup`, `matrc`, `solve`, `updat`, `selfs`

### Real Variables
- `k0`, `ksqw`: Modified in `ram`, `setup`, `profl`, `updat`, `selfs`, `epade`, `matrc`, `solve`

### Arrays
- `rb(mr)`, `zb(mr)`, `cw(mz)`, `cb(mz)`, `rhob(mz)`, `attn(mz)`, `alpw(mz)`, `alpb(mz)`, `f1(mz)`, `f2(mz)`, `f3(mz)`, `tlg(mz)`: Modified in `setup`, `profl`, `selfs`, `updat`, `matrc`, `solve`, `outpt`

## Variables in Subroutines

### Subroutine `setup`
- **Modified:** `ci`, `k0`, `ksqw`, `ksq`, `ksqb`, `u`, `v`, `r1`, `r2`, `r3`, `s1`, `s2`, `s3`, `pd1`, `pd2`, `rb`, `zb`, `cw`, `cb`, `rhob`, `attn`, `alpw`, `alpb`, `f1`, `f2`, `f3`, `tlg`
- **Read:** `freq`, `zs`, `zr`, `rmax`, `dr`, `ndr`, `zmax`, `dz`, `ndz`, `zmplt`, `c0`, `np`, `ns`, `rs`, `pi`, `eta`, `eps`, `omega`, `r`, `rp`, `rs`

### Subroutine `profl`
- **Modified:** `ci`, `k0`, `ksqw`, `ksq`, `ksqb`, `cw`, `cb`, `rhob`, `attn`, `alpw`, `alpb`
- **Read:** `mz`, `nz`, `dz`, `eta`, `omega`, `rmax`, `c0`, `rp`

### Subroutine `zread`
- **Modified:** `prof`
- **Read:** `mz`, `nz`, `dz`

### Subroutine `matrc`
- **Modified:** `ksq`, `ksqb`, `r1`, `r2`, `r3`, `s1`, `s2`, `s3`, `pd1`, `pd2`, `f1`, `f2`, `f3`
- **Read:** `mz`, `nz`, `mp`, `np`, `iz`, `jz`, `dz`, `k0`, `rhob`, `alpw`, `alpb`, `ksqw`

### Subroutine `solve`
- **Modified:** `u`, `v`
- **Read:** `mz`, `nz`, `mp`, `np`, `iz`, `r1`, `r2`, `r3`, `s1`, `s2`, `s3`

### Subroutine `updat`
- **Modified:** `ksq`, `ksqb`, `r1`, `r2`, `r3`, `s1`, `s2`, `s3`, `pd1`, `pd2`, `rb`, `zb`, `cw`, `cb`, `rhob`, `attn`, `alpw`, `alpb`, `f1`, `f2`, `f3`
- **Read:** `mr`, `mz`, `nz`, `mp`, `np`, `iz`, `ib`, `dr`, `dz`, `eta`, `omega`, `rmax`, `c0`, `k0`, `ci`, `r`, `rp`, `rs`

### Subroutine `selfs`
- **Modified:** `ci`, `k0`, `ksqw`, `ksq`, `ksqb`, `u`, `v`, `r1`, `r2`, `r3`, `s1`, `s2`, `s3`, `pd1`, `pd2`, `rhob`, `alpw`, `alpb`, `f1`, `f2`, `f3`
- **Read:** `mz`, `nz`, `mp`, `np`, `ns`, `iz`, `zs`, `dr`, `dz`, `pi`, `c0`, `k0`

### Subroutine `outpt`
- **Modified:** `tlg`, `uout`
- **Read:** `mz`, `mdr`, `ndr`, `ndz`, `iz`, `nzplt`, `lz`, `ir`, `dir`, `eps`, `r`, `f3`, `u`

### Subroutine `epade`
- **Modified:** `pd1`, `pd2`
- **Read:** `mp`, `np`, `ns`, `ip`, `k0`, `c0`, `dr`

### Subroutine `deriv`
- **Modified:** `dg`, `dh1`, `dh2`, `dh3`
- **Read:** `m`, `n`, `sig`, `alp`, `bin`, `nu`

### Subroutine `gauss`
- **Modified:** `a`, `b`
- **Read:** `m`, `n`

### Subroutine `pivot`
- **Modified:** `a`, `b`
- **Read:** `m`, `n`, `i`

### Subroutine `fndrt`
- **Modified:** `a`, `z`
- **Read:** `n`

### Subroutine `guerre`
- **Modified:** `a`, `az`, `azz`, `z`, `dz`, `p`, `pz`, `pzz`, `f`, `g`, `h`
- **Read:** `n`, `m`

```` ▋
