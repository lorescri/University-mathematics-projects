%Funcion que resuelve el sistema A*x=b
function X = solveGaussParcial(A, b)
  [L,U,P] = LUPGauss(A);
  X = solveU(U, solveL(L, P*b));
endfunction