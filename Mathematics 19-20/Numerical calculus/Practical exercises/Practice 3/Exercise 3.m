% Ejercicio 3

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
%a) Sea P_n (x) el polinomio interpolador de f (x) de grado n para puntos equiespaciados 
%   del intervalo [−5, 5] incluyendo los extremos. Por medio de las diferencias
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
grid on
title('Fenomeno Runge'); % ponemos titulo a la ventana gráfica
hold on   % con esta orden mantenemos la curva en la ventana gráfica y continuaremos dibujando en la misma ventana
ylim([-1,5]) % fija los límites de los valores de y en la ventana gráfica.


%% Uso de arrays: listas de objetos de distinta longitud}
nodos_x= cell(1,length(n))   %% crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con los nodos
nodos_y= cell(1,length(n)); %% crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con las ordenadas en los nodos
pol_int_eq=cell(1,length(n)); % crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con los coeficientes de los polinomios interpoladores
for k=1:length(n)
  nodos_x {k} =linspace(-5,5,np(k));  % ponemos en la posición k de la lista las abscisas de los nodos en cada caso
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
legend('f','x(3)','p2','x(6)','p5','x(16)','p15','x(21)','p20')  % por ultimo incluimos una leyenda identificado las curvas y puntos

%% APARTADO b)
%% b) Calcular max −5≤x≤5 |f (x) − P n (x)|, de manera aproximada, y estudiar su dependencia de n.

% usamos las abscisas de las gráficas para estimar el máximo
%xg
display(' ')
display('APARTADO (b)')

% para observar mejor los errores podemos incluir más polinomios interpoladores  e incluso hacer las gráficas de los errores.
n=[n 25 30]  %repetimos código para mas polinomios
np=n+1;


figure (2)

%plot()
grid on
title('errores en aprox por interpoladores')
hold on
ylim([-0.1,20])

nodos_x= cell(1,length(n));  %repetimos el código para los nodos y polinomios
nodos_y= cell(1,length(n)); 
pol_int_eq=cell(1,length(n)); 
for k=1:length(n)
  nodos_x {k} =linspace(-5,5,np(k));  % repetimos el código para hacer las interpolaciones
  nodos_y {k}= f(nodos_x{k});
  dif_div=diferencias_divididas(nodos_x{k},nodos_y{k});  
  pol_int_eq {k}=coef_polinomio_interpolador(dif_div,nodos_x{k});
end
fprintf('\n  n \t  ||f-P_n||_inf \t x_max\n');

%%  n       ||f-P_n||_inf          x_max
%%  2      6.461876e-01    -2.043011e+00
%%  5      4.326923e-01    0.000000e+00
%% 15      2.086223e+00    4.838710e+00
%% 20      5.909253e+01    4.892473e+00
%% 25      7.530475e+01    4.892473e+00
%% 30      2.251210e+03    4.946237e+00

for k=1:length(n)
                % errores absolutos
  err_g=abs(f(x_g)-polyval(pol_int_eq {k},x_g));
  [m,p]=max(err_g);  %max devuelve el valor máximo de una matriz fila y la posicion donde está ese valor
  fprintf('%3d \t %5e \t %5e\n',n(k),m,x_g(p));
  plot(x_g,err_g)
  hold on
end
legend([mat2str(n(1))],[mat2str(n(2))], [mat2str(n(3))],  [mat2str(n(4))],  [mat2str(n(5))], [mat2str(n(6))])

%% A la vista de las gráficas de los errores parece que el máximo de los errores crece con el número de puntos
%% mientras que esos máximos se van alcanzando cada vez más cerca de los extremos.

%% APARTADO c

%c) Comprobar experimentalmente que para ciertos x se tiene    lim n→∞ P n (x)  <> f (x).

%% De las gráficas no se puede deducir que exista un x en (-5,5) donde los polinomios no convergen a f(x), porque los puntos donde se alcanzan los máximos se van acercando a los extremos pero en lo que podrían ser los candidatos x=-5 y en x=5 el error es 0.


%% APARTADO d

display(["\n" , 'APARTADO d'])
%La función pi_n (x) = (x − x_0 )(x − x_1 ) . . . (x − x_n ) está relacionada con esos
%errores. Dibujar los gráficos de las pi_n's para n = 2, 5, 15 y 20.

%% el comando poly(x) devuelve el polinomio que tiene por ceros los elementos del vector fila x




fprintf('\n  n \t x_max  \t  ||pi_n||_inf  log(||pi_n||_inf)/n \n');
for k=1:length(n)
  pi_k=poly(nodos_x {k});
  abs_pi_k=abs(polyval(pi_k,x_g));
  [m,p]=max(abs_pi_k);  %max devuelve el valor máximo de una matriz fila y la posicion donde está ese valor
  fprintf('%3d \t %5e \t %5e  \t %5e  \n',n(k), x_g(p) , m, log(m)/n(k));
  
end

%%  n      x_max                 ||pi_n||_inf           log(||pi_n||_inf)/n
%%  2      -2.903226e+00   4.811017e+01    1.936747e+00
%%  5      -4.301075e+00   1.080618e+03    1.397058e+00
%% 15      4.838710e+00    2.046657e+08    1.275793e+00
%% 20      -4.892473e+00   1.103988e+11    1.271368e+00
%% 25      -4.892473e+00   6.292375e+13    1.270918e+00
%% 30      4.946237e+00    3.554209e+16    1.270316e+00


%% las normas van creciendo con el grado del polinomio
%% para ver como crecen podemos comparar los logaritmos del 
%% valor absoluto con el grado
%% equivale a ver que los valores son del orden una constante elevada al grado del polinomio K^n
%% la constante es del orden de   e^1.2703...

%% a la vista de los valores de los polinomios vamos a representar los logaritmos de sus valores absolutos
%% para poder comparar los tamaños

figure (3)

hold on
for k=1:length(n)
  pi_k=poly(nodos_x {k});
  abs_pi_k=abs(polyval(pi_k,x_g));
  subplot (length(n)/2,2,k)
  plot(x_g,log(abs_pi_k))
  title('valores de log PI_n(x)')
  grid on
  legend(['log Pi\_' , mat2str(n(k))])
  hold on
end



figure (4)
grid on
hold on
for k=1:length(n)
  pi_k=poly(nodos_x {k});  % poly es una función que construye el polinomio mónico con raices en los puntos
                                         % del vector fila nodos_x{k}
  abs_pi_k=abs(polyval(pi_k,x_g));
  subplot (length(n)/2,2,k)
  plot(x_g,log(abs_pi_k)/n(k))
  title('valores de log PI_n / n ')
  grid on
  legend(['log Pi\_' , mat2str(n(k)), ' / ' ,mat2str(n(k))])
  hold on
end


