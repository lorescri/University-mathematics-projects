%Funcion que devuelve la factorizacion QR de una matriz simetrica tridiagonal

function [Q,R]=QRMatrices(T) 
%Llamamos n a la dimesion de T
n=length(T);
%Primero contruimos la matriz de rotacion Pk
%Para ello necesitos calcular los senos y los cosenos utilizando la formula del algoritmo
%Inicializamos las matrices iniciales R y Q
R=T;
Q=eye(size(T));
%A continuacion costruimos un bucle, en el que se va a ir generando en cada iteracion la matriz P_i,
% que la construimos a partir del seno y del coseno obtenidos de la matriz A_i.
%Nota: A_0 = T, donde T es la matriz tridiagonal de entrada.
%Esta ultima matriz A_i =:R_i se va a ir actualizando en cada iteracion al ser multiplicada por la izqd
% por la matriz P, como nos indica el algoritmo hacemos R_i = P * R_i-1.
%Y tambien iremos actualizando la matriz Q_k = Q_k-1 * P_i. 
%En el bucle no vamos a utilizar subindices, simplemente en cada iteracion se iran
% actualizando las matrices:
for i=1:n-1
  s=R(i+1,i)/sqrt(R(i+1,i)^2+R(i,i)^2);
  c=R(i,i)/sqrt(R(i+1,i)^2+R(i,i)^2);
  %Construimos la matriz auxiliar 2x2,C, que contiene los valores sen y cos calculados antes
  C=[c,s;-s,c];
  %Para generar la matriz P por bloques usamos la funcion blkdiag(A,B) ya implementada en octave
  %Podemos comprobar que esta matriz solo deja juntar dos matrices,
  % luego necesitamos una matriz auxiliar, V, para construir P:
   V=blkdiag(eye(i-1),C);
   P=blkdiag(V,eye(n-i-1));
  %Construimos las matrices Q y R de manera recursiva,como se indica en el algoritmo del metodo QR
   Q=Q*P';
   R=P*R;
  endfor
%Finalmente mostramos las matrices Q y R calculadas
 Q
 R
endfunction
