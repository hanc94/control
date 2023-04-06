clc
clear all

A=[0 1 0;0 -0.9917 34850;0 -3.6365 -1791];
B=[0;0;86.95];
C=[1 0 0];
D=0;
Mp=0.05;
ts=3;
vec=ss(A,B,C,D);
sita= (sqrt((log(Mp))^2))/(sqrt((pi^2)+((log(Mp))^2)));
wn=4.6/(sita*ts);

l1=-sita*wn+1i*wn*sqrt(1-sita^2);
l2=-sita*wn-1i*wn*sqrt(1-sita^2);
p3=-50;
T=1/(10*sita*wn);
%% Sistema discreto
VEd=c2d(vec,T);
Ad=VEd.a;
Bd=VEd.b;
Cd=VEd.c;
Dd=VEd.d;
z1=exp(l1*T);
z2=exp(l2*T);
z3=exp(p3*T);

%% Accion integral discreta

Aad=[Ad zeros(3,1);-Cd eye(1,1)];
Bad=[Bd;0];

Kaid=acker(Aad,Bad,[z1 z2 z3 exp(-200*T)]);
Kid=Kaid(4);
Kxd=Kaid(1,1:3);
Kd=acker(Ad,Bd,[z1 z2 z3]);
Krd=inv(Cd*((eye(3)-(Ad-Bd*Kd))\Bd));
%% Observador de estado discreto
polosOb=eig(A);
polosOb=polosOb*3;
polosOb(1)=polosOb(1)-50;
polosOb=polosOb';

polosObd=exp(polosOb*T);
Ld=place(Ad',(Cd*Ad)',polosObd)';
