% function y = Rectificador(x)
% Rectifica la se�al de entrada (s�lo deja pasar los valores positivos)
% Demodula una se�al 
%  x     Se�al de entrada
%  y     Se�al de salida

function y = Rectificador(x)

y = x;
y(y<0) = 0; 

y = abs(x);