% function Reproducir(t,x)
% 
% Reproduce la se�al x por los altavoces/auriculares 
%  t       Vector con instantes de tiempo
%  x       Se�al de entrada
function Reproducir(t,x)

fs = 1/(t(2)-t(1));
x=x(1000:end);
sound(0.1*x/max(abs(x)),fs);
