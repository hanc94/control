clc
clear all

A=[0 1 0;0 -0.9917 34850;0 -3.6365 -1791];
B=[0;0;86.95];
C=[1 0 0];
D=0;
Mp=0.05;
ts=1;
sita= (sqrt((log(Mp))^2))/(sqrt((pi^2)+((log(Mp))^2)));
wn=4.6/(sita*ts);
l1=-sita*wn+1i*wn*sqrt(1-sita^2);
l2=-sita*wn-1i*wn*sqrt(1-sita^2);
p3=-50;
T=1/(10*sita*wn);
CC=ctrb(A,B);
controlabilidad=det(CC);
vec=ss(A,B,C,D);


%% Accion integral continua

Aa=[A zeros(3,1);-C 0];
Ba=[B;0];

Kai=acker(Aa,Ba,[l1 l2 p3 -20]);
K=acker(A,B,[l1 l2 p3]);
Kr=-1/(C*inv(A-B*K)*B);


%% Observador de estado continuo

polosOb=eig(A);
polosOb=polosOb*3;
polosOb(1)=polosOb(1)-50;
polosOb=polosOb';

L=place(A',C',polosOb)';

