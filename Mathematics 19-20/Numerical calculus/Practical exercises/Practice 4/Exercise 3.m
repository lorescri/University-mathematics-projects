%ejercicio 3

clc
clear all
clf 

%clf (2)
%clf (3)
%clf (4)
addpath ('../biblioteca')


% Se considera la función f (x) = x.^(5/2) definida en el intervalo [0, 1].

%datos 
f=@ (x) x.^2.5;
I=[0,1];

nuNodos=11;

%para representaciones gráficas
nuPuntosGrafica=239;  
tx=linspace(I(1),I(2),nuPuntosGrafica);


%a) Dibuja el error absoluto cometido al aproximar f por el spline cúbico natural
%    y por el spline cúbico sujeto con 11 nodos equiespaciados.

% En la primera ventana dibujamos la función y los splines natural y sujeto
figure (1)   

xx=linspace(I(1),I(2),nuNodos);
aa=f(xx);

[b_1,c_1,d_1]=splineNatural(xx,aa);
y_graficas_1=f(tx);
y_graficas_2=splineEval(xx,aa,b_1,c_1,d_1,tx);

% para el spline sujeto
% utilizamos los valores de las derivadas de f en los extremos
tan_ini= 0 ;
tan_fin= 2.5;


[b_2,c_2,d_2]=splineSujeto(xx,aa,tan_ini,tan_fin);
y_graficas_3=splineEval(xx,aa,b_2,c_2,d_2,tx);


plot(tx,[y_graficas_1 ; y_graficas_2; y_graficas_3]);
grid on
ylim([-0.5,1.5])
legend( 'f',['n ' mat2str(nuNodos) ' nodos'], ['s ' mat2str(nuNodos) ' nodos'])
title(['Splines con ' mat2str(nuNodos) ' nodos equiespaciados'])

% En la segunda ventana dibujamos la los errores  
figure (2,"name",['Errores abs(f-sNatural) y   abs(f-sNatural) '] )
grid on
ty=f(tx);


subplot(1,2,1)
plot(tx,abs(y_graficas_1-y_graficas_2));
title( [' Error spline natural con ' mat2str(nuNodos) ' nodos equiespaciados'] );

subplot(1,2,2)
plot(tx,abs(y_graficas_1-y_graficas_3));
title( [' Error spline sujeto con ' mat2str(nuNodos) ' nodos equiespaciados'] );


%b) Dibuja el error absoluto cometido al aproximar f por el spline cúbico natural
%    y por el spline cúbico sujeto con 11 nodos x(i)=(i/nuNodos)^2

% En la primera ventana dibujamos la función y los splines natural y sujeto
figure (3)   

% xx2=( [0:nuNodos] / nuNodos).^2;
% xx2=( [0:nuNodos] / nuNodos).^0.5;
xx2=[([0:floor(nuNodos/2)] / nuNodos).^2 ( [floor(nuNodos/2)+1:nuNodos] / nuNodos).^0.5];

aa2=f(xx2);

[b2_1,c2_1,d2_1]=splineNatural(xx2,aa2);
y_graficas_3=splineEval(xx2,aa2,b2_1,c2_1,d2_1,tx);

% para el spline sujeto
% utilizamos los valores de las derivadas de f en los extremos
tan_ini= 0 ;
tan_fin= 2.5;


[b2_2,c2_2,d2_2]=splineSujeto(xx2,aa2,tan_ini,tan_fin);
y_graficas_4=splineEval(xx,aa,b_2,c_2,d_2,tx);


plot(tx,[y_graficas_1 ; y_graficas_3; y_graficas_4]);
grid on
ylim([-0.5,1.5])
legend( 'f',['n ' mat2str(nuNodos) ' nodos'], ['s ' mat2str(nuNodos) ' nodos'])
title(['Splines con ' mat2str(nuNodos) ' nodos (i/n)^2'])

% En la segunda ventana dibujamos la los errores  
figure (4,"name",['Errores abs(f-sNatural) y   abs(f-sNatural) '] )
grid on
ty=f(tx);


subplot(1,2,1)
plot(tx,abs(y_graficas_1-y_graficas_3));
title( [' Error spline natural con ' mat2str(nuNodos) ' nodos  (i/n)^2'] );

subplot(1,2,2)
plot(tx,abs(y_graficas_1-y_graficas_4));
title( [' Error spline sujeto con ' mat2str(nuNodos) ' nodos  (i/n)^2'] );



%c) Saca conclusiones.

% Con los nodos espaciados, los errores al aproximar con el spline natural y el sujeto son muy similares 
% Son menores cerca del 0 que cerca de 1
%
%  Los nodos (1/n)^2 se desplazan hacia el 0, por lo que las aproximaciones mejora la aproximación con el 
%  spline natural cerca del cero
%
%  Si usamos como nodos (1/n)^0.5, éstos se desplazan hacia el 1 (haz el cambio) y mejora la aproximación con
%  el spline natural cerca del 1.
%
%   En los dos casos anteriores, las aproximaciones con los splines sujetos son similares a la que se obtiene con
%   los nodos equiespaciados 

%  Si en la mitad de los casos elevamos al cuadrado y en la otra mitad tomamos raices cuadradas. 
%  xx2=[([0:floor(nuNodos/2)] / nuNodos).^2 ( [floor(nuNodos/2)+1:nuNodos] / nuNodos).^0.5];
%  podemos conseguir que el spline natural aproxime mejor en todo el intervalo (haz el cambio)

% ¿Que pasa al aumentar el número de nodos?   (mejora con los nodos equiespaciados, en los otros casos ¿?)


