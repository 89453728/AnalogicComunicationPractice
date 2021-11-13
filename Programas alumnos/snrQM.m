% snrAM.m
% Script que estima la SNR a la salida de un sistema AM
% Asume que se ha llamado previamente a sistDBL y que las siguientes variables
% están definidas: A, a, W, xT, n, prx

% ****************** CÁLCULO SNR SIMULADA  ****************
% DEMODULADOR cuando no hay ruido
rs =r;   % Señal recibida sin ruido (la que tiene ruido se llama r)           
yss1 = rs*sqrt(2) .*prx1;          % Señal multiplicada por el tono de Rx 
yss2 = -rs*sqrt(2) .*prx2;
ss1 = filtroPasoBajo(t,yss1,WPOS); % Señal a la salida sin ruido
ss2 = filtroPasoBajo(t,yss2,WPOS);
Ps_sim1 = mean(ss1.^2);   % Potencia de la señal: Esperanza de la 
                                    % senal al cuadrado
Ps_sim2=mean(ss2.^2);
Ps_sim = Ps_sim1+Ps_sim2;

% DEMODULADOR cuando sólo hay ruido
rn = r2;  % Señal recibida cuando sólo hay ruido 
nn = rn*sqrt(2) .*prx1;           % Ruido recibido multiplicado por el tono de Rx
ns = filtroPasoBajo(t,nn,WPOS);  % Señal a la salida con sólo ruido
Pn_sim = mean(ns.^2);  % Potencia del ruido                   

% SNR en decibelios
SNR_sim = 10*log10(Ps_sim/Pn_sim);           
disp(['SNRsimul = ' num2str(SNR_sim)]);

% ****************** CÁLCULO SNR teórica  ******************

% Potencia de señal si la moduladora fuera un tono en función de A y a  
% La potencia de la senal es 1/2
Ps_teo = (mean(m1.^2) + mean(m2.^2))*(A*a)^2;                
        
% Potencia del ruido en función N0_2 y WPOS
Pn_teo = N0_2*WPOS;                 

% SNR en decibelios
SNR_teo = 10*log10(Ps_teo/Pn_teo);                 
disp(['SNRteórica = ' num2str(SNR_teo)]);