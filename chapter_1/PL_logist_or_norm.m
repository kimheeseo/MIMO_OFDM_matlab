% log-distance/normal shadowing path loss model

function PL=PL_logist_or_norm(fc,d,d0,n,sigma)
 % log-distance or log-normal shadowing path loss model
 % inputs
 % fc: carrier frequency[hz]
 % d: distance between base station and mobile station[m]
 % d0: reference distance[m]
 % n: path loss exponent
 % sigma: variance[dB]
 
 lamda=3e8/fc;
 PL=-20*log10(lamda/(4*pi*d0))+10*n*log10(d/d0);
 if nargin>4
     PL=PL+sigma*randn(size(d));
 end
