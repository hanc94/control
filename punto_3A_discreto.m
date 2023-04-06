
A=[0 -316.2;316.2 -1666.7];
B=[530.3;-2795.2];
C=[0 1];
D=0;
wo=1.5811e3;
w1=1.6667e3;
b=106.066;

Mp=0.1;
ts=2;
sita= (sqrt((log(Mp))^2))/(sqrt((pi^2)+((log(Mp))^2)));
wn=4.6/(sita*ts);
l1=-sita*wn+1i*wn*sqrt(1-sita^2);
l2=-sita*wn-1i*wn*sqrt(1-sita^2);
T=1/(10*sita*wn);
CC=ctrb(A,B);
controlabilidad=det(CC);
vec=ss(A,B,C,D);

%% Sistema discreto
VEd=c2d(vec,T);
Ad=VEd.a;
Bd=VEd.b;
Cd=VEd.c;
Dd=VEd.d;
z1=exp(l1*T);
z2=exp(l2*T);

%% Accion integral discreta

Aad=[Ad zeros(2,1);-Cd eye(1,1)];
Bad=[Bd;0];

Kaid=acker(Aad,Bad,[z1 z2 exp(-80*T)]);

Kd=acker(Ad,Bd,[z1 z2]);
Krd=inv(Cd*((eye(2)-(Ad-Bd*Kd))\Bd));



%% Observador de estado discreto
polosOb=eig(A);
polosOb=polosOb*3;
polosOb=polosOb';

polosObd=exp(polosOb*T);
Ld=place(Ad',(Cd*Ad)',polosObd)';