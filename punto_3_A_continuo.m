
A=[0 -316.2;316.2 -1666.7];
B=[530.3;-2795.2];
C=[0 1];
D=0;
wo=1.5811e3;
w1=1.6667e3;
b=106.066;

Mp=0.1;
ts=2.5;
sita= (sqrt((log(Mp))^2))/(sqrt((pi^2)+((log(Mp))^2)));
wn=4.6/(sita*ts);
p1=-sita*wn+1i*wn*sqrt(1-sita^2);
p2=-sita*wn-1i*wn*sqrt(1-sita^2);
T=1/(10*sita*wn);
CC=ctrb(A,B);
controlabilidad=det(CC);
vec=ss(A,B,C,D);

%% polo adicional al sistema

Aa=[A zeros(2,1);-C 0];
Ba=[B;0];

Kai=acker(Aa,Ba,[p1 p2 -50]);

K=acker(A,B,[p1 p2]);
Kr=-1/(C*inv(A-B*K)*B);
%% Observador de estado continuo

polosOb=eig(A);
polosOb=polosOb*3;
polosOb=polosOb';

L=place(A',C',polosOb)';

