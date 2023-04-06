syms s d1 df j1 j2 d2 kf km ki kw2


A=[s+((d1+df)/j1) -df/j1 kf/j1 ; -df/j2 s+((df+d2)/j2) -kf/j2 ; -1 1 s]
C=[0 kw2 0]
Ainv=simplify(inv(A))
B=[(km*ki)/j1;0;0]
Res=C*Ainv*B

