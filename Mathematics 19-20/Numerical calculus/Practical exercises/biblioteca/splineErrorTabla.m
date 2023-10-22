% Funcion para evaluar el spline en t
% Entradas:   
%            - f   funcion (interna o externa)
%            - x       = vector que contiene las abscisas de los puntos a interpolar (nodos)
%             (x(1) es el extremo izquierdo del intervalo de trabajo y x(n+1) el extremo derecho
%            - a,b,c,d = coeficientes del spline
%            - ntest = numero puntos para muestrear y maximizar errores en cada intervalo
%            - siprint = boolean (1 o 0) si imprime o no la tabla
%            
% Salida: 
%            - tabla = tabla con n filas y tres columnas, en la primera indicamos el índice del subintervalo
%                           en la segunda el error en ese subintervalo y en la tercera la abscisa donde se alcanza
%            

function tabla = splineErrorTabla(f,x,a,b,c,d,ntest,siprint)
  n=length(x)-1;
  tabla = zeros (n,3);
  for i=1:n
    tabla(i,1)=i;
    txi=linspace(x(i),x(i+1),ntest);
    erri= abs( f(txi) - (a(i)+(txi-x(i)).*(b(i)+(txi-x(i)).*(c(i)+(txi-x(i)).*d(i)))) );
    [mi,pi]=max(erri);
    tabla(i,2)=mi;
    tabla(i,3)= txi(pi);
  end
  if (siprint==true)
    display( ' Tabla con errores maximos de abs(f-spline) en los subintervalos de la partición')
     linea_0= ' n  \t  max_error  \t  x donde alcanza \n';
     printf([linea_0]);
   for i=1:n
     lineaf=' %1d \t %6d \t  %6d \n';
     printf(lineaf,tabla(i,1),tabla(i,2),tabla(i,3))
   end
   [max,pos]=max(tabla(:,2));
   printf('\n El error maximo es %d y se alcanza en %d \n', max, tabla(pos,3))
   end
end

