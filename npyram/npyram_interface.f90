module ram1p5_interface
  use, intrinsic :: iso_c_binding
  implicit none

  interface
    subroutine matrc(mz, nz, mp, np, iz, jz, dz, k0, rhob, alpw, alpb, ksq, ksqw, ksqb, f1, f2, f3, r1, r2, r3, s1, s2, s3, pd1, pd2) bind(c)
      use, intrinsic :: iso_c_binding
      integer(c_int), intent(in) :: mz, nz, mp, np, iz, jz
      real(c_double), intent(inout) :: dz, k0
      real(c_double), intent(inout), dimension(mz) :: rhob, alpw, alpb, ksq, ksqw, ksqb, f1, f2, f3
      real(c_double), intent(inout), dimension(mz, mp) :: r1, r2, r3, s1, s2, s3
      real(c_double), intent(inout), dimension(mp) :: pd1, pd2
    end subroutine matrc

    subroutine solve(mz, nz, mp, np, iz, u, v, r1, r2, r3, s1, s2, s3) bind(c)
      use, intrinsic :: iso_c_binding
      integer(c_int), intent(in) :: mz, nz, mp, np, iz
      real(c_double), intent(inout), dimension(mz) :: u, v
      real(c_double), intent(inout), dimension(mz, mp) :: r1, r2, r3, s1, s2, s3
    end subroutine solve

    subroutine epade(mp, np, ns, ip, k0, c0, dr, pd1, pd2) bind(c)
      use, intrinsic :: iso_c_binding
      integer(c_int), intent(in) :: mp, np, ns, ip
      real(c_double), intent(inout) :: k0, c0, dr
      real(c_double), intent(inout), dimension(mp) :: pd1, pd2
    end subroutine epade

  end interface

end module ram1p5_interface