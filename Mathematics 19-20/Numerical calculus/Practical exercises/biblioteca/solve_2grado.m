

%%## -*- texinfo -*- 
%%## @deftypefn {} {@var{retval} =} solve_2grado (@var{input1}, @var{input2})
%%##
%%## @seealso{}
%%## @end deftypefn
%%
%%## Author: MOSQUITEROP01 <MOSQUITEROP01@MOSQUITERO-01>
%%## Created: 2019-09-30

function [x1,x2]= solve_2grado (a,b,c)
   discriminante=b*b-4*a*c;
   raiz=sqrt(discriminante);
   numeradorSuma=-b+raiz;
   numeradorResta=-b-raiz;
   if (abs(numeradorSuma)>abs(numeradorResta))
     x1=numeradorSuma/(2*a);
   else
     x1=numeradorResta/(2*a);
   end  
   x2=c/(a*x1);
end
