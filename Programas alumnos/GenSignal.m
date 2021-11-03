%function y = GenSignal(t,tipo,frecuencia,fase,Amplitud,offset)
%  t              Vector con instantes de tiempo
%  tipo           'coseno', 'triangular', 'cuadrada', 'aleatoriaFilt'
%  frecuencia     Frecuencia de la señal
%  fase           Desfase de la señal (opcional, por defecto 0) 
%  Amplitud       Amplitud de pico  (opcional, por defecto 1)
%  offset         offset de amplitud (opcional, por defecto 0)
%
% En el caso de 'aleatoriaFilt' 
%   crea una señal aleatoria de la frecuencia y amplitud máximas 
%   especificadas. El parámetro fase no afecta           
% 
function y = GenSignal(t,tipo,frecuencia,fase,Amplitud,offset)
  
  % Fase 
  if nargin < 4
     fase = 0;
  end
   
  switch(tipo)
    case 'coseno'
        y = cos(2*pi*frecuencia*t+fase);
    case 'cuadrada'
        y = cos(2*pi*frecuencia*t+fase);  
        y(y>0) = 1;
        y(y<0) = -1;    
        
    case 'triangular'
        fs = round(1/(t(2)-t(1)));          
        muT = floor(fs/frecuencia); % Muestras por periodo  
        % Un periodo de la señal
        x = 0:0.5/(muT/2-1):0.5;
        y0 = [x*2  -x*2+1]; 
        
        faseM = floor(fase/(2*pi)*muT);  % Desfase en muestras          
        numPer = floor(length(t)/muT); %Número de periodos
              
        % Unimos todos los periodos   
        if faseM > 0                
          y = y0(muT-faseM:muT);           
        elseif fase < 0
          y = y0(muT:end);   
        else 
           y = []; 
        end            
        for i=1:numPer
          y = [y y0];              
        end    
        
        % El último trozo       
        resto = length(t)-length(y);
        if resto > muT % Si por algún problema de redondeo nos falta más de 1 periodo
           y = [y y0 y0(1:resto-muT)];
        elseif resto < 0  % Nos hemos pasado   
           y = y(1:end+resto);
        else
           y = [y y0(1:resto)];
        end    
       
        
        
    case 'aleatoriaFilt'
        y = randn(1,length(t));        
        Ts = t(2)-t(1);  
        [B,A] = butter(5,frecuencia*Ts,'low');
        y = filter(B,A,y);          
        y = y/max(abs(y));         
        
    otherwise
      error('tipo de señal no definido')      
  end
  
  % Amplitud y offset
  if nargin > 4 
    y = Amplitud*y;
  end
  if nargin > 5
    y = y + offset;
  end   

  
  
    
  
  
  
  