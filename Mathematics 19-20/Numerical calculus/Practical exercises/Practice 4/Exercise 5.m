%Ejercicio 5
clc
clear all
clf

%   Considera la lista de puntos del plano (x i , y i ) 7 i=0 dada por los puntos A = (0, 0); B =(1, −1);
%    C = (4, 5); D = (5, 3); E = (7, 5); F = (7, 0); G = (8, −1); H = (9, 0)
A=[0,0];
B=[1,-1];
C=[4,5];
D=[5,3];
E=[7,5];
F=[7,0];
G=[8,-1];
H=[9,0];

%Utilizando splines cúbicos construye dos funciones x(t) e y(t) que interpolen las
%listas (i, x i )_{i=0}^7 e (i, y i )_{i=0}^7 en el intervalo [0, 7] en los dos casos siguientes
%(i) Splines cúbicos naturales
%(ii) Splines cúbicos sujetos con x ′ (0) = y ′ (0) = 1 y x ′ (7) = y ′ (7) = 1.
%Representa gráficamente las curvas de coordenadas parámetricas x(t) e y(t).




%% Usamos una matriz para poner los puntos y la transpnemos para que
%% la primera fila contenga las abscisas de los puntos y la segunda fila las ordenadas
puntos=[A;B;C;D;E;F;G;H];
puntos_t=transpose(puntos)


%% Usando como nodos de abscisas tt=[0,1,2,3,4,5,6,7] y de ordenadas puntos_t(1,:)
%% construimos el spline Natural (x(t)), spline_n_x, que interpola las abscisas de los puntos
tt=0:7;

%spline_n_x
[bx,cx,dx]=splineNatural(tt,puntos_t(1,:));

%% Usando como nodos de abscisas tt=[0,1,2,3,4,5,6,7] y de ordenadas puntos_t(2,:)
%% construimos el spline Natural (y(t)),  spline_n_y,  que interpola las ordenadas de los puntos
%spline_n_y
[by,cy,dy]=splineNatural(tt,puntos_t(2,:));

% Utilizando la poligonal que une los puntos de la curva parametrizada (x(t),y(t))=(spline_n_x,spline_n_y)
% construimos una curva que interpola los 8 puntos.
figure(1)

tx=linspace(0,7,181);
spl_x_tx=splineEval(tt,puntos_t(1,:),bx,cx,dx,tx);
spl_x_ty=splineEval(tt,puntos_t(2,:),by,cy,dy,tx);

plot(puntos_t(1,:),puntos_t(2,:),'o',spl_x_tx,spl_x_ty)
title('Curva parametrizada por splines naturales')
%% con la orden text(x,y,'texto') etiquetamos la grafica insertanto el 'texto' en el punto (x,y)
h=0.1;
text(A(1)+h,A(2)+h,'A');
text(B(1)+h,B(2)+h,'B');
text(C(1)+h,C(2)+2*h,'C');
text(D(1)+h,D(2)-h,'D');
text(E(1)+h,E(2)+h,'E');
text(F(1)+h,F(2)+h,'F');
text(G(1)+h,G(2)-h,'G');
text(H(1)+h,H(2)+h,'H');


%% Usando como nodos de abscisas tt=[0,1,2,3,4,5,6,7] y de ordenadas puntos_t(1,:)
%% construimos el spline Sujetos (x(t)), spline_s_x, que interpola las abscisas de los puntos

%%  x ′ (0) = y ′ (0) = 1 y x ′ (7) = y ′ (7) = 1.
%% tan_ini=y'(0)/x'(0)= 1
%% tan_fin= x ′ (7) /y ′ (7) =1

%spline_n_x
[bx,cx,dx]=splineSujeto(tt,puntos_t(1,:),1,1);

%% Usando como nodos de abscisas tt=[0,1,2,3,4,5,6,7] y de ordenadas puntos_t(2,:)
%% construimos el spline Sujetos (y(t)),  spline_s_y,  que interpola las ordenadas de los puntos
%spline_n_y
[by,cy,dy]=splineSujeto(tt,puntos_t(2,:),1,1);

% Utilizando la poligonal que une los puntos de la curva parametrizada (x(t),y(t))=(spline_n_x,spline_n_y)
% construimos una curva que interpola los 8 puntos.
figure(2)

tx=linspace(0,7,181);
spl_x_tx=splineEval(tt,puntos_t(1,:),bx,cx,dx,tx);
spl_x_ty=splineEval(tt,puntos_t(2,:),by,cy,dy,tx);

plot(puntos_t(1,:),puntos_t(2,:),'o',spl_x_tx,spl_x_ty)
title('Curva parametrizada por splines Sujetos')
h=0.1;
text(A(1)+h,A(2)+h,'A');
text(B(1)+h,B(2)+h,'B');
text(C(1)+h,C(2)+2*h,'C');
text(D(1)+h,D(2)-h,'D');
text(E(1)+h,E(2)+h,'E');
text(F(1)+h,F(2)+h,'F');
text(G(1)+h,G(2)-h,'G');
text(H(1)+h,H(2)+h,'H');

