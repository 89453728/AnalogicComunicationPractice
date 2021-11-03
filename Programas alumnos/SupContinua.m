% function y = SupContinua(x)
% Suprimer la continua de la señal de entrada 
%  x     Señal de entrada
%  y     Señal x sin continua
function y = SupContinua(x)

y = x - mean(x);


