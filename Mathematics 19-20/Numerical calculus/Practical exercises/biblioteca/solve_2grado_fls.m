

%%## -*- texinfo -*- 
%%## @deftypefn {} {@var{retval} =} solve_2grado (@var{input1}, @var{input2})
%%##
%%## @seealso{}
%%## @end deftypefn
%%
%%## Author: MOSQUITEROP01 <MOSQUITEROP01@MOSQUITERO-01>
%%## Created: 2019-09-30

function [x1,x2]= solve_2grado_fls (a,b,c)
   global n; 
   a=fls(a);
   b=fls(b);
   c=fls(c);
   discriminante=fls(fls(b*b)-fls(4*fls(a*c)));
   raiz=fls(sqrt(discriminante));
   numeradorSuma=fls(-b+raiz);
   numeradorResta=fls(-b-raiz);
   if (abs(numeradorSuma)>abs(numeradorResta))
     x1=fls(numeradorSuma/fls(2*a));
   else
     x1=fls(numeradorResta/fls(2*a));
   end  
   x2=fls(c/fls(a*x1));
end
