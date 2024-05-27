function PDP=IEEE802_11_model(sigma_t,Ts)
%IEEE 802.11 channel model PDP generator
% inputs
%sigma_t=RMS delay spread
%Ts= Sampling time

%output
%PDP= Power delay profile

lmax=ceil(10*sigma_t/Ts);
sigma02=(1-exp(-Ts/sigma_t))/(1-exp(-(lmax+1)*Ts/sigma_t));
l=0:lmax;
PDP=sigma02*exp(-l*Ts/sigma_t);
