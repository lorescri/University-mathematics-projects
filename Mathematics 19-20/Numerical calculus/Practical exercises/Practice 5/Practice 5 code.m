clc
addpath('..\biblioteca')

%EJERCICIO 1
%APARTADO a)

format short  

%En primer lugar definimos la funcion que se da en el enunciado y la denominamos f:
f='1/2+(1/sqrt(2*pi))*exp(-x^2/2)';

%El valor de esta integral lo podemos aproximar usando el m�todo de Simpson compuesto. 
%Dividimos en intervalo de integraci�n [0,1] en,por ejmplo, 40 subintervalos
s=simpson(f,0,1,40); 


%An�logamente calculamos esta integral por el m�todo de los trapecios compuesto.
%En este caso, dividimos el intervalo [0,1] en 10 subintervalos:
t=trapecios(f,0,1,10);









%Hacemos ahora un bucle con n par hasta encontrar el que cumple |Sn+1-Sn|<10^-6
%Para ello calculamos la integral de la funci�n del enunciado entre 0 y 1 para cada n.
%Lo hacemos llamando a la funci�n simpson.m con la funcion, los limites de integraci�n y el n�mero de nodos

n=2;
s0=simpson(f,0,1,n);        %Sn
s1=simpson(f,0,1,2*n);      %S2n
while (abs(s1-s0) >= 10^-5) %Si la diferencia es mayor que 10^-5 vuelve a subdividir el intervalo de integraci�n
  n=n*2;                    %Tomamos un nuevo n�mero de subintervalos en que se divide el intervalo original.
  s0=s1;                    
  s1=simpson(f,0,1,n*2);    %Calculamos la integral de nuevo, pero cambiando el numero de subintervalos
endwhile 

n_necesario=n            %Calcula el n para el cual el error es menor de 10^-6

disp('La integral con un error menor que 10^-6 es:' );
simpson(f,0,1,n_necesario)


%APARTADO b) 
%Nuestro objetivo es obtener una tabla de valores de la integral de esta funci�n:
f='(1/sqrt(2*pi))*exp(-x^2/2)' 
%Dicha tabla se corresponde a la tabla de la distribuci�n normal


%Creamos la tabla tabla deseada
for k=0:40 %Nuestra tabla va a tener 40 filas
  for j=0:9  %Y 10 columnas
    
    s(k+1,j+1)=simpson(f, 0, k/10 + j/100,n_necesario); %Calculamos el valor aproximado de la integral por el m�todo Simpson, 
    %siendo n el numero del subintervalos necesarios para que dicha aproximacion cometa un error menos que 10^-6

  endfor
endfor
s %Mostramos la tabla 




%EJERCICIO 2
%Ya hemos contruido las f�rmulas de cuadratura de Gauss-Legendre, Gauss-Chebyshev de tres y cuatro puntos (n=2, n=3)
%Los usamos para aproximar las siguientes integrales
%Definimos la primera integral
f='sin(x)/x'

%Y calculamos su integral aproximada mediante las 4 funciones creadas:
GL2=gauss_legendre2(f,-1,1)
GL3=gauss_legendre3(f,-1,1)

GC2=gauss_chebyshev2(f,-1,1)
GC3=gauss_chebyshev3(f,-1,1)



%hacemos lo mismo con las siguientes funciones:
f='exp(x)/sqrt(1-x^2)'
GL2=gauss_legendre2(f,-1,1)
GL3=gauss_legendre3(f,-1,1)
GC2=gauss_chebyshev2(f,-1,1)
GC3=gauss_chebyshev3(f,-1,1)


f='1/1+x^2'
GL2=gauss_legendre2(f,0,2)
GL3=gauss_legendre3(f,0,2)
GC2=gauss_chebyshev2(f,0,2)
GC3=gauss_chebyshev3(f,0,2)


f='x^2*sin(x)'
GL2=gauss_legendre2(f,0,pi/4)
GL3=gauss_legendre3(f,0,pi/4)
GC2=gauss_chebyshev2(f,0,pi/4)
GC3=gauss_chebyshev3(f,0,pi/4)

f='x^2*log(x)'
GL2=gauss_legendre2(f,1,1.5)
GL3=gauss_legendre3(f,1,1.5)
GC2=gauss_chebyshev2(f,1,1.5)
GC3=gauss_chebyshev3(f,1,1.5)









%Nos piden ahora que comparemos los resultados con el metodo de simpson usando los comandos quad y quadl
%Por ejemplo vamos a comparar los resultados de la funcion f='1/1+x^2'
f='1/1+x^2';
%definimos tambi�n la funci�n f de esta forma para poder usar el m�todo quad
F=@(x)1./(1+x.^2);

GL2=gauss_legendre2(f,0,2)
GL3=gauss_legendre3(f,0,2)

GC2=gauss_chebyshev2(f,0,2)
GC3=gauss_chebyshev3(f,0,2)

q=quad(F,0,2)
ql=quadl(F,0,2)













