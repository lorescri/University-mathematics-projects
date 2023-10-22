function pol=eval_interpolador_Newton(difdiv,x,t)

n=size(difdiv,1);

% Calculamos el polinomio interpolador en la forma de Horner
% Lo construimos como una cadena de caracteres

pol=0;

for i=n:-1:2
    pol=(pol+difdiv(i,i))*(t-x(i-1));
end

    
pol=pol+difdiv(1,1);
