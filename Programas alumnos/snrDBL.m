% snrDBL.m
% Script que estima la SNR a la salida de un sistema DBL
% Asume que se ha llamado previamente a sistDBL y que las siguientes variables
% est�n definidas: A, a, W, xT, n, prx



% ****************** C�LCULO SNR SIMULADA  ****************
% DEMODULADOR cuando no hay ruido
rs =rsin;   % Se�al recibida sin ruido                      
yss = rs*sqrt(2) .*prx;          % Se�al multiplicada por el tono de Rx 
ss = filtroPasoBajo(t,yss,WPOS); % Se�al a la salida sin ruido  
Ps_sim = _________;   % Potencia de la se�al             

% DEMODULADOR cuando s�lo hay ruido
rn = r;  % Se�al recibida cuando s�lo hay ruido 
nn = rn*sqrt(2) .*prx;           % Ruido recibido multiplicado por el tono de Rx
ns = filtroPasoBajo(t,nn,WPOS);  % Se�al a la salida con s�lo ruido
Pn_sim = N0_2;  % Potencia del ruido                   

% SNR en decibelios
SNR_sim = 20*log10(N0_2);           
disp(['SNRsimul = ' num2str(SNR_sim)]);

% ****************** C�LCULO SNR te�rica  ******************

% Potencia de se�al si la moduladora fuera un tono en funci�n de A y a  
Ps_teo = .5*Ps*(A*a)^2;                
        
% Potencia del ruido en funci�n N0_2 y WPOS
Pn_teo = _________;                 

% SNR en decibelios
SNR_teo = _________;                 
disp(['SNRte�rica = ' num2str(SNR_teo)]);
