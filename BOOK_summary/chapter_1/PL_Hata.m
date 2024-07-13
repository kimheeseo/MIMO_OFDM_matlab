function PL=PL_Hata(fc,d,htx, hrx, Etype)
% Hata path loss model

%inputs
% htx: height of transmitter [m]
% hrx: height of receiver [m]
% Etype : environment type('urban', 'suburban','open')

%output
% PL:path loss[dB]
if nargin<5
    Etype='URBAN'
end
fc=fc/(1e6);
if fc>=150 && fc<=200
    C_RX=8.29*(log10(1.54*hrx))^2-1.1;
elseif fc>200
    C_RX=3.2*(log10(11.75*hrx))^2-4.97;
else
    C_RX=0.8+(1.1*log10(fc)-0.7)*hrx-1.56*log10(fc)
end

PL=69.55+26.16*log10(fc)-13.82*log10(htx)-C_RX+(44.9-6.55*log10(htx))*log10(d/1000);
EType=upper(Etype);
if EType(1)=='S'%suburban area
    PL=PL-2*(log10(fc/28))^2-5.4
elseif EType(1)=='O' %open area
    PL=PL+(18.33-4.78*log10(fc))*log10(fc)-40.97
end

