clear all
clc
clf
addpath('../Matrix')

disp('Ejercicio 3')

disp('Apartado a')
%En primer lugar utilizamos la funcion meshgrid que sirve para dibujar una funcion 3D.
%Creo coordenadas de cuadrícula 3-D de x, y, z coordenadas definidas en el intervalo [-2,2] 
%cada coordenada esta a una distancia de 0.2 de la siguiente
[x,y,z]=meshgrid(-2:0.2:2,-2:0.2:2,-2:0.2:2);

%Escribimos las ecuaciones de nuestro sistema en forma implicita
eq1=15*x + y.^2 - 4*z - 13;
eq2=x.^2 + 10*y - z - 11;
eq3=y - 25*z + 22;

%Dibujamos las isosuperficies, que aparecerán en la ventana grafica
isosurface(x,y,z,eq1,0);
isosurface(x,y,z,eq2,0);
isosurface(x,y,z,eq3,0);

%Podemos observar que las tres curvas se cortan unicamente en un punto del espacio tridimensional, por tanto
%podemos asegurar que el sistema de ecuaciones no lineal dado va a tener una unica solucion.
format long g
global paso;
paso=0.01;
global precision;
precision=0.5e-5;
nmaxiteraciones=100;

%De forma analoga al ejercicio anterior buscamos la aproximacion inicial para realizar el menor numero de pasos. 
X1=[-0.5;-1.3;0];

%Seguimos los pasos del script ejemploNewton_10_2_3d BF.m como dice el enunciado para obtener aproximaciones iniciales y buscar la solucion. 
%Definimos la funcion F que va de R3 a R3
F=@ (X) [15*X(1)+X(2)^2-4*X(3)-13; 
         X(1).^2 + 10*X(2) - X(3) - 11;
         X(2) - 25*X(3) + 22];
         
%Mostramos el valor de la funcion en X1
FX1=F(X1)

%Calculamos su diferencial aproximada
dF=@ (X) difAproximada(F,X);

%Mostramos el jacobiano (matriz de la diferencial) en X1
dFX1=dF(X1)
 
disp('La solucion de nuestro sistema usando el metodo de Newton es:')
[X_1,FX_1,pasos_1]=newtonV(F,dF,X1,nmaxiteraciones)




printf("\n")
printf("\n")
disp('Apartado b')

% El sistema puede transformarse en el problema de punto fijo siguiente: 

G=@(X) [(1/15)*(-X(2).^2 + 4*X(3).+13) ;
         0.1*(-X(1).^2+X(3)+11) ;
         0.004*(X(2)+22)];

%Definimos los parametros necesarios para aplicar el metodo de puntoFijo, por ejmplo
%tomamos la precision y el numero maximo de iteraciones siguiente
precision=5e-10;
nmaxit=200;
%Comenzamos en X0:
X0=[1,1,1];

disp('La solucion de nuestro sistema usando el metodo de punto-fijo es:')
[ptofijo,npasosPF]=puntofijo(G,X0,nmaxit)





printf("\n")
printf("\n")
disp('Apartado c')
%Ahora vamos a usar el metodo del descenso rapido para tener aproximaciones de la solucion buscada. 

%Retomamos la funcion F definida en el primer apartado de este ejercicio y
%definimos la "función objetivo del sistema", Fobj, usando la funcion objetivo.m 
%Recordamos que las soluciones del sistema del enunciado son los vectores 
%donde se alcanzan los mínimos absolutos de esta funcion objetivo:

Fobj=@(X) objetivo(F,X);

%Definimos los parametros necesarios
paso=0.001;
%Usamos la precision gruesa que pide el enunciado
precision=0.5e-3;
nmaxiter=100;
%Partimos de una aproximación inicial 
X0=[1,1,1];

%Finalmente aplicamos el metodo del descenso rapido a la funcion
disp('La solucion de nuestro sistema usando el metodo del descenso rapido es:')
[Xm, FXm, npasos] = descensoRapido (Fobj, X0, nmaxiter)





printf("\n")
printf("\n")
disp('Apartado d')
%Usando una precision fina 
precision=0.5e-10;
nmaxiteraciones=100;

%Sabemos por teoria que los metodos de Newton o de Boyren para resolver sistemas
%son eficientes si partimos de una aproximación a la solución adecuada. 
X1=[-0.5;-1.3;0];


%Vamos a obtener una aproximacion de la solucion usando  el metodo de Newton y el de Broyden
%Para aplicar el metodo de Newton vamos a usar la funcion F y su diferencial ya definidas en el apartado a)

%Aplicamos el metodo de Newton para obtener una aproximacion de la solucion
disp('La solucion de nuestro sistema usando el metodo de Newton es:')
[X,FX,npasosN] = newtonV (F,dF,X1,nmaxiteraciones)

%Para poder aplicar el metodo de Boyren necesitamos la diferencial de F en X0
dFX1=dF(X1);
disp('La solucion de nuestro sistema usando el metodo de Boyren es:')
[X,FX,npasosB] = quasiNewtonBoyrenV (F, dFX1,X1,nmaxiteraciones)






printf("\n")
printf("\n")
disp('Apartado e')
%Sabemos si utilizamos el metodo de Newton, resolver un sistema lineal de 
%m ecuaciones con m incognitas, tendrá un coste del orden de m3 operaciones en cada etapa,
%Teniendo en cuenta que nuestro sistema tiene 3 incognitas y 3 ecuaciones
%el numero de operaciones en total, es decir en todas las etapas, usando el metodo de Newton es:
disp('Numero de operaciones realizadas en total con el metodo de Newton:')
numOperacionesNewton=npasosN*3^3

%Mientras que el si usamos el metodo de Boyren, resolver un sistema lineal de 
%m ecuaciones con m incognitas, tendrá un coste del orden de m2 operaciones en cada etapa,
%Por tanto el numero de operaciones en  total usando el metodo de Boyren es:
disp('Numero de operaciones realizadas en total con el metodo de Boyren:')
numOperacionesNewton=npasosB*3^2














rmpath('../Matrices')
