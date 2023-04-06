%primer intento...
clc
clear
syms z1 z2 u y pe
w0=1.5811*exp(3);
w1=1.6667*exp(3);
b=106.066;
z1v=1.051*10^(-4);
uv=0.8;
T=1.694;
f1=-w0*z2+u*w0*z2+b;
f2=w0*z1-w1*z2-u*w0*z1;
f=[f1 f2];
y=z2;
v=[z1 z2];
pe=solve(f1==0,f2==0,z1,u);
z1e=eval(pe.z1);ue=eval(pe.u);
AA=jacobian(f,v);
BB=jacobian(f,u);
A=subs(AA,{z1 z2 u},{z1v -0.059 uv});
B=subs(BB,{z1 z2 u},{z1v -0.059 uv});
A=double(A);
B=double(B);
C=[0 1];
D=0;
%sistema en variables de estado.
VE=ss(A,B,C,D);
CC=ctrb(VE);
rank(CC)
%discreto
ved=c2d(VE,T);
ccd=ctrb(ved);
Ad=ved.a;
Bd=ved.b;
Cd=ved.c;
Dd=ved.d;
