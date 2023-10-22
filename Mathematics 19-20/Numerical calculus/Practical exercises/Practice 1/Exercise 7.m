%ejercicio 7
%Determina el mayor y menor número máquina positivo cuando se trabaja con doble precisión.
%Compara con los comandos realmax y realmin.

%% cabecera
clc
clear all

format long g
%%


real_maximo= realmax

%% en double IEEE-754 se usan 64 dígitos:
%% 1 digito para el signo en base 2
%% 52(+1) mantisa en base 2 (el primero en double siempre es 1 y no se almacena)
%% 11 digitos para el exponente (base 2)

%% exponente_max=1024 o 1023
%% exponente_min=-1023 o -1024

%% probamos los dos y comprobamos que es
exponente_max=1023

%% calculamos la mantisa mayor  1111....1111
mantisa_mayor=1;
for i=1:52
  mantisa_mayor += 2^(-i);
end
mantisa_mayor
display(' OJO la representación es el redondeado a base 10 no el número en base 2')
display(' si preguntamos mantisa_mayor==2, la respuesta es 0=false')
mantisa_mayor== 2


maximo=mantisa_mayor* 2^exponente_max

display(' por reforzar la afirmación anterior si hacemos 2*2^exponente_max, el resultado es:')
2*2^exponente_max

fprintf('\n \n \n')
% hacemoslo mismo con minimo positivo


real_minimo= realmin
 
%% en double IEEE-754 se usan 64 dígitos:
%% 1 digito para el signo en base 2
%% 52(+1) mantisa en base 2 (el primero en double siempre es 1 y no se almacena)
%% 11 digitos para el exponente (base 2)

%% exponente_max=1024 o 1023
%% exponente_min=-1023 o -1024

%% probamos los dos y comprobamos que es
exponente_min=-1024

min_1= 1*2^exponente_min

exponente_min=-1023

min_2= 1*2^exponente_min

%% calculamos la mantisa mayor  1111....1111
mantisa_mayor=1;
for i=1:52
  mantisa_mayor += 2^(-i);
end
mantisa_mayor

min_3=mantisa_mayor* 2^exponente_min


display(' Hemos encontrado doubles menores que realmin')
display(' revisa en la documentación de IEEE double (English) el concepto de numero subnormal')

