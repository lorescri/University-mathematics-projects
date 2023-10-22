%ejercicio 8


%Calcula el épsilon de la máquina. Para ello, calcular 1 + x con x = 2 −n para n = 1, 2, . . .,
%mientras que 1 + x > 1. Comparar con el comando eps de Matlab.

%cabecera
clc
clear all
format long e
%
display('ejercicio 8')

display(' epsilon de la maquina Matlab/octave, eps')
epsilon_double=eps

% menor positivo tal que 1+x > 1

%primera opcion el siguiente numero al 1, el primero que es mayor que el
% en formato double IEEE-754  tiene por mantisa
% el 1 (que no se guarda)  51 ceros y un 1 en base 2  y es 1+2^(-52)

% al hacer redondeo simetrico 1+x sera 1 si 1+x es menor  al valor medio entre
% 1 y 1+2^(-52)

% probamos con x=2^(-53) donde 1+x es justo el valor medio entre los dos
display(' con x=2^(-53), 1+x>1 es falso ')
x=2^(-53)
1+x > 1

display(' con x= al siguiente a 2^(-53), 1+x >1 es verdadero ')
x=2^(-53)*(1+2^(-52))
1+x > 1

fprintf('el menor double positivo x tal que 1+x >1 es x=2^(-53)*(1+2^(-52))=%e\n\n',x)



%% segunda opción como lo calcula octave/matlab y como se dice en el enunciado

display(' calculo segun el enunciado')

x_e=1;
seguir = true;
while seguir
  if( 1+x_e >1)
   x_e= x_e/2;
  else
   x_e=2*x_e;
   seguir=false;
  end
 end
x_e

display( ' x_e == 2^(-52)  (verdadero):')
x_e == 2^(-52)

display( ' 1+x == 1+x_e (verdadero):')
1+x == 1+x_e

display(' en octave/Matlab el eps es x_e, la menor potencia de 2, tal que 1+x_e>1')

