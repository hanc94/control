clc; clear
A=[0 1; 0 0]
B=[0;1]
C=[1 0]
D=0
vec=ss(A,B,C,D)
pd=[-3 -2]
L=bass_gura(A',C',pd)'
L1=acker(A',C',pd)'
L2=place(A',C',pd)'
%L=[3;2]
