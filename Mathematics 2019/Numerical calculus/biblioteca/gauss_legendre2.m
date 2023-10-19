function I=gauss_lengendre2(f,a,b)
  %creamos los nodos
  z=[0 1/5*sqrt(15) -1/5*sqrt(15)]; 
  
  %creamos los coeficientes
  c=[8/9 5/9 5/9];
  
  %formula para -1,1:
  I=0;
  for i=1:3      %GAUSS LEGENDRE 2
        x=(b-a)/2 * z(i) + (a+b)/2; %cambio de variable para llevarlo al intervalo (a,b)
        I=I+c(i)*eval(f); %I=suma ci*f(xi), por la fórmula de la cuadratura de gauss

  endfor

  I=(b-a)/2 * I; %Pues I[a,b] = I[-1,1]*(b-a)/2, por el ejercicio 18 de la relación de ejercicios

endfunction
