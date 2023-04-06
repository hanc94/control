clc
clear all

syms x1 x2 u y pe
wo=1.5811e3;
w1=1.6667e3;
b=106.066;
ue=0.8;
%FUNCIONES EN VARIABLES DE ESTADO
f1=-wo*x2+u*wo*x2+b;
f2=wo*x1-w1*x2-u*wo*x1;
y=x2;
f=[f1 f2];
%VARIABLES DE ESTADO
v=[x1 x2];
%PUNTOS DE EQUILIBRIO PARA SALIDA DESEADA
pe=solve(-wo*x2+ue*wo*x2+b==0,wo*x1-w1*x2-ue*wo*x1==0,x1,x2);
x1e=eval(pe.x1);
x2e=eval(pe.x2);%SE ELIGEN LOS VALORES DEL RANGO DE OPERACION
%JACOBIANIO CON RESPECTO A X,S,U
AA=jacobian(f,v);
BB=jacobian(f,u);
%EVALUO EN LOS PUNTOS DE EQUILIBRIO
A=subs(AA,{x1 x2 u},{x1e x2e ue});
%CONVIERTO A REAL
A=double(A);
B=subs(BB,{x1 x2 u},{x1e x2e ue});
B=double(B);
C=[0 1];
D=0;
%SISTEMA EN VARIABLES DE ESTADO
VE=ss(A,B,C,D);
CC=ctrb(VE);
rank(CC);

%FUNCIÓN DE TRANSFERENCIA
G=tf(VE);
Mp=0.1;
ts=2;
sita= (sqrt((log(Mp))^2))/(sqrt((pi^2)+((log(Mp))^2)));
wn=4.6/(sita*ts);
l1=-sita*wn+1i*wn*sqrt(1-sita^2);
l2=-sita*wn-1i*wn*sqrt(1-sita^2);
T=1/(10*sita*wn);
CC=ctrb(A,B);
controlabilidad=det(CC);
vec=ss(A,B,C,D)

%% Ley de control continua
K=acker(A,B,[l1 l2]);
Kr=-1/(C*inv(A-B*K)*B);
%% Sistema discreto
VEd=c2d(vec,T);
Ad=VEd.a;
Bd=VEd.b;
Cd=VEd.c;
Dd=VEd.d;
z1=exp(l1*T);
z2=exp(l2*T);
%% Ley de control discreta
Kd=acker(Ad,Bd,[z1 z2]);
Krd=inv(Cd*((eye(2)-(Ad-Bd*Kd))\Bd));