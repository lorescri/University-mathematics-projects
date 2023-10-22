%ejercicio 3

%Escribe un programa que dada una función f , el intervalo de trabajo y los coeficientes
% a, b, c, d del spline construya una tabla con los máximos de los errores absolutos
% |f (x) − S(x)| en cada subintervalo.

%% FUNCION  splineErrorTabla.m en  ../biblioteca.

clc
clear all
clf 

%clf (2)
%clf (3)
%clf (4)
addpath ('../biblioteca')


% Se considera la función f (x) = x.^(5/2) definida en el intervalo [0, 1] del ejercicio 3 para prueba

%datos 
f=@ (x) x.^2.5;
I=[0,1];

nuNodos=11;
nutest=37; % numero de puntos de muestras para buscar máximos




xx=linspace(I(1),I(2),nuNodos);
aa=f(xx);

[b_1,c_1,d_1]=splineNatural(xx,aa);

tabla_errores=splineErrorTabla(f,xx,aa,b_1,c_1,d_1,25,true);

