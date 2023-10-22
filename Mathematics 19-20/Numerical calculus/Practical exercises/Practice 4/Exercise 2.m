%ejercicio 2

clc
clear all
clf 
%clf (2)
addpath ('../biblioteca')

% Se considera la función f (x) = 1/(1+x.^2) definida en el intervalo [−5, 5].

%datos 
f=@ (x) 1./ (1+x.^2);
I=[-5,5];

%a) Dibuja el spline cúbico natural correspondiente a n nodos equiespaciados para
%        n = 2, 5, 15 y 20. Compara el dibujo del spline con los dibujos de los polinomios
%        interpoladores en nodos equiespaciados y en los nodos de Chebyshev que se
%        realizaron en la práctica 3.

n=[2, 5, 15, 20]
nuPuntosGrafica=181;
tx=linspace(I(1),I(2),nuPuntosGrafica);

% Como todo funcionó en la clase haciendo las gráficas
% una a una, vamos a aprender a usar una matriz
% para guardar las ordenadas de todas las gráficas
% que queremos pintar y simplificamos el uso de PLOT
% (como recuerdo: dejamos comentado lo que hicimos en clase)

% Para simplificar tambien dejaremos de dibujar los nodos.
y_graficas_n=zeros(length(n)+1,nuPuntosGrafica);

figure (1)

xx_1=linspace(I(1),I(2),n(1));
a_1=f(xx_1);

[b_1,c_1,d_1]=splineNatural(xx_1,a_1);
y_graficas_n(1,:)=f(tx);
y_graficas_n(2,:)=splineEval(xx_1,a_1,b_1,c_1,d_1,tx);

%plot(xx_1,a_1,'*',tx,f(tx), tx,splineEval(xx_1,a_1,b_1,c_1,d_1,tx););
%ylim([-0.5,1.5])
%hold on

xx_2=linspace(I(1),I(2),n(2));
a_2=f(xx_2);
[b_2,c_2,d_2]=splineNatural(xx_2,a_2);
y_graficas_n(3,:)=splineEval(xx_2,a_2,b_2,c_2,d_2,tx);
%
%plot(xx_2,a_2,'*',tx,splineEval(xx_2,a_2,b_2,c_2,d_2,tx))
%hold on
%
xx_3=linspace(I(1),I(2),n(3));
a_3=f(xx_3);
[b_3,c_3,d_3]=splineNatural(xx_3,a_3);
y_graficas_n(4,:)=splineEval(xx_3,a_3,b_3,c_3,d_3,tx);
%
%plot(xx_3,a_3,'*',tx,splineEval(xx_3,a_3,b_3,c_3,d_3,tx))
%hold on
%
xx_4=linspace(I(1),I(2),n(4));
a_4=f(xx_4);
[b_4,c_4,d_4]=splineNatural(xx_4,a_4);
y_graficas_n(5,:)=splineEval(xx_4,a_4,b_4,c_4,d_4,tx);

%
%plot(xx_4,a_4,'*',tx,splineEval(xx_4,a_4,b_4,c_4,d_4,tx))
%hold on
%legend('x_1', 'f','s_1','x_2','s_2','x_3','s_3','x_4','s_4')

plot(tx,[y_graficas_n(1:5,:)]);
grid on
ylim([-0.5,1.5])
legend( 'f',['s ' mat2str(n(1)) ' nodos'],['s ' mat2str(n(2)) ' nodos'],['s ' mat2str(n(3)) ' nodos'],['s ' mat2str(n(4)) ' nodos'])
title('Splines naturales')

% Con la interpolación con splines naturales no aparece el 
% fenómeno Runge de la interpolación en nodos equiespaciados
% y el comportamiento es mejor que el de la interpolación con
% nodos de Chebychev. Observa que dos de los cuatro splines casi 
% coinciden con las gráficas (si ponemos números impares de nodos va mejor,
% por ejemplo con 15 parece aproximar mejor que con 20 nodos cerca dek cero)
% Observa que esta función tiene segundas derivadas pequeñas 
% en los extremos y eso ayuda (en el spline naturas las segundas
% derivadas en los extremos son cero)


%%%%

%b) Dibuja el spline cúbico sujeto con derivadas nulas (con derivadas +/- 1, o
%    derivadas +/- 100) correspondiente a n nodos equiespaciados para n = 2, 5, 15
%    y 20. Compara los resultados.


% Como en el caso del spline natural, depues de que todo funcionase vamos 
% a simplificar el código usando matrices


figure (2)
%
tan_ini= 1 ;
tan_fin=-tan_ini;
y_graficas_s=zeros(length(n)+1,nuPuntosGrafica);
y_graficas_s=f(tx);

for k=1:length(n)
xx=linspace(I(1),I(2),n(k));
aa=f(xx);
[b,c,d]=splineSujeto(xx,aa,tan_ini,tan_fin);
y_graficas_s(k+1,:)=splineEval(xx,aa,b,c,d,tx);
end

plot(tx,[y_graficas_s(1:5,:)]);
grid on
ylim([-0.5,1.5])
legend( 'f',['s ' mat2str(n(1)) ' nodos'],['s ' mat2str(n(2)) ' nodos'],['s ' mat2str(n(3)) ' nodos'],['s ' mat2str(n(4)) ' nodos'])
title(['Splines sujetos, tan\_ini = ' mat2str(tan_ini) ', tan\_fin = ' mat2str(tan_fin)])

% Al usar splines sujetos, sólo si las derivadas iniciales y finales se aproximan 
% a las de la curva vamos a poder aproximar bien
% Observad que aunque el numero de nodos sea grande en los extremos tienen
% que separarse las curvas cuando las pendientes son distintas.
% Con las tangentes = +/-100 los splines son escandalosos
% Probad también con tan_ini=10/(26^2) y tan_fin=-10/(26^2) y comparad con el spline natural

 

%  CODIGO USADO EN CLASE  PARA SPLINES SUJETOS
%xx_1=linspace(-5,+5,n(1));
%a_1=f(xx_1);
%[b_1,c_1,d_1]=splineSujeto(xx_1,a_1,tan_ini,tan_fin);
%
%plot(xx_1,a_1,'*',tx,f(tx),tx,splineEval(xx_1,a_1,b_1,c_1,d_1,tx))
%ylim([-0.5,1.5])
%hold on
%
%xx_2=linspace(-5,+5,n(2));
%a_2=f(xx_2);
%[b_2,c_2,d_2]=splineSujeto(xx_2,a_2,tan_ini,tan_fin);;
%
%plot(xx_2,a_2,'*',tx,splineEval(xx_2,a_2,b_2,c_2,d_2,tx))
%%ylim([-0.1,1.1]) el caso del spline natural
%hold on
%
%xx_3=linspace(-5,+5,n(3));
%a_3=f(xx_3);
%[b_3,c_3,d_3]=splineSujeto(xx_3,a_3,tan_ini,tan_fin);;
%
%plot(xx_3,a_3,'*',tx,splineEval(xx_3,a_3,b_3,c_3,d_3,tx))
%%ylim([-0.5,1.5])
%hold on
%%
%xx_4=linspace(-5,+5,n(4));
%a_4=f(xx_4);
%[b_4,c_4,d_4]=splineSujeto(xx_4,a_4,tan_ini,tan_fin);;
%
%plot(xx_4,a_4,'*',tx,splineEval(xx_4,a_4,b_4,c_4,d_4,tx))
%%%ylim([-0.5,1.5])
%hold on
%
%legend('x_1', 'f','s_1','x_2','s_2','x_3','s_3','x_4','s_4')
%title('Splines sujetos, con tangentes iniciales +/-1')
%


%c) Dibuja el error absoluto cometido al aproximar f por el spline sujeto y por el
%  spline natural.

figure (3,"name",['Errores abs(f-sNatural)'] )
grid on
hold on
ty=f(tx);

for k=1:length(n)
  subplot(2,ceil(length(n)/2),k)
  plot(tx,abs(ty-y_graficas_n(k+1,:)));
  title( [' Error spline natural con ' mat2str(n(k)) ' nodos'] );
end

figure (5,"name",['Errores  abs(f-sSujeto), tan_ini = ' mat2str(tan_ini) ', tan_fin = ' mat2str(tan_fin)] )
grid on
hold on
%ty=f(tx);

for k=1:length(n)
  subplot(2,ceil(length(n)/2),k)
  plot(tx,abs(ty-y_graficas_s(k+1,:)));
  title( [' Error spline sujeto con ' mat2str(n(k)) ' nodos'] );

end

figure (6,"name",['Errores abs(f-sNatural) V.S. abs(f-sSujeto), tan_ini = ' mat2str(tan_ini) ', tan_fin = ' mat2str(tan_fin)] )
grid on
hold on
%ty=f(tx);

for k=1:length(n)
  subplot(2,ceil(length(n)/2),k)
  plot(tx,[abs(ty-y_graficas_n(k+1,:));abs(ty-y_graficas_s(k+1,:))]);
  title( [' con ' mat2str(n(k)) ' nodos'] );
  legend('nat','suj');  
  if n(k) >= 15
    ylim([0,0.05])
  end

end

% Como en los apartados anteriores, depues de que todo funcionase vamos 
% a simplificar el código usando matrices

%
%xx_1=linspace(-5,+5,n(1));
%a_1=f(xx_1);
%[b_1,c_1,d_1]=splineNatural(xx_1,a_1);
%
%err_1=abs(f(tx)-splineEval(xx_1,a_1,b_1,c_1,d_1,tx));
%
%plot(xx_1,zeros(1,n(1)),'*',tx,err_1)
%ylim([-0.05,0.05])
%hold on
%
%xx_2=linspace(-5,+5,n(2));
%a_2=f(xx_2);
%[b_2,c_2,d_2]=splineNatural(xx_2,a_2);
%err_2=abs(f(tx)-splineEval(xx_2,a_2,b_2,c_2,d_2,tx));
%
%plot(xx_2,zeros(1,n(2)),'*',tx,err_2)
%%ylim([-0.1,1.1])
%hold on
%
%xx_3=linspace(-5,+5,n(3));
%a_3=f(xx_3);
%[b_3,c_3,d_3]=splineNatural(xx_3,a_3);
%
%err_3=abs(f(tx)-splineEval(xx_3,a_3,b_3,c_3,d_3,tx));
%
%plot(xx_3,zeros(1,n(3)),'*',tx,err_3)
%%ylim([-0.5,1.5])
%hold on
%
%xx_4=linspace(-5,+5,n(4));
%a_4=f(xx_4);
%[b_4,c_4,d_4]=splineNatural(xx_4,a_4);
%
%err_4=abs(f(tx)-splineEval(xx_4,a_4,b_4,c_4,d_4,tx));
%
%plot(xx_4,zeros(1,n(4)),'*',tx,err_4)
%%ylim([-0.5,1.5])
%hold on
%legend('x_1', 'e_1','x_2','e_2','x_3','e_3','x_4','e_4')
%title('Errores Splines naturales')