%function y = GenSignalSound(t,archivo)
% Genera un vector con las muestras del archivo WAV especificado
%  t        Vector con instantes de tiempo
%  archivo  Nombre del archivo wav
%  B        Máxima frecuencia de la señal de salida (ancho de banda de la señal moduladora)
% Devuelve:
%  y        Vector con las muestras de la señal de salida
%           Si el archivo de sonido se corresponde con más tiempo del
%           especificado en t, sólo se devolverá las muestras que
%           corresponde a la t especificada
function y = GenSignalSound(t,archivo,B)

fs = 1/(t(2)-t(1));
[yE,fsA] = audioread(archivo);

% Cogemos sólo un canal
canal1 = yE(:,1);

% Factor de sobremuestreo
factor = round(fs/fsA);  % No consideramos parte decimal, redondeamos y ya está.
if factor >= 1 
   % Intercalamos 0 
   y = zeros(1,length(canal1)*factor);
   y(1:factor:end) = canal1;    
   Ts = 1/fs;   
  
   % Filtramos para quitar los ceros del diezmado y 
   % para que la máxima frecuencia sea la especificada
   y = filtroPasoBajo(t,y,B);
   
   % Ajustamos
   maximo1 = max(canal1);
   maximo2 = max(y);
   y = y * maximo1/maximo2;   
   
   % Añadimos 0.1 segundos de ceros al principio para eliminar transitorios     %_QUITAR_LINEA_
   %y = [zeros(1,round(.1*fs)) y];                                              %_QUITAR_LINEA_
   
   
   % Sólo se cogen las muestras a las que corresponde la variable t
   if length(t) > length(y)
      warning([' En ' archivo ' no hay tantas muestras. La variable y devuelta tiene menos longitud que la variable t especificada'])
   else   
     y = y(1:length(t));
   end 
else
   error('No se contempla que la frecuencia de muestreo sea menor que la del archivo') 
end
    



