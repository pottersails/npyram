        subroutine profl(mz, nz, ci, dz, eta, omega, rmax, c0, k0, rp, cw, cb, rhob, &
                         attn, alpw, alpb, ksqw, ksqb)
          ! Arguments
          integer, intent(in) :: mz, nz
          complex, intent(in) :: ci
          real, intent(in) :: dz, eta, omega, rmax, c0, k0
          real, intent(out) :: rp
          real, intent(inout) :: cw(mz), cb(mz), rhob(mz), attn(mz), alpw(mz), alpb(mz)
          real, intent(out) :: ksqw(mz), ksqb(mz)
        
          ! Local variables
          integer :: i
        
          ! Read profiles
          call zread(mz, nz, dz, cw)
          call zread(mz, nz, dz, cb)
          call zread(mz, nz, dz, rhob)
          call zread(mz, nz, dz, attn)
        
          ! Set rp and read from input if available
          rp = 2.0 * rmax
          read(1, *, end=1) rp
        
          ! Compute ksqw, ksqb, alpw, alpb
        1  do i = 1, nz+2
            ksqw(i) = (omega / cw(i))**2 - k0**2
            ksqb(i) = ((omega / cb(i)) * (1.0 + ci * eta * attn(i)))**2 - k0**2
            alpw(i) = sqrt(cw(i) / c0)
            alpb(i) = sqrt(rhob(i) * cb(i) / c0)
        2  continue
        
          return
        end subroutine profl
        
        subroutine zread(mz, nz, dz, prof)
          ! Arguments
          integer, intent(in) :: mz, nz
          real, intent(in) :: dz
          real, intent(out) :: prof(mz)
        
          ! Local variables
          integer :: i, iold, j, k
          real :: zi, profi
        
          ! Initialize profile array
          do i = 1, nz+2
            prof(i) = -1.0
        1  continue
        
          ! Read profile data
          read(1, *) zi, profi
          prof(1) = profi
          i = 1.5 + zi / dz
          prof(i) = profi
          iold = i
        2  read(1, *) zi, profi
          if (zi < 0.0) goto 3
          i = 1.5 + zi / dz
          if (i == iold) i = i + 1
          prof(i) = profi
          iold = i
          goto 2
        3  prof(nz+2) = prof(i)
          i = 1
          j = 1
        4  i = i + 1
          if (prof(i) < 0.0) goto 4
          if (i - j == 1) goto 6
          do k = j+1, i-1
            prof(k) = prof(j) + real(k-j) * (prof(i) - prof(j)) / real(i-j)
        5  continue
        6  j = i
          if (j < nz+2) goto 4
        
          return
        end subroutine zread