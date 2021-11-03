%function y = GenSignal(t,tipo,frecuencia,fase,Amplitud,offset)
%  t              Vector con instantes de tiempo
%  tipo           'coseno', 'triangular', 'cuadrada', 'aleatoriaFilt'
%  frecuencia     Frecuencia de la se�al
%  fase           Desfase de la se�al (opcional, por defecto 0) 
%  Amplitud       Amplitud de pico  (opcional, por defecto 1)
%  offset         offset de amplitud (opcional, por defecto 0)
%
% En el caso de 'aleatoriaFilt' 
%   crea una se�al aleatoria de la frecuencia y amplitud m�ximas 
%   especificadas. El par�metro fase no afecta           
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
        % Un periodo de la se�al
        x = 0:0.5/(muT/2-1):0.5;
        y0 = [x*2  -x*2+1]; 
        
        faseM = floor(fase/(2*pi)*muT);  % Desfase en muestras          
        numPer = floor(length(t)/muT); %N�mero de periodos
              
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
        
        % El �ltimo trozo       
        resto = length(t)-length(y);
        if resto > muT % Si por alg�n problema de redondeo nos falta m�s de 1 periodo
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
      error('tipo de se�al no definido')      
  end
  
  % Amplitud y offset
  if nargin > 4 
    y = Amplitud*y;
  end
  if nargin > 5
    y = y + offset;
  end   

  
  
    
  
  
  
  