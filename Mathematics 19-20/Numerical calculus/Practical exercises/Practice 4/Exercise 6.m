%Ejercicio 6
clc
clear all
clf

%   Se quiere aproximar la parte superior del dibujo de un pato en vuelo y se tienen los
%   siguientes puntos por los que debe pasar la curva
x = [0.9, 1.3, 1.9, 2.1, 2.6, 3.0, 3.9, 4.4, 4.7, 5.0, 6.0, 7.0, 8.0, 9.2, 10.5, 11.3, 11.6, 12.0, 12.6, 13.0, 13.3];
%   e y=f(x)
y = [1.3, 1.5, 1.85, 2.1, 2.6, 2.7, 2.4, 2.15, 2.05, 2.1, 2.25, 2.3, 2.25, 1.95, 1.4, 0.9, 0.7, 0.6, 0.5, 0.4, 0.25];
%(i) Utiliza interpolación polinomial de Lagrange para aproximar la curva. Dibuja
%la gráfica.
n=length(x);
ind=1:n;
difdiv_x=diferencias_divididas(ind,x);
p_x=coef_polinomio_interpolador(difdiv_x,ind);
difdiv_y=diferencias_divididas(ind,y);
p_y=coef_polinomio_interpolador(difdiv_y,ind);


figure(1)

tt=linspace(1,n,181);

plot(x,y,'*',polyval(p_x,tt),polyval(p_y,tt))
title('curva parametrizada con polinomios de Lagrange')
%% limitamos el gráfico para ver los puntos y como los une la curva (prueba sin xlim ni ylim
xlim([min(x)-1,max(x)+1])
ylim([min(y)-1,max(y)+1])

%% observa el fenómeno Runge en los extremos



%(ii) Utiliza splines cúbicos naturales para aproximar la curva. Dibuja la gráfica.
%Compara los resultados.

figure (2)
[bx,cx,dx]=splineNatural(ind,x);
[by,cy,dy]=splineNatural(ind,y);
spl_x_tx=splineEval(ind,x,bx,cx,dx,tt);
spl_x_ty=splineEval(ind,y,by,cy,dy,tt);

plot(x,y,'*',spl_x_tx,spl_x_ty)
title('curva parametrizada con splines naturales')
xlim([min(x)-1,max(x)+1])
ylim([min(y)-1,max(y)+1])

%% Con splines naturales la interpolación es mucho mejor, no hay fenómeno Runge, La curvatura es más suave

