c     Rows are interchanged for stability.
c
      subroutine pivot(m,n,i,a,b)
        
      implicit real*8 (a-h,o-z)
      complex*16 temp
      complex*16, intent(INOUT) :: a(m,m),b(m)
      integer, intent(IN) :: i
c
      i0=i
      amp0=cdabs(a(i,i))
      do 1 j=i+1,n
      amp=cdabs(a(j,i))
      if(amp.gt.amp0)then
      i0=j
      amp0=amp
      end if
    1 continue
      if(i0.eq.i)return
c
      temp=b(i)
      b(i)=b(i0)
      b(i0)=temp
      do 2 j=i,n
      temp=a(i,j)
      a(i,j)=a(i0,j)
      a(i0,j)=temp
    2 continue
c
      return
      end