
%%
%%## -*- texinfo -*- 
%%## @deftypefn {} {@var{retval} =} fls (@var{x},)
%%##  Usa una variable global n con el número de dígitos a redondear
%%     x es la variable a redondear
%%     retval es el redondeado simétrico con n dígitos
%%## @seealso{}
%%## @end deftypefn
%%
%%## Author: MOSQUITEROP01 <MOSQUITEROP01@MOSQUITERO-01>
%%## Created: 2019-09-30


function retval = fls (x)
 global n;
 retval= eval(mat2str(x,n));
end









