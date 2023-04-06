%LINEALIZACION DE UN EVAPORADOR DOBLE EFECTO
%CONSTRUCCION DE LA FUNCION DE TRANSFERENCIA

clc
clear
syms x1 x2 u y pe
d1=0.5;
d2=0.3;
d3=0.25;
d4=-0.15;
d5=0.195;
c0=0.15;
F0=2;
%x1e=0.7;
x2e=0.8;
%FUNCIONES EN VARIABLES DE ESTADO
f1=d1*F0*(c0-x1)+d2*x1*u;
f2=d3*F0*(x1-x2)+(d4*x1+d5*x2)*u;
y=x2;
f=[f1 f2];
%VARIABLES DE ESTADO
v=[x1 x2];
%PUNTOS DE EQUILIBRIO PARA SALIDA DESEADA
pe=solve(d1*F0*(c0-x1)+d2*x1*u==0,d3*F0*(x1-x2e)+(d4*x1+d5*x2e)*u==0,x1,u);
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
% p=[-1 -2]%polos deseados de control
% o=[-3 -5]%polos deseados del observador
% K=place(A,B,p) %ganancias de control calculadas por place
% Kb=bass_gura(A,B,p)% ganancias de control calculadas por bass-gura
% Kr=-inv(C*inv(A-B*K)*B)%ganancia para la referencia 
% L=place(A',C',o)'%ganancias del observador

%FUNCIÓN DE TRANSFERENCIA
G=tf(VE)

%ANALISIS CON RLTOOL
sisotool(G)