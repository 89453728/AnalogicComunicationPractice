% sistDBL.m
% Script que simula un sistema de comunicaciones utilizando modulación
% en doble bandad lateral (DBL)

% ******************  PARÁMETROS ***********************
%  Parámetros generales
fs = 200E3;     % Frecuencia de muestreo
t = 0:1/fs:0.8; % Eje de tiempos

%  Parámetros del Modulador
W = 4E3;        % Ancho de banda máximo de la moduladora
fm = 1e3;       % Frecuencia de un tono dentro de la banda
f0 = 60E3;      % Frecuencia de la portadora
A = 1000;        % Amplificación de la señal transmitida
faseTx = 0;     % Desfase de la portadora usada en Transmisión
BT = 2*W;% Ancho de banda de la señal modulada en DBL

% Parámetros del Canal
a = 0.01;       % Atenuación
N0_2 = 1e-4;   % Densidad espectral de potencia del Ruido N0/2

% Parámetros del Demodulador
faseRx = 0;     % Desfase de la portadora usada en Recepción
WPOS = W; %Ancho de banda del filtro posdetector


% Parámetros de representación
t1 = 0.01;      % Instante de tiempo inicial a representar
t2 = 0.02;      % Instante de tiempo final a representar
% ******************************************************

% MODULADOR 
%m = GenSignal(t,'coseno',fm);               % 1 tono dentro de la banda
%m = GenSignal(t,'cuadrada',fm);               % 1 tono dentro de la banda
%m = GenSignal(t,'triangular',fm);               % 1 tono dentro de la banda
%m = GenSignal(t,'aleatoriaFilt',W);               % 1 tono dentro de la banda
m = GenSignalSound(t,'chord.wav',W);           % Señal de audio 


m = m/max(abs(m)); %¡m debe estar normalizada!
ptx = GenSignal(t,'coseno',f0,faseTx,A);    % Tono utilizado para modular 
xT = m * sqrt(2).*ptx;                      % Señal modulada en DBL

% CANAL (Sin Ruido)                                                                                                                
%r = a * xT;

% CANAL (Con Ruido)
r = a*xT + Ruido(t,N0_2); 

% CANAL (Solo ruido)
r2 = Ruido(t,N0_2);

% DEMODULADOR
prx = GenSignal(t,'coseno',f0,faseRx);      % Tono utilizado para demodular
rL0 = r * sqrt(2).*prx;
rL = filtroPasoBajo(t,rL0,WPOS);               % Señal demodulada  
graficas=1;
if(graficas==1) % esto es para no ir viendo graficas cuando no quiero verlas
% REPRESENTACIÓN GRÁFICA DE LAS SEÑALES
close all;
% En el tiempo
figure(1);subplot(2,2,1);Osciloscopio(t,m,'Moduladora',t1,t2);
subplot(2,2,3);Osciloscopio(t,xT,'Señal modulada',t1,t2);
subplot(2,2,2);Osciloscopio(t,r,'Señal recibida',t1,t2);
subplot(2,2,4);Osciloscopio(t,rL,'Señal demodulada',t1,t2);

% En la frecuencia
figure(2);subplot(2,2,1);Espectro(t,m,'Espectro Moduladora',0,1.5*W);
subplot(2,2,3);Espectro(t,xT,'Espectro Modulada',f0-1.5*W,f0+1.5*W,f0-BT/2,f0+BT/2);
subplot(2,2,2);Espectro(t,r,'Espectro recibida',f0-1.5*W,f0+1.5*W);
subplot(2,2,4);Espectro(t,rL,'Espectro demodulada',0,1.5*W);
end

