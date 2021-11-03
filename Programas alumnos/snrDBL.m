% snrDBL.m
% Script que estima la SNR a la salida de un sistema DBL
% Asume que se ha llamado previamente a sistDBL y que las siguientes variables
% están definidas: A, a, W, xT, n, prx



% ****************** CÁLCULO SNR SIMULADA  ****************
% DEMODULADOR cuando no hay ruido
rs =rsin;   % Señal recibida sin ruido (la que tiene ruido se llama r)           
yss = rs*sqrt(2) .*prx;          % Señal multiplicada por el tono de Rx 
ss = filtroPasoBajo(t,yss,WPOS); % Señal a la salida sin ruido
% Potencia senal coseno: .5
% Potencia senal cuadrada PWM 50%: .5
% Potencia senal triangular: 
%
Ps_sim = sum(ss.^2)/length(ss);   % Potencia de la señal: Esperanza de la 
                                    % se

% DEMODULADOR cuando sólo hay ruido
rn = r;  % Señal recibida cuando sólo hay ruido 
nn = rn*sqrt(2) .*prx;           % Ruido recibido multiplicado por el tono de Rx
ns = filtroPasoBajo(t,nn,WPOS);  % Señal a la salida con sólo ruido
Pn_sim = N0_2;  % Potencia del ruido                   

% SNR en decibelios
SNR_sim = 20*log10(N0_2);           
disp(['SNRsimul = ' num2str(SNR_sim)]);

% ****************** CÁLCULO SNR teórica  ******************

% Potencia de señal si la moduladora fuera un tono en función de A y a  
Ps_teo = .5*Ps*(A*a)^2;                
        
% Potencia del ruido en función N0_2 y WPOS
Pn_teo = N0_2*WPOS;                 

% SNR en decibelios
SNR_teo = 20*log10(N0_2);                 
disp(['SNRteórica = ' num2str(SNR_teo)]);
