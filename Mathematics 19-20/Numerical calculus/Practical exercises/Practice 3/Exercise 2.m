% ejercicio 2
% cabecera
clc
clear all
addpath('../biblioteca')

format long g

%% APARTADO a)
% Complete la siguiente tabla de diferencias divididas:
%    x          f [.]        f [., .]         f [.,.,  .]              f [.,.,.,.]
%   0.3    0.97741        
%   0.37  0.96557        *                    
%   0.41  0.95766        *                    *
%   0.52  0.93157        *                    *        −0.012790239

x=[0.3 , 0.37, 0.41, 0.52];
y=[0.97741, 0.96557, 0.95766, 0.93157];

dif_div_1=diferencias_divididas(x,y);

%%La tabla de diferencias divididas es:
%%          f[.]            f[..]                  f[...]
%%  0.97741  0  0  0
%%  0.96557  -0.1691428571428566  0  0
%%  0.95766  -0.1977500000000022  -0.2600649350649604  0
%%  0.93157  -0.2371818181818176  -0.2628787878787693  -0.01279024006276805

% Evalúe en 0.47 el polinomio P 3 (x) de grado ≤ 3 que interpola a f (x) en los
% puntos de la tabla anterior. Compare con el valor correctamente redondeado:
% f (0.47) = 0.94423.

p_3=coef_polinomio_interpolador(dif_div_1,x);

%% EN OCTAVE (comentar si usas Matlab) polinomio interpolador en forma normal
p_3_x_string = polinomio_Lagrange= polyout(p_3, 'x')

%% p_3_x = -0.01279*x^3 - 0.24625*x^2 + 0.00016745*x^1 + 0.99987

%% EN MATLAB Y EN OCTAVE_EXEC_HOME polinomio interpolador en forma de Newton
p_3_x_string = polinomio_interpolador_Newton(dif_div_1,x)

x0= 0.47;

p_3_x0=polyval(p_3,x0)
%% p_3_x0 = 0.944221564344746

err_rel_x0=abs(0.94423- p_3_x0)/0.94423
%% err_rel_x0 = 8.933898789480356e-06

%% El error relativo indica al menos 5 dígitos de precisión
%% Como los datos iniciales sólo tienen 5 dígitos, la aproximación es
%% muy aceptable.

%% APARTADO b)
% Añada al final de la tabla del apartado (a) un nuevo punto x = 0.47 con el
% valor f (0.47) = 0.94423. Determine el polinomio P 4 (x) que interpola a f (x)
% en esta nueva tabla ampliada mediante una sencilla modificación de P 3 (x).
% ¿Serían los cálculos tan sencillos si el nuevo dato se añadiese en el lugar que le
% correspondiera en la tabla?.
display(' Añadimos un nodo más a la interpolación')

%% Si lo hicieramos a mano, trabajariamos añadiendo una nueva linea al final de la tabla
%% de las diferencias divididas, hariamos 4 diferencias nuevas y con el ultimo termino de l
%% la diagonal calculado añadiriamos un sumando más a la forma de Newton del polinomio
%% interpolador o un factor más su forma anidada (comparar más abajo las salidas de la funcion 
%% polinomio_interpolador_Newton)
%% Si el dato se añadiera situado en una nueva fila entre la tercera y cuarta fila del diagarama 
%% para volver a llenar el diagrama habría que hacer 7 diferencias nuevas, modificar un sumando
%% y añadir uno nuevo para tener la forma de Newton del nuevo polinomio interpolador

%% Como los calculos los vamos a hacer con diferencias_divididas.m para nosotros no tiene ninguna
%% diferencia el modificar la listas de nodos en una u otra posicion

x5=[x,0.47]
y5=[y  0.94423]

dif_div_2=diferencias_divididas(x5,y5);

%%La tabla de diferencias divididas es:
%%          f[.]            f[..]                  f[...]
%%  0.97741  0  0  0  0
%%  0.96557  -0.1691428571428566  0  0  0
%%  0.95766  -0.1977500000000022  -0.2600649350649604  0  0
%%  0.93157  -0.2371818181818176  -0.2628787878787693  -0.01279024006276805  0
%%  0.94423  -0.2531999999999999  -0.2669696969697044  -0.04090909090935069  -0.1654050049798979

p_3_x_string = polinomio_interpolador_Newton(dif_div_1,x)

%% p_3_x_string = 0.97741+(x-0.3)*(-0.169142857142857+(x-0.37)*(-0.26006493506496+(x-0.41)*(-0.012790240062768)))

p_4_x_string = polinomio_interpolador_Newton(dif_div_2,x)

%% p_4_x_string = 0.97741+(x-0.3)*(-0.169142857142857+(x-0.37)*(-0.26006493506496+(x-0.41)*(-0.012790240062768+(x-0.52)*(-0.165405004979898))))