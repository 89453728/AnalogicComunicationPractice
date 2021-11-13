% serie de fourier de una señal cuadrada
T0=1;                   % periodo de la senal cuadrada
T1=.5;                  % posicion donde da el salto de 1 a 0
N=60;                  % numero de terminos de serie de fourier
m=6e4;                  % tamano del eje de tiempo
t=linspace(0,1,m);      % eje de tiempo
y=zeros(1,length(t));   % vector y donde iremos metiendo la suma de los terminos
for k=[-N:-1,1:N]   
Ck=(1-exp(-j*pi*k))/(j*pi*2*k);
y=y+(Ck*exp(j*2*pi*k*t/T0));
end
y=y+.5;                 % sumo el termino de continua
close all;          
figure(1);
plot(t,real(y),'b',t,[ones(1,m/2),zeros(1,m/2)],'--r');
legend(["senal en terminos de serie de fourier", "envolvente de la senal"]);