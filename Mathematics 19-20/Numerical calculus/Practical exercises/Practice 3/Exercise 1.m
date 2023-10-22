% Ejercicio 1
%Lee los ficheros diferencias_divididas.m, polinomio_interpolador_Newton.m
%y coef_polinomio_interpolador.m deduce que hace cada uno de ellos. Compara
%con la función polyfit(x,y,n)

%% Los ficheros están colocados en la carpeta biblioteca

%cabecera
clc
clear all
addpath('../biblioteca')

format short g

% diferencias_divididas(x,y)   
%% Ejemplo: 6 puntos de la gráfica de sin(x)+cos(2x)
n=5; %grado del polinomio
x=linspace(-pi,pi,6); % 6 abscisas equiespaciadas entre -pi y p
y=sin(x)+cos(2*x);

difdiv_ejem=diferencias_divididas(x,y);


%% IMPRIME en la consola la tabla de las diferencias divididas
%% que interpolan los puntos (x(k),y(k)) descritos por los vectores
%% fila x e y que son los argumentos de la funcion y que tienen que tener la 
%% misma longitud (n+1).
%% DEVUELVE la matriz de dimensión (n+1)x(n+1) con las diferencias divididas. En la diagonal de
%% la matriz están los coeficientes del polinomio interpolador en la forma de Newton 

%% coef_polinomio_interpolador(difdiv,x)

pol_int_ejem=coef_polinomio_interpolador(difdiv_ejem,x)

%% Calcula el polinomio interpolador a partir de la forma de Newton de grado maximo 
%% a partir de una tabla de diferencias divididas. 
%% El polinomio interpolador viene expresado en la forma a_n*x^n+...+a_1*x+a_0
%% Los polinomios en Matlab/Octave se identifican con el vector fila de sus coeficientes, el vector [a_n a_n-1 ...a_1 a_0]. Esta es la SALIDA de la función
%% En el codigo de la función se usan las funciones de octave/Matlab: poly(x(k-1)) que devuelve el 
%% polinomio caracteristico de la matriz A para determinar los monomios (X-x(k))== [1,x(k-1)]
%% En los pasos de la suma anidada al vector pol se le suma un vector fila de la misma longitud con 
%% todos los terminos nulos excepto el último que es la anterior diferencia dividida. Después se usa la 
%% funcion conv(p,q) que devuelve el producto de dos polinomios (es un producto de convolucion)

%% SOLO EN OCTAVE se puede usar la funcion polyout para imprimir el polinomio en la forma normal
%% esta función no está en Matlab, alli es una variable y puede dar problemas.
  polinomio_Lagrange= polyout(pol_int_ejem, 'x')
  
%% PARA MATLAB y TAMBIEN OCTAVE se puede usar
%% polinomio_interpolador_Newton(difdiv,x)
%% que escribe el polimio en la forma anidada de Newton 
%% en una cadena de caracteres.Solo DEVUELVE la cadena de caracteres
  
  polinomio_Lagrange=polinomio_interpolador_Newton(difdiv_ejem,x)
 
 
 %%p = polyfit(x,y,n) devuelve los coeficientes para un polinomio p(x) de grado n que es la mejor 
 % solución (en el sentido de los mínimos cuadrados) para los datos de y. Los coeficientes de p están 
 % en  potencias descendentes y la longitud de p es n+1.
%
%x es la lista de abscisas (vector fila) e y la lista de ordenadas, de los puntos a "aproximar", el número de puntos debe ser estrictamente mayor que n.
%
%si hay (n+1) puntos, con abscisas distintas, dos a dos, p(x) es el polinomio interpolador de Lagrange, 
% En otro caso es la mejor aproximación para la distancia definida como suma de cuadrados 
% sum(|y-polyval(p,x)|.^2) (lo veremos en Numérico Matricial)

pol_aprox_ejem= polyfit(x,y,n)

Coinciden_polinomios= (pol_int_ejem==pol_aprox_ejem)
%% Aunque aparentemente (ver los coeficientes que muestran) coinciden,
%% los metodos utilizados por nuestra funcion y polyfit no están implementados de la misma forma
%% y dan resultados casi identicos pero no son iguales (solo el termino independiente)
%% Cambia el formato a long si quieres comparar con precision.
