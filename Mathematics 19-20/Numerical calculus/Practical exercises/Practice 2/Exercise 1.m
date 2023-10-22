% Ejercicio 1
% cabecera

clear all
clc
clf %clear figure
addpath('../biblioteca')

% Las siguientes ecuaciones en diferencias pueden
% usarse para generar recursivamente los términos
% de la  sucesión 1/ 3^n  (n=0..Inf) (si las operaciones
% se hicieran exactamente) 
% r_n  ,  p_n y q_n

% Genera las cincuenta primeras aproximaciones numéricas de cada una de las ecua-
% ciones en diferencias (trabaja con toda la precisión de la máquina). Compara los
% resultados anteriores con el valor de  1/3^k

n=50  %numero de términos

r=zeros(1,n);
p=zeros(1,n);
q=p;

r(1)=1;
r(2)=1/3;

p(1)=r(1);
p(2)=r(2);

q(1)=r(1);
q(2)=r(2);
for k=3:n
  r(k) = 1/3 * r(k-1);
  p(k)= 4/3 * p(k-1) - 1/3 * p(k-2);
  q(k)= 10/3 * q(k-1) - q(k-2);
endfor
% Presenta tus resultados en una tabla. 

 fprintf('Tabla con comparación de aproximaciones\n k \t \t  r(k) \t \t p(k) \t \t q(k) \n');
for k=1:5:n  % los escribimos de 5 en 5 para visualizar los datos en una tabla más corta
  fprintf('%5d \t %5e \t %5e \t %5e \n',k,r(k),p(k),q(k));
endfor

% Qué comportamiento observas?

% El esperado:
% la sucesión p es casi estable: Aquí los errores de propagación se van compensando
%     en el primer sumando se multiplican por 4/3 y se restan en el segundo sumando multiplicados por 1/3, con lo que quedan casi iguales 4/3 -1/3 =1.
% la sucesión q es inestable (está mal condicionada), aquí los errores se van propagando multiplicados en cada paso por al menos 7/3 >1 (7/3= 10/3  -1 ) y se acumulan en (7/3)^n -> Inf

% Haz un estudio del error (absoluto) cometido en cada caso.

e_a_p=abs(p-r); % operamos con las listas directamente
e_a_q=abs(q-r); % operamos con las listas directamente
   fprintf('Tabla con comparación de errores \n k  \t  e_p(k) \t e_q(k)  \n');
for k=1:5:n % los escribimos de 5 en 5 para visualizar los datos en una tabla más corta
  fprintf('%5d \t %5e \t %5e  \n',k,e_a_p(k),e_a_q(k));
endfor
k=1:n;

figure(1)

plot(k,e_a_p,k,e_a_q)
title('Comparación errores p(k) y q(k) respecto r(k)=1/3^k');
legend('abs(r-p)','abs(r-q)')

% En la figura 1 : la diferencia en el tamaño de los errores no permite ver bien que escala (orden) tienen 
% para verlo mejor representamos en la figura 2 los logaritmos de los errores absolutos

figure(2)
plot(k,log(e_a_p),k,log(e_a_q))
title('Comparación de los logaritmos de los errores');
legend('log(abs(r-p))','log(abs(r-q))')


% Introduce un pequeño error en los datos de entrada de las tres sucesiones (por
% ejemplo toma 1 − 10 −7 y 1/3 − 10 −7 y analiza que ocurre en ese caso.

error=-1e-7  %probar  con otros
potencia=(1/3).^k; %operamos directamente con la lista

r(1)=1+error;
r(2)=1/3 + error;

p(1)=r(1);
p(2)=r(2);

q(1)=r(1);
q(2)=r(2);
for k=3:n
  r(k) = 1/3 * r(k-1);
  p(k)= 4/3 * p(k-1) - 1/3 * p(k-2);
  q(k)= 10/3 * q(k-1) - q(k-2);
endfor
e_a_r=abs(r-potencia); % operamos con las listas directamente
e_a_p=abs(p-potencia); % operamos con las listas directamente
e_a_q=abs(q-potencia);% operamos con las listas directamente

   fprintf('Tabla con comparación de errores \n k  \t  e_p(k) \t e_q(k)  \n');
for k=1:5:n % los escribimos de 5 en 5 para visualizar los datos en una tabla más corta
  fprintf('%5d \t %5e \t %5e  \n',k,e_a_p(k),e_a_q(k));
endfor

k=1:n; %OJO la variable k en el for tiene dimensión (1,1) y modifica la lista usada antes
           % por eso está repetida la lista 
% Los errores se propagan en la misma forma en p se mantiene y en q aumenta más rápido

figure(3)

plot(k,e_a_p,k,e_a_p,k,e_a_q)
title('Comparación errores r(k) p(k) y q(k) respecto 1/3^k');
legend('abs(p-1/3^k)','abs(p-1/3^k)','abs(q-1/3^k)')

% En la figura 3 : la diferencia en el tamaño de los errores no permite ver bien que escala (orden) tienen 
% para verlo mejor representamos en la figura 4 los logaritmos de los errores absolutos
%
figure(4)
plot(k,log(e_a_r),k,log(e_a_p),k,log(e_a_q))
title('Comparación de los logaritmos de los errores');
legend('log(abs(r-10^k))','log(abs(p-10^k))','log(abs(q-10^k))')

% Comparando las figuras 2 y 4 podemos observar que para valores de k > 10 las sucesiones se comportan de forma parecida, y que en las primeras iteraciones el error 10⁻7 
