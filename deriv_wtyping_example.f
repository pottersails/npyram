subroutine deriv(m, n, sig, alp, dg, dh1, dh2, dh3, bin, nu)
    implicit none

    ! Declare variables explicitly
    integer, intent(in) :: m, n
    real*8, intent(in) :: sig, alp, nu
    complex*16, intent(out) :: dg(m), dh1(m), dh2(m), dh3(m)
    real*8, intent(in) :: bin(m, m)

    ! Internal variables
    integer :: i, j
    complex*16 :: ci
    real*8 :: exp1, exp2, exp3

    ! Initialize complex constant
    ci = dcmplx(0.0d0, 1.0d0)

    ! Initialize first elements
    dh1(1) = 0.5d0 * ci * sig
    exp1 = -0.5d0
    dh2(1) = alp
    exp2 = -1.0d0
    dh3(1) = -2.0d0 * nu
    exp3 = -1.0d0

    ! Compute dh1, dh2, dh3 using loops
    do i = 2, n
        dh1(i) = dh1(i - 1) * exp1
        exp1 = exp1 - 1.0d0
        dh2(i) = dh2(i - 1) * exp2
        exp2 = exp2 - 1.0d0
        dh3(i) = -nu * dh3(i - 1) * exp3
        exp3 = exp3 - 1.0d0
    end do
	
    ! Compute dg values
    dg(1) = 1.0d0
    dg(2) = dh1(1) + dh2(1) + dh3(1)

    do i = 2, n
        dg(i + 1) = dh1(i) + dh2(i) + dh3(i)
        do j = 1, i - 1
            dg(i + 1) = dg(i + 1) + bin(i, j) * (dh1(j) + dh2(j) + dh3(j)) * dg(i - j + 1)
        end do
    end do

    return
end subroutine deriv