function I=gauss_chebyshev3(f,a,b)
  %creamos los nodos
  z=[1/2*sqrt(2-sqrt(2)) -1/2*sqrt(2-sqrt(2)) 1/2*sqrt(2+sqrt(2)) -1/2*sqrt(2+sqrt(2))]; 
  
  %creamos los coeficientes
  c=[pi/4 pi/4 pi/4 pi/4];
  
  %formula para -1,1:
  I=0;
  for i=1:4      %GAUSS CHEBYSHEV 3
        x=(b-a)/2 * z(i) + (a+b)/2; %cambio de variable para llevarlo al intervalo (a,b)
        I=I+c(i)*eval(f); %I=suma ci*f(xi), por la fórmula de la curvatura de Gauss

  endfor

  I=(b-a)/2 * I; %pues I[a,b]=I[-1,1] * (b-a)/2

endfunction
