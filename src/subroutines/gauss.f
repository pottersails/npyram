c     Gaussian elimination.
c
      subroutine gauss(m,n,a,b)
      implicit real*8 (a-h,o-z)
      complex*16, intent(INOUT) :: a(m,m),b(m)
c
c     Downward elimination.
c
      do 4 i=1,n
      if(i.lt.n)call pivot(m,n,i,a,b)
      a(i,i)=1.0d0/a(i,i)
      b(i)=b(i)*a(i,i)
      if(i.lt.n)then
      do 1 j=i+1,n
      a(i,j)=a(i,j)*a(i,i)
    1 continue
      do 3 k=i+1,n
      b(k)=b(k)-a(k,i)*b(i)
      do 2 j=i+1,n
      a(k,j)=a(k,j)-a(k,i)*a(i,j)
    2 continue
    3 continue
      end if
    4 continue
c
c     Back substitution.
c
      do 6 i=n-1,1,-1
      do 5 j=i+1,n
      b(i)=b(i)-a(i,j)*b(j)
    5 continue
    6 continue
c
      return
      end