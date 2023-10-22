% Ejercicio 4

%CABECERA
clc
close all
clear all

addpath('../biblioteca')


%Se considera la función f (x) = 1 / (1+x^2 ) definida en el intervalo [−5, 5].

f=@ (x)  1./ (1+x.^2);
%% OJO x.^2  asigna a cada componente del vector/matriz x su cuadrado, equivale a x.*x . 
%% Mientras que x^2 no esta definido para vectores/matrices y x*x hace el producto de matrices.
%% IDEM para 1./ x.

% APARTADO a)
%a) Sea P_n (x) el polinomio interpolador de f (x) de grado n para los nodos de Chebichev
%   del intervalo [−5, 5]. Por medio de las diferencias
%   dividas de Newton, encontrar P_n (x) para n = 2, 5, 15 y 20. Dibujar, superpuestos, 
%   los gráficos de f (x) y todos esos polinomios.

%% listas de nodos
n=[2 5 15 20]
np=n.+1

%% num puntos y vector de abscisas para las gráficas
num_puntos_grafica=187;  %el número de puntos es importante
x_g=linspace(-5,5,num_puntos_grafica);

%% Abrimos una ventana gráfica con la curva y=f(x)
figure (1)
plot(x_g,f(x_g))
grid
title('Fenomeno Runge: Nodos Chebichev'); % ponemos titulo a la ventana gráfica
hold on   % con esta orden mantenemos la curva en la ventana gráfica y continuaremos dibujando en la misma ventana
ylim([-0.5,2]) % fija los límites de los valores de y en la ventana gráfica.


%% Uso de arrays: listas de objetos de distinta longitud}
nodos_x= cell(1,length(n))   %% crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con los nodos
nodos_y= cell(1,length(n)); %% crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con las ordenadas en los nodos
pol_int_eq=cell(1,length(n)); % crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con los coeficientes de los polinomios interpoladores
for k=1:length(n)
  nodos_x {k} =nodosChebychev(-5,5,n(k));  % ponemos en la posición k de la lista las abscisas de los nodos en cada caso
  nodos_y {k}= f(nodos_x{k});
  plot(nodos_x {k},nodos_y {k},'*')   % mandamos a la ventana gráfica los puntos a interpolar
  hold on   % mantenemos el contenido de la ventana gráfica para ir añadiendo más curvas y puntos
  dif_div=diferencias_divididas(nodos_x{k},nodos_y{k});  % si se modifica o sobrecarga la función se puede 
                %  evitar el escribir la tabla de las diferencias divididas
  pol_int_eq {k}=coef_polinomio_interpolador(dif_div,nodos_x{k}); % ponemos en la posición k de la lista 
                %  el polinomio interolador
  plot(x_g,polyval(pol_int_eq {k},x_g))  % añadimos la gráfica del polinomio intepolador
  hold on   % seguimos manteniendo el contenido de la gráfica
end
legend('f','x(3)','p2','x(6)','p5','x(16)','p15','x(21)','p20')  
% por ultimo incluimos una leyenda identificado las curvas y puntos




%%% APARTADO b)

%b) Para n = 2, 5, 15 y 20, comparar gráficamente el pi_n_ch   que se obtiene en esta
%   situación con el pi_n_eq para nodos equiespaciados.

%%La función pi_n (x) = (x − x_0 )(x − x_1 ) . . . (x − x_n ) está relacionada con esos
%%errores. Dibujar los gráficos de las pi_n's para n = 2, 5, 15 y 20.
%
%%% el comando poly(x) devuelve el polinomio que tiene por ceros los elementos del vector fila x
%
%

fprintf('\n\n  Comparación máximos de los productos con nodos equiespaciados o nodos de Chebichev\n \n');
fprintf('\n  n \t  ||pi_eq_n||_inf \t x_eq_max      \t  ||pi_ch_n||_inf \t x_ch_max           \n');
for k=1:length(n)
  pi_k_ch=poly(nodos_x {k});
  abs_pi_ch_k=abs(polyval(pi_k_ch,x_g));
  [m_ch,p_ch]=max(abs_pi_ch_k);  %max devuelve el valor máximo de una matriz fila y la posicion donde está ese valor
  nodos_x_eq {k} =linspace(-5,5,np(k));
  pi_k_eq=poly(nodos_x_eq{k});
  abs_pi_eq_k=abs(polyval(pi_k_eq,x_g));
  [m_eq,p_eq]=max(abs_pi_eq_k);  %max devuelve el valor máximo de una matriz fila y la posicion donde está ese valor
  
  fprintf('%3d \t %5e \t %5e     \t %5e \t %5e\n',n(k),m_eq,x_g(p_eq),m_ch,x_g(p_ch));
  
end

%%  n       ||pi_eq_n||_inf        x_eq_max         ||pi_ch_n||_inf        x_ch_max
%%  2      4.811017e+01    -2.903226e+00           3.125000e+01    -5.000000e+00
%%  5      1.080618e+03    -4.301075e+00           4.882813e+02    5.000000e+00
%% 15      2.046657e+08    4.838710e+00            4.656613e+06    5.000000e+00
%% 20      1.103988e+11    -4.892473e+00           4.547474e+08    -5.000000e+00

%%% las normas van creciendo con el grado del polinomio
%%% para ver como crecen podemos comparar los logaritmos del 
%%% valor absoluto con el grado
%%% equivale a ver que los valores son del orden una constante elevada al grado del polinomio
%%% la constante es menor para el producto de los nodos de Chebichev

figure (2)
for k=1:length(n)
  pi_k=poly(nodos_x {k});
  abs_pi_k=abs(polyval(pi_k,x_g));
  subplot (length(n)/2,2,k)
  plot(x_g,log(abs_pi_k)/n(k))
  grid
  title(['valores de log PI_n(x) / n      n='  mat2str(n(k)) ])
  hold on
  %ylim([-0.2,1.5])
  pi_k_eq=poly(nodos_x_eq{k});
  abs_pi_k_eq=abs(polyval(pi_k_eq,x_g));
  plot(x_g,log(abs_pi_k_eq)/n(k))
  legend('Prod Ch', 'Prod eq', "location", 'southeast')
  
end

