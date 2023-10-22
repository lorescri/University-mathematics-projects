% ejercicio 6

%Aproxima la derivada de la función sin(x) en x = 1 mediante la fórmula
% (sin(1 + h) − sin(1))/h 
%con h = 10^(−i) para i = 5, 6, . . . , 16 comparando los resultados obtenidos con el valor exacto
%de cos(1). Halla el error absoluto y relativo para cada aproximación y comprueba la pérdida de
%precisión por cancelación. Trabajad con toda la precisión de la máquina.
%Nota: puedes ver lo que ocurre si trabajas son sólo 5 dígitos y redondeo simétrico.

%% USAMOS TABLAS Y GRÁFICAS PARA COMPARAR LOS ERRORES.
%% DE ANTEMANO SABEMOS QUE   (sin(1 + h) − sin(1))/h - cos(1) = O(h) 

% cabecera
clear all
clc
clf  % clear figure  LIMPIA LOS GRÁFICOS
addpath('../biblioteca')
%%

display (' ejercicio 6')

%% vectores fila para guardar los datos y poder hacer las gráficas con facilidad
h=zeros(1,12);  %matriz con 1 fila y 12 columnas (vector fila)
e_a=h;
e_r=h;
cos_1=cos(1);

fprintf('\n h \t e_a \t \t e_r \n')   %cabecera de tabla de datos
for i=1:12
  h(i)=10^(-i);  % 10^(-i-4); para ir de 5 a 16  se verá la cancelación en restas
  der_aprox= (sin(1+h(i))-sin(1))/h(i);
  e_a(i)=abs(der_aprox-cos_1);
  e_r(i)=e_a(i)/cos_1;
  fprintf('%5e \t %5.7e \t %5.7e \n ', h(i), e_a(i), e_r(i))  %linea de datos con formato
end  

% comandos para gráfica 1
figure(1);
plot(h,e_a,h,e_r)
title('calculos en double')
legend('err-abs','err-rel')

% calculos con 5 digitos
global n   % en practicas se nos olvidó  OJO
n=5
display( ' calculo con 5 digitos')


cos_1_fls=cos(1);

fprintf('\n h \t e_a \t \t e_r \n')
for i=1:12
  h(i)=10^(-i);  %10^(-i-4) para ir de 5 a 16  (SE VE ANTES EL ERROR DE CANCELACION)
  der_aprox= fls(fls(fls(sin(fls(1+h(i))))-fls(sin(1)))/h(i));
  e_a(i)=abs(der_aprox-cos_1);
  e_r(i)=e_a(i)/cos_1;
  fprintf('%5e \t %5.7e \t %5.7e \n ', h(i), e_a(i), e_r(i))
end  

% comandos para gráfica 2
figure(2);
plot(h,e_a,h,e_r)
title('calculos con 5 digitos')
legend('err-abs','err-rel')






