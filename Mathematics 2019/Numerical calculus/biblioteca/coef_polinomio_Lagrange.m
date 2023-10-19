function polLagrange=coef_polinomio_Lagrange(x,y)
  n=lenght(x);
if length(y) ~= n+1
   error('las dimensiones de x e y no coinciden');
 end
 


for i=1:n
  k=i;
  L(k)=1;
  for j=1:n
    if k~=j
      L(k)=L(k)*(a-x(j))/(x(k)-x(j));
  end
end

pol(a)=0;
for i=1:n
  pol(a)=pol(x)+y(i)*L(i)
  end
    
end
    disp('pol')
