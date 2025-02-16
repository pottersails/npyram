c     Rows are interchanged for stability.
c
      subroutine pivot(m,n,i,a,b)
      implicit real*8 (a-h,o-z)
      complex*16 temp,a(m,m),b(m)
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
c
c     The root-finding subroutine. 
c
      subroutine fndrt(a,n,z,m)
      complex*16 a(m),z(m),root
      real*8 err
c
      if(n.eq.1)then
      z(1)=-a(1)/a(2)
      return
      end if
      if(n.eq.2)go to 4
c
      do 3 k=n,3,-1
c
c     Obtain an approximate root.
c
      root=0.0d0
      err=1.0d-12
      call guerre(a,k,m,root,err,1000)
c
c     Refine the root by iterating five more times.
c
      err=0.0d0
      call guerre(a,k,m,root,err,5)
      z(k)=root
c
c     Divide out the factor (z-root).
c
      do 1 i=k,1,-1
      a(i)=a(i)+root*a(i+1)
    1 continue
      do 2 i=1,k
      a(i)=a(i+1)
    2 continue
c
    3 continue
c
c     Solve the quadratic equation.
c
    4 z(2)=0.5*(-a(2)+sqrt(a(2)**2-4.0*a(1)*a(3)))/a(3)
      z(1)=0.5*(-a(2)-sqrt(a(2)**2-4.0*a(1)*a(3)))/a(3)
c
      return
      end