%EXAMEN PRACTICAS ENERO 2020
%EJERCICIO 1
addpath('..\biblioteca')
clc

f=@(x)exp(-1./x.^2);

%Apartado a)
%construimos los nodos de interpolacion equiespaciados
xx11=linspace(-3/2, 3/2, 11)
%creamos la tabla de diferencias divididas
difdiv11=diferencias_divididas(xx11,f(xx11));
%construimos el polinomio interpolador de f de grado 10
p10=coef_polinomio_interpolador(difdiv11,xx11);
%Si queremos podemos darlo como una cadena de caracteres usando la funcion polinomio_interpolador_newton(difdiv,x)
%pol=polinomio_interpolador_newton(difdiv11,x)


%Apartado b)
%Dibujamos
%Por ejemplo ponemos 100 puntos 
x=linspace(-3/2, 3/2,100);
%vamos a evaluar la siguiente expresion en los puntos generados en la linea anterior
y=exp(-1./x.^2);

title('n=10')
figure(1)
plot(x,y,'r',x,polyval(p10,x),xx11,f(xx11),'o')


%Apartado c)
%Creamos los nodos de Tchebychev a partir de la funci�n dada en el enunciado
%Los guardamos en un vector. En este caso lo hemos llamado xx11
for k=1:11
xx11(k)=5*cos((2*(k-1)+1)*pi/22);
endfor

yy11=exp(-1./x.^2);
%Construimos la tabla de diferncias divididas
difdiv11=diferencias_divididas(xx11,yy11);
%Y el polinomio interpolador
PT10=coef_polinomio_interpolador(difdiv11,xx11);


%Apartado d)
%Dibujamos
%Por ejemplo ponemos 100 puntos 
x=linspace(-3/2, 3/2,100);
y=exp(-1./x.^2);
title('n=10')
figure(2);
plot(x,y,'r',x,polyval(PT10,x),xx11,yy11,'o')



%Apartado e)
n=11; %queremos generar 11 nodos
x=linspace(-3/2,3/2,n)
f=@(x)exp(-1./x.^2);

%La funcion spline natural necesita como parametros las abscisas x y las ordenadas a que son los valores que toma la x en la funcion
%Devuelve b(x-x0)+c(x-x0)^2+d(x-x0)^3, devuelve los coef b,c,d

[b,c,d]=splineNatural(x,f(x));
a=f(x);
splineTabla(x,a,b,c,d);

%dibujamos la funcion usando la funcion splineEval
figure(3)
r=linspace(-3/2,3/2,100);
plot(r,f(r),r,splineEval(x,a,b,c,d,r))



%Apartado f)
%Comparamos los resultados obtenidos, dibujamos la grafica del error.
legend('funcion' , 'spline natural')
plot(r,abs(f(r)-splineEval(x,a,b,c,d,r)))%grafica del error
legend('error abs' )




%EJERCICIO 2
%Apartado a)
%Dibujamos la funcion y lo comprobamos
f=@(x) exp(x)+2*x;

x = linspace(-10,10,100);

figure(4)
plot(x,f(x))

%Apartado b)
%Para usar el metodo de newton debemos pasarle como parametro la funcion f a la cual le queremos buscar un cero
%la derivada de f, x0 que es el punto inicial de la iteracion , por ejemplo hemos puesto 0.5, el error de parada, y 
%finalmente el numero maximo de repeticiones, hemos puesto por ejemplo 30
f=@(x) exp(x)+2*x;
df=@(x) exp(x)+2;
newton(f,df, -0.25, 10^(-10),30)



%Apartado c)
%Para usar el metodo de biseccion debemos pasarle como parametros a la funcion biseccion la funcion a la que le 
%queremos buscar los ceros, a,b, y el error de parada,que se da en el enunciado
biseccion(f, -0.5, 0, 10^(-10))



%Apartado d)
%Para usar el metodo de la secante, tenemos que pasarle como parametros a la funcion secante la funcion a la que le 
%queremos buscar los ceros, x0, x1, el error de parada y el maximo numero de iteraciones
secante(f,-0.5, 0, 10^(-10),30)



















