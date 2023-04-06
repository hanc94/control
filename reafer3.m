%LINEALIZACION DEL LEVITADOR MAGNÉTICO
%CONSTRUCCION DE LA FUNCION DE TRANSFERENCIA

clear
clc
syms x1 x2 x3 u y %variables de estado,entrada y salida
R=2.8; %Ohm
Q=0.000608752; %Hm
a=0.00209976; %m
m=0.0568; %Kg
g=9.8; %m/s^2
L=0.0526; %H

x1e=0.02; %metros. posición deseada.
x2e=0;%velocidad
x3e=1;%A
ue=5; %V
%FUNCIONES EN VARIABLES DE ESTADO
f1=x2;
f2=g-(Q*x3^2)/(2*m*(a+x1)^2);
f3=u/L-(R/L)*x3;
ff=[f1 f2 f3];
%VARIABLES DE ESTADO
v=[x1 x2 x3];
%PUNTOS DE EQUILIBRIO PARA xe=1 SALIDA DESEADA
pe=solve('x2=0','g-(Q*x3^2)/(2*m*(a+x1e)^2)=0','(u/L-(R/L)*x3)=0',x2,x3,u);

x2e=eval(pe.x2);x3e=eval(pe.x3);%SE ELIGEN LOS VALORES DEL RANGO DE OPERACION
ue=eval(pe.u);
%JACOBIANIO CON RESPECTO A X,S,U
AA=jacobian(ff,v);
BB=jacobian(ff,u);
%EVALUO EN LOS PUNTOS DE EQUILIBRIO: también existen x1e x2e(2) x3e(2) ue(2)
%Revise cuales puntos se comportan mejor
A=subs(AA,{x1 x2 x3 u},{x1e x2e(1) x3e(1) ue(1)})
%CONVIERTO A REAL
A=double(A)
%EVALÚO LA MATRIZ B
B=subs(BB,{x1 x2 x3 u},{x1e x2e(1) x3e(1) ue(1)})
B=double(B)
C=[1 0 0]
D=0
%SISTEMA EN VARIABLES DE ESTADO
VE=ss(A,B,C,D)
%FUNCIÓN DE TRANSFERENCIA
G=tf(VE)
