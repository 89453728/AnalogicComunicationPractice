% function Reproducir(t,x)
% 
% Reproduce la señal x por los altavoces/auriculares 
%  t       Vector con instantes de tiempo
%  x       Señal de entrada
function Reproducir(t,x)

fs = 1/(t(2)-t(1));
x=x(1000:end);
sound(0.1*x/max(abs(x)),fs);
