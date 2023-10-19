clear all
clc
addpath('../Matrices')

disp('Ejercicio 5.1')

%Utilizamos las matrices aleatorias de m filas, n columnas y rango r (para distintos valores) 
n=7;
m=6;
r=4;
%Generamos la matriz aleatoria:
A=rand(r,r);
%Aplicamos GramSchmidt.m para obtener la factorizacion QR DE A, siendo Q una matriz ortogonal y R triangular suerior
[Q,R]=GramSchmidt(A);

%Para asegurarnos de que Q tiene m filas y r columnas hacemos lo siguiente:
controlrmax=(r==size(Q)(2));
if r<m
Q=[Q;rand(m-r,r)];
end
U=triu(rand(r,n));  %U es una matriz de dimension rxn

disp('Probamos la funcion nucleo.m con la matriz:')
B=Q*U  %Al hacer el producto Q*U obtenemos una matriz B de dimension mxn

disp('La matriz N que hemos hallado utilizando la funcion nucleo.m sobre B es:')
N=nucleo(B)
%Como resultado obtendremos la matriz N, cuyas columnas son los vectores que forman la base del nucleo de Q*K



rmpath('../Matrices')