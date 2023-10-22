% Ejercicio 3
% cabecera
clc
clear
clf ('reset')


% Dibuja las funciones f (x) = (x -1)^4 y g(x) = 1-4x +6x^2 - 4x^3 +x^4 para
% x en  [1-3e-4 , 1+3e-4] . 
%Utiliza los comandos linspace y plot . Saca conclusiones.

display('Este ejercicio sólo muestra dos gráficas en la Figura 1')

npuntos = 127;   % número de puntos para la gráfica

f = @(x) (x-1).^4;  % función f

%g= @(x) 1-4*x + 6*x.^2 - 4*x.^3 + x.^4; % esta sería la definición del polinomio
                      % como función. Octave/Matlab llevan metodos específicos para polinomios
                      % los polinomios se definen por la lista de coeficientes
                      % ordenando los sumandos con potencias decrecientes
                      % Ejemplo: si p=a2 x^2 + a1 x + a0   se pone p=[a2, a1, a0]
pg = [1,-4,6,-4,1];  %coeficientes del polinomio 
                             
%polyval(pg,t) -> g(t)   es el comando para evaluar el polinomio pg en el punto (o lista) t
a = 1-3e-4;
b = 1+3e-4;
t=linspace(a,b,npuntos); %genera un vector fila con npuntos equiespaciados entre a y b

plot(t,f(t),t,polyval(pg,t)) % representa las poligonales de abcisas t y ordenadas f(t) y g(t)
title(' graficas de f(x) y g(x) que deberian de coincidir')
legend('(x -1)^4','1-4x +6x^2 - 4x^3 +x^4')


fprintf('\n El polinomio presenta mas oscilaciones en la grafica por que en su evaluación\n hay más cancelaciones que en las evaluaciones de la función f');