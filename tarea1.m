A=[0 1 0;0 0 1;-2 -4 -6];%matriz A
B=[0;0;1];%matriz B
C=[1 2 3];%matriz C
D=0;
VE=ss(A,B,C,D);%sistema
G=tf(VE);%funcion de transferencia
step(VE)%grafica