function I=gauss_chebyshev2(f,a,b)
  %creamos los nodos
  z=[0 sqrt(3)/2 -sqrt(3)/2]; 
  
  %creamos los coeficientes
  c=[pi/3 pi/3 pi/3];
  
  %formula para -1,1:
  I=0;
  for i=1:3      %GAUSS CHEBYSHEV 2
        x=(b-a)/2 * z(i) + (a+b)/2; %cambio de variable para llevarlo al intervalo (a,b)
        I=I+c(i)*eval(f); %I=suma ci*f(xi), por la fórmula de la cuadratura de gauss

  endfor

  I=(b-a)/2 * I;

endfunction
