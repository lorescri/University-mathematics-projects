clear all
clc
addpath('../Matrix')

disp('Ejercicio 5.2')
%Nos piden que comprobemos los metodos de la potencia y de la potencia inversa
%desplazada con las matrices dadas:

format long g
n=3;
A=[6,1,-0.5; 
  0.8,-1, 0.1; 
  1, -1, -4]

%%n=5
%%A=rand(n,n)

display(' Los valores de la diagonal seran nuestras aproximaciones ')

% Resultados del comando eig() de octave/Matlab
%La funcion eig(A) devuelve un vector de columna que contiene los valores propios de la matriz cuadrada A
d=eig(A)

%Las columnas de la matriz V seran los vectores propios de A y la diagonal
% de D seran los valores propios de A
[V,D]= eig(A);

% Parametros para el metodo de la potencia

x0=ones(n,1);
v=x0;
prec=10^(-8);
nmaxiteraciones=1000;

% Metodo de la potencia 
% Busca el valor propio de mayor tamaño
display('METODO DE LA POTENCIA')

[valorpropio_1,vectorpropio_1]=potencia(A,x0,nmaxiteraciones,prec)

display(' vectorpropio_1 == - V(:,1) ')
%Obtenemos el valor de la matriz d (definida antes) de mayor modulo.
%Este se corresponde al valor propio de A de mayor modulo


% Metodo de la potencia inversa
% Busca el valor propio de menor tamaño
display('METODO DE LA POTENCIA INVERSA')
vaprox=0;
[valorpropio_3,vectorpropio_3]=potenciaInvDesplazada(A,vaprox,x0,nmaxiteraciones,prec)
display(' vectorpropio_3 == - V(:,3) ')
%Obtenemos el valor de la matriz d (definida antes) de menor modulo.
%Este se corresponde al valor propio de A de menor modulo


% Metodo de la potencia inversa con desplazamiento
% busca el valor propio mas proximo a -4
display('METODO DE LA POTENCIA INVERSA CON DESPLAZAMIENTO A -4')

vaprox=-4
[valorpropio_2,vectorpropio_2]=potenciaInvDesplazada(A,vaprox,x0,nmaxiteraciones,prec)

display(' vectorpropio_2 == - V(:,2) ')
%Obtenemos el valor de la matriz d (definida antes) más proximo al valor aproximado -4.
%Este se corresponde al valor propio de A más proximo al valor aproximado -4.



disp('Apartado 1')
%A continuacion construimos la matriz simetrica “test” A:
d=[2,3,1,5]; 
D= diag(d);
U=[ 1,-1, 0, 1; 
    1, 1,-1, 0;
    0, 1, 1, 1; 
    1, 0, 1,-1];
U= 1/sqrt(3)*U;
A= U'*D*U 

disp('Apartado 2')
%Ahora comprobamos el funcionamiento de los metodos de la potencia y 
%la potencia inversa para aproximar los valores propios de mayor y menor tamaño 
%de la matriz A 

%Parametros para el metodo de la potencia
%Como A es una matriz 4x4 cambiamos el vector x0:
n=4;
x0=ones(n,1);
%Mantenemos el numero maximo de repeticiones y la precision, fijados antes


% Metodo de la potencia 
% Busca el valor propio de mayor tamaño
display('METODO DE LA POTENCIA aplicado a A')

[valorpropio_1,vectorpropio_1]=potencia(A,x0,nmaxiteraciones,prec)

display(' vectorpropio_1 == - V(:,1) ')
%De nuevo, usando este metodo, obtenemos el valor propio de A de mayor modulo


% Metodo de la potencia inversa
% Busca el valor propio de menor tamaño
display('METODO DE LA POTENCIA INVERSA aplicado a A')
vaprox=0;
[valorpropio_3,vectorpropio_3]=potenciaInvDesplazada(A,vaprox,x0,nmaxiteraciones,prec)
display(' vectorpropio_3 == - V(:,3) ')
%De nuevo, usando este metodo, obtenemos el valor propio de A de menor modulo


%Repetimos el mismo proceso cambiando ahora el valor del vector d que contiene el espectro de A:
d=[10,11,12,13]; 
D= diag(d);
U=[ 1,-1, 0, 1; 
    1, 1,-1, 0;
    0, 1, 1, 1; 
    1, 0, 1,-1];
U= 1/sqrt(3)*U;
A= U'*D*U 

%Dejamos los mismos parametros que en el apartado anterior
% Metodo de la potencia 
% Busca el valor propio de mayor tamaño
display('METODO DE LA POTENCIA aplicado a A')

[valorpropio_1,vectorpropio_1]=potencia(A,x0,nmaxiteraciones,prec)

display(' vectorpropio_1 == - V(:,1) ')


% Metodo de la potencia inversa
% Busca el valor propio de menor tamaño
display('METODO DE LA POTENCIA INVERSA aplicado a A')
vaprox=0;
[valorpropio_3,vectorpropio_3]=potenciaInvDesplazada(A,vaprox,x0,nmaxiteraciones,prec)
display(' vectorpropio_3 == - V(:,3) ')



disp('Apartado 3')
%En primer lugar definimos la matriz A de dimension 4x4:
A =[-2,0,1,1;
    -5,-5,4,5;
    16,14,-8,-12; 
    -19,-15,11,15]
    
display(' Los valores de la diagonal seran nuestras aproximaciones ')
d=eig(A)

%Utilizamos los mismos parametros del metodo de la potencia  que en el caso anterior
x0=ones(n,1);
prec=10^(-8);
nmaxiteraciones=1000;

%Metodo de la potencia 
% Busca el valor propio de mayor tamaño, es decir busca landa_1, y su vector asociado v_1
% para ello usamos:
% Metodo de la potencia inversa con desplazamiento
% busca el valor propio mas proximo a 1.7
display('METODO DE LA POTENCIA INVERSA CON DESPLAZAMIENTO A 1.7')

vaprox=1.7

[landa_1,v_1]=potenciaInvDesplazada(A,vaprox,x0,nmaxiteraciones,prec)


%Buscamos ahora el valor propio de menor tamaño (que es landa_2) y su vector asociado v_2, 
% para ello usamos:
% Metodo de la potencia inversa con desplazamiento
% busca el valor propio mas proximo a 1.4
display('METODO DE LA POTENCIA INVERSA CON DESPLAZAMIENTO A 1.4')

vaprox=1.4

[landa_2,v_2]=potenciaInvDesplazada(A,vaprox,x0,nmaxiteraciones,prec)


%Finalmente buscamos los valores propios landa_3 y landa_4, y sus vectores asociados, para ello usamos:
% Metodo de la potencia inversa con desplazamiento
% busca el valor propio mas proximo a -1.4
display('METODO DE LA POTENCIA INVERSA CON DESPLAZAMIENTO A -1.4')

vaprox=-1.4

[landa3,v3]=potenciaInvDesplazada(A,vaprox,x0,nmaxiteraciones,prec)


%Por ultimo calculamos landa_4 y v_4:
% Metodo de la potencia inversa con desplazamiento
% busca el valor propio mas proximo a -1.7

display('METODO DE LA POTENCIA INVERSA CON DESPLAZAMIENTO A -1.7')

vaprox=-1.7

[landa_4,v_4]=potenciaInvDesplazada(A,vaprox,x0,nmaxiteraciones,prec)








rmpath('../Matrices')
