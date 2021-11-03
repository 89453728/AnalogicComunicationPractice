% serie de fourier de una señal cuadrada
T0=1;
T1=.5;
N=30;
t=linspace(0,5,1000);
y=zeros(1,length(t));
for k=[-N:-1,1:N]
Ck=(1-exp(-j*pi*k))/(j*pi*2*k);
y=y+(Ck*exp(j*2*pi*k*t/T0));
end
y=y+.5;
close all;
figure(1);
plot(t,real(y),'b');

