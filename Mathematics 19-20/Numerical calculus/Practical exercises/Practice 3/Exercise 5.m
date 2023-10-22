% Ejercicio 5

%CABECERA
clc
close all
clear all

addpath('../biblioteca')


%Se considera la función f (x) = |x|| definida en el intervalo [−1, 1].

f=@ (x)  abs(x);
%% OJO x.^2  asigna a cada componente del vector/matriz x su cuadrado, equivale a x.*x . 
%% Mientras que x^2 no esta definido para vectores/matrices y x*x hace el producto de matrices.
%% IDEM para 1./ x.

% APARTADO a)
%a) Sea P_n (x) el polinomio interpolador de f (x) de grado n para puntos equiespaciados 
%   del intervalo [−5, 5] incluyendo los extremos. Por medio de las diferencias
%   dividas de Newton, encontrar P_n (x) para n = 2, 5, 15 y 20. Dibujar, superpuestos, 
%   los gráficos de f (x) y todos esos polinomios.

%% listas de nodos
n=[2 5 15 30]
np=n.+1

%% num puntos y vector de abscisas para las gráficas
num_puntos_grafica=187;  %el número de puntos es importante
x_g=linspace(-1,1,num_puntos_grafica);

%% Abrimos una ventana gráfica con la curva y=f(x)
figure (1)
plot(x_g,f(x_g))
grid on
title('Fenomeno Runge con abs nodos equiesp.'); % ponemos titulo a la ventana gráfica
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
  nodos_x {k} =linspace(-1,1,np(k));  % ponemos en la posición k de la lista las abscisas de los nodos en cada caso
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
legend('f','x(3)','p2','x(6)','p5','x(16)','p15',['x(', mat2str(n(4)+1),')'],['p', mat2str(n(4))])  % por ultimo incluimos una leyenda identificado las curvas y puntos

%% Abrimos una ventana gráfica con la curva y=f(x)
figure (2)
plot(x_g,f(x_g))
grid on
title('Fenomeno Runge con abs nodos Cheb.'); % ponemos titulo a la ventana gráfica
hold on   % con esta orden mantenemos la curva en la ventana gráfica y continuaremos dibujando en la misma ventana
ylim([-0.5,1.5]) % fija los límites de los valores de y en la ventana gráfica.


%% Uso de arrays: listas de objetos de distinta longitud}
nodos_x= cell(1,length(n))   %% crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con los nodos
nodos_y= cell(1,length(n)); %% crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con las ordenadas en los nodos
pol_int_eq=cell(1,length(n)); % crea una lista de 4=length(n) 
                            % elementos donde ir poniendo los vectores fila con los coeficientes de los polinomios interpoladores
for k=1:length(n)
  nodos_x {k} =nodosChebychev(-1,1,np(k));  % ponemos en la posición k de la lista las abscisas de los nodos en cada caso
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
legend('f','x(3)','p2','x(6)','p5','x(16)','p15',['x(', mat2str(n(4)+1),')'],['p', mat2str(n(4))],"location",'southwest')  % por ultimo incluimos una leyenda identificado las curvas y puntos

%% APARTADO b)
%% b) Calcular max −5≤x≤5 |f (x) − P n (x)|, de manera aproximada, y estudiar su dependencia de n.

% usamos las abscisas de las gráficas para estimar el máximo
%xg
display(' ')
display('APARTADO (b)')

% para observar mejor los errores podemos incluir más polinomios interpoladores  e incluso hacer las gráficas de los errores.
n=[n 25 30]  %repetimos código para mas polinomios
np=n+1;


figure (3)

%plot()
grid on
title('errores en aprox por interpoladores nodos equiesp.')
hold on
ylim([-0.1,20])

nodos_x= cell(1,length(n));  %repetimos el código para los nodos y polinomios
nodos_y= cell(1,length(n)); 
pol_int_eq=cell(1,length(n)); 
for k=1:length(n)
  nodos_x {k} =linspace(-1,1,np(k));  % repetimos el código para hacer las interpolaciones
  nodos_y {k}= f(nodos_x{k});
  dif_div=diferencias_divididas(nodos_x{k},nodos_y{k});  
  pol_int_eq {k}=coef_polinomio_interpolador(dif_div,nodos_x{k});
end
fprintf('\n CON NODOS DE EQUIESPACIADOS\n  n \t  ||f-P_n||_inf \t x_max\n');

%%  n       ||f-P_n||_inf          x_max
%%  2      2.499711e-01    -5.053763e-01
%%  5      1.406250e-01    0.000000e+00
%% 15      5.002209e-01    9.677419e-01
%% 30      2.975935e+04    9.892473e-01
%% 25      7.011494e+01    -9.784946e-01
%% 30      2.975935e+04    9.892473e-01

for k=1:length(n)
                % errores absolutos
  err_g=abs(f(x_g)-polyval(pol_int_eq {k},x_g));
  [m,p]=max(err_g);  %max devuelve el valor máximo de una matriz fila y la posicion donde está ese valor
  fprintf('%3d \t %5e \t %5e\n',n(k),m,x_g(p));
  plot(x_g,err_g)
  hold on
end
legend([mat2str(n(1))],[mat2str(n(2))], [mat2str(n(3))],  [mat2str(n(4))],  [mat2str(n(5))], [mat2str(n(6))])


figure (4)

%plot()
grid on
title('errores en aprox por interpoladores nodos Cheby.')
hold on


nodos_x= cell(1,length(n));  %repetimos el código para los nodos y polinomios
nodos_y= cell(1,length(n)); 
pol_int_eq=cell(1,length(n)); 
for k=1:length(n)
  nodos_x {k} =nodosChebychev(-1,1,np(k));  % repetimos el código para hacer las interpolaciones
  nodos_y {k}= f(nodos_x{k});
  dif_div=diferencias_divididas(nodos_x{k},nodos_y{k});  
  pol_int_eq {k}=coef_polinomio_interpolador(dif_div,nodos_x{k});
end
fprintf(' \n CON NODOS DE CHEBYCHEV \n  n \t  ||f-P_n||_inf \t x_max\n');

%%  n       ||f-P_n||_inf          x_max
%%  2      2.705981e-01    0.000000e+00
%%  5      8.665604e-02    -1.827957e-01
%% 15      3.520799e-02    7.526882e-02
%% 30      3.128769e-02    0.000000e+00
%% 25      2.199926e-02    4.301075e-02
%% 30      3.128769e-02    0.000000e+00
%% 
 ylim([-0.01,0.2])
for k=1:length(n)
                % errores absolutos
  err_g=abs(f(x_g)-polyval(pol_int_eq {k},x_g));
  [m,p]=max(err_g);  %max devuelve el valor máximo de una matriz fila y la posicion donde está ese valor
  fprintf('%3d \t %5e \t %5e\n',n(k),m,x_g(p));
  plot(x_g,err_g)
  hold on
end
legend([mat2str(n(1))],[mat2str(n(2))], [mat2str(n(3))],  [mat2str(n(4))],  [mat2str(n(5))], [mat2str(n(6))])
