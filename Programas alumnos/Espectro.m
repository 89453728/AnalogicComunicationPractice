%function Espectro(t,x)
%  t          Vector con instantes de tiempo
%  x          Señal de la que pintar el espectro 
%  Titulo     Titulo del espectro
%  f0         Frecuencia(Hz) inicial a representar (OPCIONAL)
%  fFin       Frecuencia(Hz) fin a representar (OPCIONAL)
%  marcaIni   Frecuencia(Hz) inicial en la que marcar el ancho de banda (OPCIONAL)
%  marcaFin   Frecuencia(Hz) fin en la que marcar el ancho de banda (OPCIONAL)
function Espectro(t,x,Titulo,f0,fFin,marcaIni,marcaFin)

  % Periodo de muestreo
  Ts = t(2)-t(1);    
      
  % FFT  
  X = fft(x);
  Deltaf = 1/(length(x)*Ts);
  fmax = 1/(2*Ts);
  
  % Sólo parte positiva  
  f = 0:Deltaf:fmax;  
  X = X(1:length(f));
  
  % Indices a representar  
  if nargin < 5       
    iFin = length(f); 
  else
    iFin = find(f>=fFin);  
    if isempty(iFin) 
       iFin = length(f);
    else
       iFin = iFin(1);  
    end   
  end
  if nargin < 4       
    i0 = 1; 
  else
    i0 = find(f>=f0);  
    if isempty(i0) 
       i0 = 1;
    else
       i0 = i0(1);  
    end   
  end
    
  % Marcas de ancho de banda
  m1 = 0;
  if nargin > 5
     m1 = find(f>marcaIni);
     if isempty(m1) || m1(1) < i0
        m1 = i0;
     else
        m1 = m1(1);
     end   
     m2 = find(f>marcaFin);
     if isempty(m2) || m2(1) > iFin
        m2 = iFin;
     else
        m2 = m2(1);
     end   
  end    
  
  
  % Etiqueda en Hz o en kHz
  if f(iFin) > 2000
     f=f/1000;
     etiqueta = 'f(kHz)';
  else
     etiqueta = 'f(Hz)';
  end     
      
  plot(f(i0:iFin),(abs(X(i0:iFin))/length(x)))
  xlabel(etiqueta)
  ylabel([' TF[' inputname(2) '(t)]'] )
  title(Titulo)
  grid on
  ejes = axis;
  ejes(4)=ejes(4)*1.2;
  axis(ejes);
  
  % Marcas
  if m1 > 0 
     hold on
     ejes = axis;
     plot([f(m1) f(m2)],[ejes(4)*0.9 ejes(4)*0.9],'-xr')
     hold off
  end
  
    
  
 
  

     
  
  
  
  
  
  
  