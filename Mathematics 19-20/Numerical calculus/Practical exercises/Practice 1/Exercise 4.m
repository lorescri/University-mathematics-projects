% ejercicio 4

% a) Halla el valor de A = 3 5556 − 3 5555 trabajando en aritmética de 4 dígitos y redondeo
% simétrico, y con 8 dígitos y redondeo simétrico.
% b) Encuentra un algoritmo estable que permita el calculo de A sin perdida de cifras significa-
% tivas y utiliza ese algoritmo para calcular A trabajando en aritmética de 4 dígitos y redondeo
% simétrico, y con 8 dígitos y redondeo simétrico.
% c) Tomando como valor real A = 1.062665655226140e − 003 compara el número de dígitos
% significativos que tiene cada una de las aproximaciones anteriores.

% cabecera
clear 
clc
format long e
addpath('../biblioteca')
%%%%
display(' ejercicio 4')

global n;  %numero de digitos en redondeo


% datos

a=5556^(1/3);
b=5555^(1/3);

A_real= 1.062665655226140e-3

%apartados

%apartado a  usando double
A=a-b

% apartado b
numer=a^3-b^3;
den=a^2 + a*b +b^2;

A_sin_canc=numer/den

%apartado c
err_abs=abs(A_real-A_sin_canc)
err_rel=err_abs/abs(A_real)

display( ' con double hay 16 digitos de precision')

% con aritmética de 4 dígitos
n=4

a_fls=fls(a)
b_fls=fls(b)

%apartado a
A_fls=fls(a_fls -b_fls)

% apartado b
numer_fls=fls(fls(a_fls^3)-fls(b_fls^3));
den_fls=fls(fls(fls(a_fls^2) + fls(a_fls*b_fls)) +fls(b_fls^2));

A_fls_sin_canc=fls(numer_fls/den_fls)

%apartado c
err_abs_fls=abs(fls(A_real-A_fls_sin_canc))
err_rel_fls=err_abs_fls/abs(A_real)

display( ' con 4 digitos no hay digitos de precision')

% con aritmética de 8 dígitos
n=8

a_fls=fls(a)
b_fls=fls(b)

%apartado a
A_fls=fls(a_fls -b_fls)
% apartado b
numer_fls=fls(fls(a_fls^3)-fls(b_fls^3));
den_fls=fls(fls(fls(a_fls^2) + fls(a_fls*b_fls)) +fls(b_fls^2));

A_fls_sin_canc=fls(numer_fls/den_fls)

%apartado c
err_abs_fls=abs(fls(A_real-A_fls_sin_canc))
err_rel_fls=err_abs_fls/abs(A_real)

display( ' con  digitos  hay 3-4 digitos de precision')



