%function Osciloscopio(t,x,titulo)
%  t              Vector con instantes de tiempo
%  x              Señal a pintar
%  titulo         Título de la figura a pintar
%  t0             Instante de tiempo a partir del que pintar (OPCIONAL)
%  tFin           Instante de tiempo hasta donde pintar (OPCIONAL)

function Osciloscopio(t,x,titulo,t0,tFin)
  
  % Índices a partir y hasta de lo que hay que pintar
  if nargin < 5 
    iFin = length(t);
  else
    iFin = find(t>=tFin); 
    if isempty(iFin) 
       iFin = lenght(t);
    else
       iFin = iFin(1); 
    end   
  end
  if nargin < 4
    i0 = 1;
  else
    i0 = find(t>=t0);  
    if isempty(i0) 
       i0 = 1;
    else
       i0 = i0(1); 
    end   
  end
  
  % Se pinta 
  plot(t(i0:iFin),x(i0:iFin))
  grid on
  xlabel('t')
  ylabel([inputname(2) '(t)'])
  
 % Ajuste de ejes
  maximo = max(x(i0:iFin));
  minimo = min(x(i0:iFin));
  ejes = axis;
  if minimo < 0
    ejes(3) = minimo*1.2;
  else
   if minimo > 0
     ejes(3) = minimo - minimo * .2;
   end     
  end  
  ejes(4) = maximo*1.2;   
  ejes(1)=t(i0);
  ejes(2)=t(iFin);
  axis(ejes) 
  title(titulo)
  
  
  
  
  
  