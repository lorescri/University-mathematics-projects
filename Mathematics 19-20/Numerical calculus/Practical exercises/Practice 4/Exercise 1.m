% ejercicio 1
% Un automóvil realiza un recorrido en una carretera recta y
%% se cronometra la distanciarecorrida y la velocidad en distintos momentos, 
%% con los siguientes resultados:
%% Tiempo (segundos)0   3    5 9    12
%% Distancia (metros)0   99  165  290  380
%% Velocidad (metros/segundo)30  33   30   25   33
%% Utiliza interpolación de Hermite para predecir la 
%% distancia recorrida y la velocidadent= 10segundos 
%% y estima la cota de error.

clc
clear all
addpath ('../biblioteca');

%datos

xx=[0,0,3,3,5,5,9,9,12,12]
ff=[0,0,99,99,165,165,290,290,380,380]
difdiv_2=[30, 33, 33, 33, 30,31.25,25,30,33]

dif_div=diferencias_divididas_Hermite(xx,ff,difdiv_2);

%%La tabla de diferencias divididas es:
%%     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000
%%     0.00000    30.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000
%%    99.00000    33.00000     1.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000
%%    99.00000    33.00000     0.00000    -0.33333     0.00000     0.00000     0.00000     0.00000     0.00000     0.00000
%%   165.00000    33.00000     0.00000     0.00000     0.06667     0.00000     0.00000     0.00000     0.00000     0.00000
%%   165.00000    30.00000    -1.50000    -0.75000    -0.15000    -0.04333     0.00000     0.00000     0.00000     0.00000
%%   290.00000    31.25000     0.31250     0.30208     0.17535     0.03615     0.00883     0.00000     0.00000     0.00000
%%   290.00000    25.00000    -1.56250    -0.46875    -0.12847    -0.05064    -0.00964    -0.00205     0.00000     0.00000
%%   380.00000    30.00000     1.66667     0.46131     0.13287     0.02904     0.00885     0.00154     0.00030     0.00000
%%   380.00000    33.00000     1.00000    -0.22222    -0.09765    -0.03293    -0.00689    -0.00175    -0.00027    -0.00005


pol_9=coef_polinomio_interpolador(dif_div,xx);
% polyout(pol_9);
t=10
posicion_10=polyval(pol_9,t)
pol_der=polyder(pol_9)
derivada_10=polyval(pol_der,t)


% los resultados no parecen muy fiables (derivada) y no tenemos información para estimar errores
% ALTERNATIVA Usar información de puntos proximos

XX_prox=[9, 9 , 12 , 12]
FF_prox=[290,290,380,380]
dif_div_prox_2=[ 25, 30, 33]

dif_div_prox=diferencias_divididas_Hermite(XX_prox,FF_prox,dif_div_prox_2);

pol_3=coef_polinomio_interpolador(dif_div_prox,XX_prox)
posicion_10=polyval(pol_3,t)
% posicion_10 =  317.11
pol_der_2=polyder(pol_3)

derivada_10=polyval(pol_der_2,t)
% derivada_10 =  29.000

% error en posición es del orden de f^(4)/4! Prod (10-XX(i))
%%   f^(4)/4! está acotado por 0.2 (ver 5 columna en tabla dif div de Hermite)

error_cota_posicion= 0.2*(t-9)*(t-9)*(t-12)*(t-12)

% error_cota_posicion =  0.80000

%% Para estimar el error en la derivada IR al tema de derivación aproximada
%% se usan la derivada 4 y la 5 y algunos productos (error (bruta) +/- 2 m/s).
%% Con la fórmula: f^(4)/4! está acotado por 0.2 (ver 5 columna en tabla dif div de Hermite)
%% f^(5)/5! está acotado por 0.05 (ver 6 columna en tabla dif div de Hermite)

error_cota_derivada= 0.2*(2*(t-9)*(t-12)*(t-12)+2*(t-9)*(t-9)*(t-12))+0.05*(t-9)*(t-9)*(t-12)*(t-12)
% error_cota_derivada =  1