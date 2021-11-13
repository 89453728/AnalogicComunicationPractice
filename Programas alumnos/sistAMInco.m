% sistAMInco.m
% Script que simula un sistema de comunicaciones utilizando modulación
% en amplitud (AM) con un demodulador incoherente

% ******************  PARÁMETROS ***********************
%  Parámetros generales
fs = 400E3;     % Frecuencia de muestreo
t = 0:1/fs:0.8; % Eje de tiempos

%  Parámetros del Modulador
W = 4E3;        % Ancho de banda máximo de la moduladora
fm = 1E3;      % Frecuencia de un tono dentro de la banda
f0 = 20E3;      % Frecuencia de la portadora
A = 100;        % Amplificación de la señal transmitida
faseTx = 0;     % Desfase de la portadora usada en Transmisión
Deltaf=500;     % Error de frecuencia
mu=1;          % constante de modulacion
BT = 2*W;% Ancho de banda de la señal modulada en AM

% Parámetros del Canal
a = 0.01;       % Atenuación
N0_2 = 1e-12;   % Densidad espectral de potencia del Ruido N0/2

% Parámetros del Demodulador
faseRx = 0;     % Desfase de la portadora usada en Recepción
WPOS= W;        %Ancho de banda del filtro posdetector 


% Parámetros de representación
t1 = 0.01;      % Instante de tiempo inicial a representar
t2 = 0.02;      % Instante de tiempo final a representar
% ******************************************************

% MODULADOR 
%m = GenSignal(t,'coseno',fm);               % 1 tono dentro de la banda
%m = GenSignal(t,'cuadrada',fm);               % 1 tono dentro de la banda
m = GenSignal(t,'triangular',fm);               % 1 tono dentro de la banda
%m = GenSignal(t,'aleatoriaFilt',W);               % 1 tono dentro de la banda
%m = GenSignalSound(t,'ding.wav',W);           % Señal de audio 

m=SupContinua(m);
m=m/max(abs(m)); %¡m debe estar normalizada!
ptx = GenSignal(t,'coseno',f0+Deltaf,faseTx,A);    % Tono utilizado para modular 
xT = (1 + mu*m) * sqrt(2).*ptx;                % Señal modulada en AM

% CANAL (Sin Ruido)                                                                                                                
r = a * xT;

% CANAL (Con Ruido)
%r = a*xT + Ruido(t,N0_2); 

% CANAL (Solo ruido)
r2=Ruido(t,N0_2);

% DEMODULADOR
rL0=Rectificador(r);
rL1=filtroPasoBajo(t,rL0,WPOS);
rL=SupContinua(rL1);

graficas=[1,1,1];
% REPRESENTACIÓN GRÁFICA DE LAS SEÑALES
close all;
% En el tiempo
if(graficas(1)==1)
figure(1);
subplot(2,2,1);Osciloscopio(t,m,'Moduladora',t1,t2);
subplot(2,2,3);Osciloscopio(t,xT,'Señal modulada',t1,t2);
subplot(2,2,2);Osciloscopio(t,r,'Señal recibida',t1,t2);
subplot(2,2,4);Osciloscopio(t,rL,'Señal demodulada',t1,t2);
end
if(graficas(2)==1)
% Solicitadas en el apartado 3.4
figure(2);
subplot(2,2,1);Osciloscopio(t,rL0,'Señal tras el rectificador',t1,t2);
subplot(2,2,2);Osciloscopio(t,r,'Señal recibida',t1,t2);
subplot(2,2,3);Osciloscopio(t,rL1,'Señal tras el filtro Paso Bajo',t1,t2);
subplot(2,2,4);Osciloscopio(t,rL,'Señal tras el supresor de continua',t1,t2);
end
if(graficas(3)==1)
% En la frecuencia
figure(3);
subplot(2,2,1);Espectro(t,m,'Espectro Moduladora',0,1.5*W);
subplot(2,2,3);Espectro(t,xT,'Espectro Modulada',f0-1.5*W,f0+1.5*W,f0-BT/2,f0+BT/2);
subplot(2,2,2);Espectro(t,r,'Espectro recibida',f0-1.5*W,f0+1.5*W);
subplot(2,2,4);Espectro(t,rL,'Espectro demodulada',0,1.5*W);
end