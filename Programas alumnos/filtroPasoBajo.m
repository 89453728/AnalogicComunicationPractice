%function y = filtroPasoBajo(t,x,fcorte,felim)
%  t         Vector con instantes de tiempo
%  x         Vector de entrada
%  fcorte    Frecuencia de corte (última frecuencia que se desea que pase)
%  felim     Frecuencia eliminada (primera frecuenca que no debe pasar) (opcional)

function y = filtroPasoBajo(t,x,fcorte,felim)
  
  % Periodo de muestreo
  Ts = t(2)-t(1);  
  fnorm = fcorte*Ts*2;
  if nargin==4
      fnorm2=felim*Ts*2;
  else
      fnorm2=fnorm*1.8;
  end    
  [orden,fn]=cheb2ord(fnorm,fnorm2,3,40);
  [B,A] = cheby2(orden,40,fn);
  %freqz(B,A,2048,1/Ts)
  yf = filter(B,A,x); 
  y=yf;  
  
  