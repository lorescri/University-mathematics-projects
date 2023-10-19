% Entrada : A  matriz nxn
% Salida: N=  Matriz de x filas y  n-r columnas 

% La funcion nucleo debe devolver una matriz N cuyas n-r columnas constituyen 
%una base del nucleo de la aplicacion lineal x ---> Ax definida en Rn con 
%valores en Rm, para B de rango r.

function N = nucleo (B)
  [m,n]=size(B);
%Construimos las matrices L,U,P,Q,R mediante la funcion LUPQGeneral
  [L,U,P,Q,r]=LUPQGeneral(B);
  control_factorizacion=norm(P*B*Q-L*U);

%Definimos las matrices Ur y G que provienen de la matriz U
  Ur=U(1:r,1:r);  %tiene dimension r×r 

  G=U(1:r,r+1:n); %tiene dimension r×(n-r)

%A continuacion obtenemos la matriz Kr que es la solucion del sistema tridiagonal Ur*Kr = -G. 
%Para ello utilizamos la funcion solveU:
  Kr=solveU(Ur,-G); %matriz de dimension r x (n-r)
  I=eye(n-r);

%Contruimos la matriz K, añadiendole a Kr las filas de la matriz identidad de dimension (n-r)
  K=[Kr;I];
%Los vectores columna de la matriz K forman una base del nucleo de U.
%Y los vectores columna de Q*K forman una base del nucleo de A. Damos la matriz N que se nos pide:
  N=Q*K ;
endfunction
