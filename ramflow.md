The main program (ignoring setup) happens in these lines:

 call updat(mr,mz,nz,mp,np,iz,ib,dr,dz,eta,omega,rmax,c0,k0,ci,r,
     >   rp,rs,rb,zb,cw,cb,rhob,attn,alpw,alpb,ksq,ksqw,ksqb,f1,f2,f3,
     >   r1,r2,r3,s1,s2,s3,pd1,pd2)
call solve(mz,nz,mp,np,iz,u,v,r1,r2,r3,s1,s2,s3)
r=r+dr
call outpt(mz,mdr,ndr,ndz,iz,nzplt,lz,ir,dir,eps,r,f3,u,tlg)


updat depends(martc,profl,epade)
solve has no dependencies

epade depends(deriv, gauss, fndrt)
martc had no dependencies
profl depends(zread)

zread has no dependencies, but reads the input deck

selfs depends(matrc, solve, epade)

deriv appears to depend on the function 'g'

guass depends(pivot)
pivot has no dependencies 

fndrt depends(guerre)

guerre has no dependencies
