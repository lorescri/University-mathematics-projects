clc
addpath('..\biblioteca')

%EJERCICIO1
f=@(x) tan(pi*x)-6
biseccion(f,0,0.48,5*10^(-8))

##f=@(x) x^2
##biseccion(f,-1,1,5*10^(-8))

secante(f,0,0.48,5*10^(-8),30)

%en funcion de los x0 que hemos obtenido de esta funcion en el metodo de biseccion
%ponemos los x0 y x1 de la funcion secante
%0.36 - 0.48
%la secante puede no converger

secante(f,0.36,0.48,5*10^(-8),30)

regulafalsi(f,0,0.48,5*10^(-8),10^(-3),30) %10^(-3) es la tolerancia
                                           %5*10^(-8) es  el error
                  
x=linspace(0,0.48,100)
plot(x,f(x),x,0)                 

df=@(x) pi/(cos(pi*x))^2  
newton(f,df,0.24,5*10^(-8),30) 
%newton(f,df,x0,errorParada,maxIteraciones)            
                  
%pero este no es el punto que queremos buscar, pues nos sale un valor muy a la derecha 5 y pico
newton(f,df,0.4,5*10^(-8),30) 
  
%newton usa método de la tangente
%el problema es que al poner el muy pequeño x0,  al aplicar el metodo de la 
% tagente, se nos va a otra rama de la funcion f(la funcion tangente tiene distintas ramas)
% y en consecuencia la raices de 
%nuestra funcion se van, se van alejando.
format long
fzero(f,0.3)
      
     
     
     
%EJERCICIO2
f=@(x)x+log(x)
figure(2)
%si pongo 0,1 y 1 en vez de 0.5 y 0.6 me sale una curva
x=linspace(0.5,0.6,100)
plot(x,f(x),x,0)



g1=@(x)-log(x)
puntofijo(g1,0.55,0.5*10^(-8),30)

g2=@(x)exp(-x)
puntofijo(g2,0.55,0.5*10^(-8),35)
  
g3=@(x)(x+exp(-x))/2
puntofijo(g3,0.55,0.5*10^(-8),30) %esta solo tarda 12 pasos para converger
   
##figure(3)
##x=linspace(0.5,0.6,100)
##plot(x,g1(x),x,x)
##         
%lo hacemos en distintas matrices
         
figure(3)
subplot(1,2,1)
x=linspace(0.5,0.6,100)
plot(x,g1(x),x,x)  
 
subplot(1,2,2)
dg1=@(x)-(x.^(-1))
x=linspace(0.5,0.6,100)
plot(x,dg1(x))    
                  
                  
figure(4)
subplot(1,2,1)
x=linspace(0.5,0.6,100)
plot(x,g2(x),x,x)   
subplot(1,2,2)
dg2=@(x) exp(-x)
x=linspace(0.5,0.6,100)
plot(x,dg2(x))                 
                  
              
figure(5)
subplot(1,2,1)
x=linspace(0.5,0.6,100)
plot(x,g3(x),x,x) 
  
subplot(1,2,2)
dg3=g3=@(x)(1-exp(-x))/2
x=linspace(0.5,0.6,100)
plot(x,dg3(x))                 
          
      
df=@(x) 1+(x.^(-1))
newton(f,df, 0.5, 5*10^(-8),30)

