% sistQM.m
% Script que simula un sistema de comunicaciones utilizando modulaci�n MQ

% ******************  PAR�METROS ***********************
%  Par�metros generalres
fs = 200E3;     % Frecuencia de muestreo
t = 0:1/fs:0.8; % Eje de tiempos

%  Par�metros del Modulador
W = 4E3;        % Ancho de banda m�ximo de las moduladoras
fm1 = 1E3;      % Frecuencia de un tono dentro de la banda
fm2 = 0.2E3;    % Frecuencia de otro se�al dentro de la banda
f0 = 20E3;      % Frecuencia de la portadora
A = 100;        % Amplificaci�n de la se�al transmitida
faseTx = 0;     % Desfase de la portadora usada en Transmisi�n
Bt = _________ ;% Ancho de banda de la se�al modulada MQ

% Par�metros del Canal
a = 0.01;       % Atenuaci�n
N0_2 = 0;%1e-10;   % Densidad espectral de potencia del Ruido

% Par�metros del Demodulador
faseRx = 0;     % Desfase de la portadora usada en Recepci�n
WPOS= _________; %Ancho de banda del filtro posdetector

% Par�metros de representaci�n
t1 = 0.01;      % Instante de tiempo inicial a representar
t2 = 0.02;      % Instante de tiempo final a representar
% ******************************************************

% MODULADOR 
% Se�al en fase
m1 = GenSignal(t,'coseno',fm1);         % Se�al en fase
%m1 = GenSignalSound(t,'chord',W);     % Se�al de audio 
m2= GenSignal(t,'triangular',fm2,pi/2); % Se�al en cuadratura
%m2 = GenSignalSound(t,'ding',W); 

ptx1 = GenSignal(t,'coseno',f0,faseTx,A);      % Portadora en fase          
ptx2 = GenSignal(t,'coseno',f0,faseTx+_________,A); % Portadora en cuadratura

xT = _________;      % Se�al modulada

% CANAL (SIN RUIDO)
r = _________;  % Se�al recibida
                

% DEMODULACI�N DE LA COMPONENTE EN FASE
prx1 = GenSignal(t,'coseno',f0,faseRx);      % Tono utilizado para demodular en fase
ys = r *sqrt(2) .*prx1;
s1 = filtroPasoBajo(t,ys,WPOS);              % Se�al demodulada en fase

% DEMODULACI�N DE LA COMPONENTE EN CUADRATURA
prx2 = GenSignal(t,'coseno',f0,faseRx +_________);   % Tono utilizado para demodular en fase
ys = _________; 
s2 = _________; % Se�al demodulada en cuadratura

% REPRESENTACI�N GR�FICA DE LAS SE�ALES
close all;
% En el tiempo
figure(1); subplot(2,2,1); Osciloscopio(t,m1,'Moduladora1',t1,t2);
subplot(2,2,2);Osciloscopio(t,m2,'Moduladora2',t1,t2);
subplot(2,2,3);Osciloscopio(t,s1,'Se�al demodulada1',t1,t2);
subplot(2,2,4);Osciloscopio(t,s2,'Se�al demodulada2',t1,t2);

figure(2);subplot(2,1,1);Osciloscopio(t,xT,'Se�al modulada',t1,t2);
subplot(2,1,2);Osciloscopio(t,r,'Se�al recibida',t1,t2);

% En la frecuencia
figure(3);subplot(2,2,1);Espectro(t,m1,'Espectro Moduladora1',0,1.5*W);
subplot(2,2,2);Espectro(t,m2,'Espectro Moduladora2',0,1.5*W);
subplot(2,2,3);Espectro(t,s1,'Espectro demodulada1',0,1.5*W);
subplot(2,2,4);Espectro(t,s2,'Espectro demodulada2',0,1.5*W);

figure(4);subplot(2,1,1);Espectro(t,xT,'Espectro Modulada',f0-1.5*W,f0+1.5*W,f0-Bt/2,f0+Bt/2);
subplot(2,1,2);Espectro(t,r,'Espectro recibida',f0-1.5*W,f0+1.5*W);

