%Ejercicio 1 
clear all
clc

addpath('../Matrix')
%Apartado 1
%Al igual que en el ejercicio 3 de la entega anterior, vamos a comenzar  creando
% una matriz tridiagonal simetrica:
%Damos un valor inicial n
n=3

%Creamos una matriz A aleatoria simetrica usando la funcion symmetricMat.m
A=symmetricMat(n);

%La hacemos tridiagonal con el metodo tridQHouseholder.m
[Q,T]=tridQHouseholder(A);
disp('Hacemos la prueba utilizando la matriz simetrica tridiagonal: ')
% Mostramos solo la matriz que nos interesa T:
T
%Ponemos numero maximo de iteraciones
nmaxit=100;

%[vp,V,iter,control] = QRPropios (T,nmaxit)
[vp,V,iter,control] = QRTRid (T,nmaxit)










rmpath('../Matrices')


