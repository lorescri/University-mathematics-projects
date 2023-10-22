
function nodos = nodosChebychev (a,b, n)
  nodos=zeros(1,n+1);
  for k=1:n+1
    nodos(k) =a+ (b-a)/2*(1+cos((2*k-1)*pi/(2*(n+1))));
  end

endfunction
