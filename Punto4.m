%% Parte a

syms t a s; %simbolicas t para tiempo, a para tao y s para laplace


Aa=[0 1;1 1];
Ba=[1;0];

Psa=s*eye(2)-Aa %se halla SI-A
PsIa=inv(Psa)
%solucion homogenea
eata=simplify(ilaplace(PsIa)) % se halla exp(at)

neata=subs(eata,t,(t-a)) %se sustituye t por t-tao

piaba=neata*Ba %matriz para integrar

%integracion de cada fila
x1inta=simplify(int(piaba(1),a,0,t)) 

x2inta=simplify(int(piaba(2),a,0,t))

%solucion particular de a
particulara=[x1inta;x2inta]

%% Parte b

Ab=[-3 1 0;-2 0 0;1 0 0];
Bb=[2;4;1];

Psb=s*eye(3)-Ab %SI-A
PsIb=inv(Psb)
%solucion homogenea 
eatb=simplify(ilaplace(PsIb))% exp(At)

neatb=subs(eatb,t,(t-a)) %se sustituye t por t-tao

piabb=neatb*Bb %matriz para integrar 

%integracion de cada fila 
x1intb=simplify(int(piabb(1),a,0,t))

x2intb=simplify(int(piabb(2),a,0,t))

x3intb=simplify(int(piabb(3),a,0,t))
%solucion particular
particularb=[x1intb;x2intb;x3intb]