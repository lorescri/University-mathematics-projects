%Funcion que dada una matriz simatrica A, devuelve los valores y vectores propios de esta matriz
function [vp,V]=QRvp(A) 
  global nmaxit;
  %Utilizamos el metodo tridQHouseholder.m de la practica 5 que devuelve una matriz tridiagonal T:
  [Q,T]=tridQHouseholder(A);
   
  %A continuación vamos a utilizar nuestra funcion creada en el primer apartado para obtener 
  %un vector columna con los valores propios de la matriz simetrica A y una matriz V 
  %cuyos vectores columna forman una base de vectores propios.
  [vp,V]=QRtrid(T);
  
  %Devolvemos este vector vp, que contiene los valores propios de A y la matriz V, cuyas columnas son 
  %los vectores propios de A
  
endfunction
