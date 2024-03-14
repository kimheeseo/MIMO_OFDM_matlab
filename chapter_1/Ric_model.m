function H=Ric_model(K_dB,L)
%rician channel model
% input
% K_dB=K factor[dB]

% output
% H=channel vector

K=10^(K_dB/10);
H=sqrt(K/(K+1))+sqrt(1/(K+1))*Ray_model(L);
