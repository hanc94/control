m = 1 ;
b = 0;
k=0.3;
u=10;

A=[0 1; -k/m -b/m]
B=[0; u/m]
C=[1 1];
D=0;
sis1=ss(A,B,C,D)
step(sis1)

%% 0<b<1

b=0.5;

A=[0 1; -k/m -b/m]
B=[0; u/m]
C=[1 1];
D=0;
sis2=ss(A,B,C,D)
figure
step(sis2)

%% b=1

b=1;

A=[0 1; -k/m -b/m]
B=[0; u/m]
C=[1 1];
D=0;
sis3=ss(A,B,C,D)
figure
step(sis3)
%% b>1

b=10;

A=[0 1; -k/m -b/m]
B=[0; u/m]
C=[1 1];
D=0;
sis4=ss(A,B,C,D)

figure
step(sis4)
