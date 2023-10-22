% ejercicio 3

%Diseña un programa que halle las soluciones de una ecuación cuadrática ax^2 +bx+c = 0 cuando
%se le introducen los valores a, b y c y tenga en cuenta la cancelación substractiva. Comprueba
%tus programas para algunas ecuaciones de segundo grado cuya solución conozcas de antemano.

% cabecera
clc
clear all
format long g
addpath('../biblioteca')
%%%%

display('ejercicio 3')

a= 1

b= -2

c=0.1e-15

% código en la función solve_2grado.m en ../biblioteca

[x1,x2]=solve_2grado(a,b,c)

% si se quiere trabajar con aritmetica finita con redondeo en n dígitos
% se puede usar la función solve_2grado_fls.m en ../biblioteca

a=1

b=-2

c=10^(-6)

global n

n=4

[x1_fls,x2_fls]=solve_2grado_fls(a,b,c)


