% function y = SupContinua(x)
% Suprimer la continua de la se�al de entrada 
%  x     Se�al de entrada
%  y     Se�al x sin continua
function y = SupContinua(x)

y = x - mean(x);


