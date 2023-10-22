% ejercicio 5

% Trabajando con aritmética de 8 dígitos y redondeo simétrico aproxima la suma de los 10 4
% primeros términos de la serie
%  SUMA_(k=1 hasta 10000) 1 / k^2 
% Suma los términos de grandes a pequeños y de pequeños a grandes. Controla el tiempo de
% ejecución con los comandos tic,toc.
% Determina el número de cifras significativas exactas de las aproximaciones anteriores tomando
% como valor exacto de la suma pi^2/6 %%%el que se obtiene con doble precisión.%%%  

% cabecera
clear all
clc
format long
addpath('../biblioteca')
%%%%

display(' ejercicio 5')

global n;

num_sum= 10^4  %probad con menos primero

sum_decr=0; %decrecen los sumandos, de grandes a pequeños
sum_crec=0; %crecen los sumandos, de pequeños a grandes

suma_real=pi^2/6

% en doble precisión
tic
for k=1:num_sum
  sum_decr = sum_decr + 1/k^2;
end  
toc
sum_decr
error_relat_decr=abs(sum_decr-suma_real)/suma_real
display(' con doubles en suma de mayor a menor hay 4-5 dígitos de precisión')


tic
for k=num_sum:-1:1
  sum_crec = sum_crec + 1/k^2;
end 
toc 
sum_crec
error_relat_crec=abs(sum_crec-suma_real)/suma_real
display(' con doubles en suma de menor hay 4-5 dígitos de precisión')
% calculos con 8 dígitos

n=8

sum_decr_fls=0; %decrecen los sumandos
sum_crec_fls=0; %crecen los sumandos

suma_real=pi^2/6

% en doble precision
tic
for k=1:num_sum
  sum_decr_fls = fls(sum_decr_fls + fls(1/fls(k^2)));
end 
toc 
sum_decr_fls

error_relat_decr=abs(sum_decr_fls-suma_real)/suma_real
display(' con 8 dígitos en suma de mayor a menor hay 4 dígitos de precisión')

tic
for k=num_sum:-1:1
  sum_crec_fls = fls(sum_crec_fls + fls(1/fls(k^2)));
end 
toc 
sum_crec_fls
error_relat_crec=abs(sum_crec_fls-suma_real)/suma_real
display(' con 8 dígitos en suma de menor a mayor hay 4-5 dígitos de precisión')

  

