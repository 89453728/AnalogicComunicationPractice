% function y = Rectificador(x)
% Rectifica la señal de entrada (sólo deja pasar los valores positivos)
% Demodula una señal 
%  x     Señal de entrada
%  y     Señal de salida

function y = Rectificador(x)

y = x;
y(y<0) = 0; 

y = abs(x);