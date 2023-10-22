% Ejercicio 2
%cabecera
clc
clear


% Se desea evaluar la expresión A = (sqrt(2) − 1)^6 , tomando como valor aproximado de
% sqrt(2) el valor 1.4 . Matemáticamente, la evaluación de A se podría hacer mediante
%  cualquiera de las seis expresiones alternativas siguientes (compruébalo):
% f1(sqrt(2)) ;   f2(sqrt(2)) ;   f3(sqrt(2)) ;   f4(sqrt(2)) ;  f5(sqrt(2)) ;  f6(sqrt(2)) ; 
% Sin embargo,  numéricamente hay una de las expresiones que, partiendo de la aproximación 
% sqrt(2) approx 1.4, permite obtener el valor de A con menor error. Determinar cual
% es esta expresión óptima.

% A priori podemos anticipar cual es la solución tomando como aproximación la que se obtiene con 
% la función que tiene el menor número de condición en sqrt(29
raiz2=sqrt(2);
raiz2aprox=1.4;
f_r2=zeros(1,6);
f_ap=zeros(1,6);
error_relativo=zeros(1,6);
cond_f_raiz2=zeros(1,6);


%f1
f1 = @(x) (x-1).^6;
f_r2(1)=f1(raiz2);
f_ap(1)=f1(raiz2aprox);
h=0.001;
derivada = @(f,x)(f(x+h)-f(x-h))/(2*h);
derivada(f1,raiz2);
condicion = @(f,x) abs(x.*derivada(f,x)/f(x));
cond_1=condicion(f1,raiz2)
cond_f_raiz2(1)=cond_1;


%f2
f2 = @(x) 1/(x+1).^6;
f_r2(2)=f2(raiz2);
f_ap(2)=f2(raiz2aprox);
h=0.001;
derivada = @(f,x)(f(x+h)-f(x-h))/(2*h);
derivada(f2,raiz2);
condicion = @(f,x) abs(x.*derivada(f,x)/f(x));
cond_2=condicion(f2,raiz2)
cond_f_raiz2(2)=cond_2;

%f3
f3 = @(x) (3-2*x).^3;
f_r2(3)=f3(raiz2);
f_ap(3)=f3(raiz2aprox);
h=0.001;
derivada = @(f,x)(f(x+h)-f(x-h))/(2*h);
derivada(f3,raiz2);
condicion = @(f,x) abs(x.*derivada(f,x)/f(x));
cond_3=condicion(f3,raiz2)
cond_f_raiz2(3)=cond_3;

%f4
f4 = @(x) 1/(3+2*x).^3;
f_r2(4)=f4(raiz2);
f_ap(4)=f4(raiz2aprox);
h=0.001;
derivada = @(f,x)(f(x+h)-f(x-h))/(2*h);
derivada(f4,raiz2);
condicion = @(f,x) abs(x.*derivada(f,x)/f(x));
cond_4=condicion(f4,raiz2)
cond_f_raiz2(4)=cond_4;

%f5
f5 = @(x) 99-70*x;
f_r2(5)=f5(raiz2);
f_ap(5)=f5(raiz2aprox);
h=0.001;
derivada = @(f,x)(f(x+h)-f(x-h))/(2*h);
derivada(f5,raiz2);
condicion = @(f,x) abs(x.*derivada(f,x)/f(x));
cond_5=condicion(f5,raiz2)
cond_f_raiz2(5)=cond_5;

%f6
f6 = @(x) 1/(99+70*x);
f_r2(6)=f6(raiz2);
f_ap(6)=f6(raiz2aprox);
h=0.001;
derivada = @(f,x)(f(x+h)-f(x-h))/(2*h);
derivada(f6,raiz2);
condicion = @(f,x) abs(x.*derivada(f,x)/f(x));
cond_6= condicion(f6,raiz2)
cond_f_raiz2(6)=cond_6;

%% Con estos datos presumimos que la mejor aproximación
%% se va a dar con la función f6

%% Comprobamos que efectivamente eso es lo que ocurre

error_relativo=abs((f_r2-f_ap)./f_r2);

fprintf('\n cond_k \t f_k(sqrt(2)   \t f_k(1.4) \t\t  e_r_k\n')
for k=1:6
  fprintf('%5e \t %5e  \t %5e   \t %5e \n', cond_f_raiz2(k),f_r2(k),f_ap(k),error_relativo(k));
end