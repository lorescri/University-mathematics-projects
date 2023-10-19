% Metodo para encontrar los valores y vectores propios
% de una matriz tridiagonal simetrica
% devuelve un vector con los valores propios y una 
% matriz con aproximaciones a los vectores propios

function [vp,V,iter,control] = QRTRid (A,nmaxit)
  
%  global precision;
%  n=length(A);
%  global desplazamiento;
%  U=A; % para las etapas A_k
%  V=eye(n);
%  iter=Inf;
%  control=Inf;
%  for k=1:nmaxit
%    [Q,R]=QRhouseholder(U);
%    %Utilizamos el metodo que construimos en la practica anterior para obtener la 
%    %factorizacion QR de A
%    %[Q,R]=QRMatrices(A) 
%    U=R*Q;
%    V=V*Q;
%    control=norm(tril(U,-1));
%    if control < precision
%      display(' Matriz triangular ');
%      iter=k;
%      break;
%    end
%  
%  end
%  vp=diag(U);
%  
%  U

 global precision;
  n=length(A);
  global desplazamiento;
  U=A; % para las etapas A_k
  V=eye(n);
  iter=Inf;
  control=Inf;
  for k=1:nmaxit
    [Q,R]=QRhouseholder(U);
    U=R*Q;
    V=V*Q;
    control=norm(tril(U,-1));
    if control < precision
      display(' Matriz triangular ');
      iter=k;
      break;
    end
  
  end
  vp=diag(U);
  
  U
  
endfunction
