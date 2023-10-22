clear all
clc
addpath('../Matrices')

disp('Ejercicio 5.3')

disp('Vamos a probar la funcion QRTRid.m con ')
%Damos un valor inicial n
n=3
%n=6
%n=8

%Creamos una matriz A aleatoria simetrica usando la funcion symmetricMat.m
A=symmetricMat(n);

%La hacemos tridiagonal con el metodo tridQHouseholder.m
[Q,T]=tridQHouseholder(A);
disp('Hacemos la prueba utilizando la matriz simetrica tridiagonal: ')
T
disp('La factorizacion QR de la matriz T es:') 
[Q,R]=QRTRid(T);

%Como resultado obtenemos dos matrices Q,R cuyo producto, Q*R,  nos debe dar T

























rmpath('../Matrices')
