clc; clear
%Doble integrador continuo
A=[0 1; 0 0]
B=[0;1]
C=[1 0]
D=0
%Estructura de variables de estado
vec=ss(A,B,C,D)
%Variables de estado Discretas
ved=c2d(vec,0.1)
%Matrices del sistema discreto x(k+1)=Adx(k)+Bdu(k); y(k)=Cdx(k)
Ad=ved.a
Bd=ved.b
Cd=ved.c
Dd=ved.d
%Sistema ampliado discreto para incluir la acci�n integral
Aa=[Ad zeros(2,1);-Cd eye(1,1)]
Ba=[Bd;zeros(1,1)]
Ca=[Cd zeros(1,1)]
Da=Dd
CT=Cd*Ad
%Nuevo sistema ampliado
vea=ss(Aa,Ba,Ca,Da,0.1)
%verificaci�n la controlabilidad del nuevo sistema ampliado
CC=ctrb(vea)
%Autovalores deseados discretos. Igual conversi�n que en control cl�sico
z1=exp((-1+1*j)*0.1)
z2=exp((-1-1*j)*0.1)
z3=exp(-5*0.1) %Polo adicional cinco veces m�s r�pidos que los polos deseados
p=[z1 z2 z3]
K=bass_gura(Aa,Ba,p)% C�lculo de la ganancia del controlado
Kx=K(1,1:2)% Ganancias de retroalimentaci�n para las variables de estado
KI=K(3) % Ganancia de retroalimentaci�n para el error.
Kr=inv(Cd*((eye(2)-(Ad-Bd*Kx))\Bd)) %Ganancias para compensar el error de estado estable discreto

%Observador discreto
pdc=[-4 -5] %polos del observador de estados
pdd=exp(pdc*0.1)% conversi�n de los polos continuos a discreto
Ld=place(Ad',Cd',pdd)'
LdT=place(Ad',CT',pdd)' % C�lculo de las ganancias del observador
