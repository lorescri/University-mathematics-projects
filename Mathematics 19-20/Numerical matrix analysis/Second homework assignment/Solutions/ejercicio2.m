clear all
clc
clf
addpath('../Matrices')

disp('Ejercicio 2')

%Siguiendo el ejemplo 10.2.2dBF, voy a representar graficamente las dos curvas implicitas
% y a encontrar las soluciones,es decir los puntos de corte de ambas funciones, incluyendo los puntos en la grafica. 

%Definimos las dos curvas que se dan en el enuncido:
f=@ (x,y) sin(4*pi*x.*y)-2*y.-x;
g=@ (x,y) (((4*pi-1)/(4*pi)).*(exp(2*x)-6)) + 4*exp(1)*y.^2-2*exp(1)*x;
ezplot(f)
hold on
ezplot(g)

%Definimos las variables paso,precision y el numero maximo de iteraciones que se van a usar en el metodo de Newton
%Este metodo va a usar las funciones solveGaussParcial.m, LUPGauss.m, solveU.m, solveL.m que he incorporado en la carpeta "Matrices"
format long g
global paso=0.01;
global precision=0.5e-5;
nmaxiteraciones=100;

%Vamos ajustando los valores de X_0 para que se realice el minimo numero de pasos
%Podemos comprobar viendo el dibujo que unicamente hay 3 soluciones, luego buscamos solo 3 aproximaciones iniciales
X1=[1.3;-0.4];
X2=[-1;0.1];
X3=[-0.7;0.4];

%Definimos F
F=@ (X) [sin(4*pi*X(1).*X(2))-2*X(2).-X(1)  ;  (((4*pi-1)/(4*pi)).*(exp(2*X(1))-6)) + 4*exp(1)*X(2).^2-2*exp(1)*X(1)];

%Calculamos su diferencial
dF=@ (X) difAproximada(F,X);

%Calculamos las soluciones aplicando el metodo de Newton
[X_1,FX_1,pasos_1]=newtonV(F,dF,X1,nmaxiteraciones)

[X_2,FX_2,pasos_2]=newtonV(F,dF,X2,nmaxiteraciones)

[X_3,FX_3,pasos_3]=newtonV(F,dF,X3,nmaxiteraciones)


%Dibujamos ambas graficas, marcando en rojo las soluciones, es decir los puntos de corte de ambas funciones
plot([X_1(1),X_2(1),X_3(1)],[X_1(2),X_2(2),X_3(2)],'r*')






rmpath('../Matrices')
