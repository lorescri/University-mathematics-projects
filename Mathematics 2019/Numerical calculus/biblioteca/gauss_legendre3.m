function I=gauss_legendre3 (f,a,b)
  %creamos los nodos
  z=[sqrt((3-2*sqrt(6/5))/7) -sqrt((3-2*sqrt(6/5))/7) sqrt((3+2*sqrt(6/5))) -sqrt((3+2*sqrt(6/5)))]; 
  
  %creamos los coeficientes
  c=[(18+sqrt(30))/36 (18+sqrt(30))/36 (18-sqrt(30))/36 (18-sqrt(30))/36];
  
  %formula para -1,1:
  I=0;
  for i=1:4      %GAUSS LEGENDRE 3
        x=(b-a)/2 * z(i) + (a+b)/2; %cambio de variable para llevarlo al intervalo (a,b)
        I=I+c(i)*eval(f); %I=suma ci*f(xi), por la fórmula de la curvatura de Gauss

  endfor

  I=(b-a)/2 * I; %Pues I[a,b]=I[-1,1] * (b-a)/2

endfunction
