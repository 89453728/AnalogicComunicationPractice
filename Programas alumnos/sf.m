function [s]=sf(x,T,N)
% funcion que calcula la serie de fourier de una funcion discreta
%
% s = sf(x,T,N)
%
% s es la salida con la aproximacion en serie de fourier
% x es la señal real
% T es el periodo de dicha señal
% N es el numero de armonicos que quieres tener

t=linspace(0,T,length(x)); % vector de tiempo para x
s=t*0; % creo el vector de salida
for k=[-N:-1,1:N]
% calcular la integral de los coef de la serie
% los calculo mediante metodo de Riemman
Ck=(1/T)*sum(x.*exp(-j*2*pi*k*t/T));
Ck=(T/length(x))*Ck;
s=s+Ck.*exp(j*2*pi*k.*t/T);
end
% componente de k=0
s=s+(1/T)*sum(x)*(T/length(x));
end