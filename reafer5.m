%LINEALIZACION DE UN BIORREACTOR (HEMOSTAT)
%CONSTRUCCION DE LA FUNCION DE TRANSFERENCIA

clc
clear
syms x1 x2 u y pe
P=0.04;
Q=0.7;
a=0.3;
b=0.5;
x1e=0.7;
x2e=0.6285;
%FUNCIONES EN VARIABLES DE ESTADO
f1=u+P-(x1*x2)/(x1+Q)+a*x2;
f2=-b*x2+(x1*x2)/(x1+Q);
y=x2;
f=[f1 f2];
%VARIABLES DE ESTADO
v=[x1 x2];

%PUNTOS DE EQUILIBRIO PARA SALIDA DESEADA
pe=solve(u+P-(x1*x2e)/(x1+Q)+a*x2e==0,-b*x2e+(x1*x2e)/(x1+Q)==0,x1,u);
x1e=eval(pe.x1);ue=eval(pe.u);%SE ELIGEN LOS VALORES DEL RANGO DE OPERACION

%JACOBIANIO CON RESPECTO A X,S,U
AA=jacobian(f,v);
BB=jacobian(f,u);

%EVALUO EN LOS PUNTOS DE EQUILIBRIO
A=subs(AA,{x1 x2 u},{x1e x2e ue})
%CONVIERTO A REAL
A=double(A)
B=subs(BB,{x1 x2 u},{x1e x2e ue})
B=double(B)
C=[0 1]
D=0

%SISTEMA EN VARIABLES DE ESTADO
VE=ss(A,B,C,D)
CC=ctrb(VE)
rank(CC)

%CONTROL
p=[-1 -2]% polos deseados del control
o=[-3 -5]% polos deseados del observador
K=place(A,B,p)
Kr=-inv(C*inv(A-B*K)*B)
L=place(A',C',o)'

%FUNCIÓN DE TRANSFERENCIA
G=tf(VE)

%ANALISIS CON RLTOOL
sisotool(G)