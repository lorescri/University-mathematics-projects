% Ejercicio 1

%Construye un programa en Matlab que realice el redondeo simétrico a un número fijo de dígitos
%(llámalo fls.m). Nota: En Octave/Matlab se puede utlilizar el comando “eval(mat2str(x,n)”
%siendo n una variable global.

% ver función fls.m en ../biblioteca


clc
clear all
format long g

addpath('../biblioteca')

global n     % digitos en mantisa - declaración necesaria para usar fls.m

n=10

% fls con un numero real en el argumento
pi 
fl_pi = fls(pi)

% fls con un numero complejo en el argumento
z= pi + log(2)*i
fl_z=fls(z)

% fls con una matriz en el argumento
x=[e,pi,3.27]
fl_x=fls(x)