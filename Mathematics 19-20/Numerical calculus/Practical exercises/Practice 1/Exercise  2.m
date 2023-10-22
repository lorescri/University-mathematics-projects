%Ejercicio 2    (codificación UTF-8)
%    Trabajando en aritmética con siete dígitos y redondeo simétrico comprobar que si 
%  a = 0.5234563,  b = 0.5711321 y c = -0.5988678 entonces
%                         (a ⊕ (b ⊕ c))  ~= ( (a ⊕ b) ⊕ c).

%cabecera tipo para ejercicios
clc
clear all
format long g
addpath('../biblioteca')
%%%%

display('Ejercicio 2')


global n
n=7

a=0.5234563
b=0.5711321
c=-0.5988678

a_mas_b= fls(a+b);
suma1=fls(a_mas_b+c)

b_mas_c= fls(b+c);
suma2=fls(a+b_mas_c)

% suma1 difiere de suma ?  1=true  0=false 
if suma1 ~= suma2
 display('suma1 es distinto de suma2')
else
 display('suma1 es igual a suma2')
end