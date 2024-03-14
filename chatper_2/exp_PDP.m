function PDP=exp_PDP(tau_d, Ts, A_dB, norm_flag)
% exponential PDP generator
%inputs:
% tau_d: rms delay spread(sec)
% Ts: sampling time[sec]
% A_dB: smallest noticeable power[dB]
% norm_flag: normalize total power to unit

%output
% PDP: PDP vector

if nargin<4
    norm_flag=1;
end %normalization

if nargin<3
    A_dB=-20;
end % 20 dB below

sigma_tau=tau_d;
A=10^(A_dB/10);
lmax=ceil(-tau_d*log(A)/Ts);

%compute normalization factor for power noramlization
if norm_flag
    p0=(1-exp(-Ts/sigma_tau))/(1-exp(-(lmax+1)*Ts/sigma_tau));

%책에는 p0=(1-exp(-Ts/sigma_tau))/(1-exp((lmax+1)*Ts/sgima_tau))이라고 작성되어 있지만,
%normalize total power한 후, P(0)=1/(P_total*sigma_tau)를 위해서, p0의 값을 변경해야하고,
%코드는 p0=(1-exp(-Ts/sigma_tau))/(1-exp(-(lmax+1)*Ts/sgima_tau))가 되어야 한다.
%여기에서 lmax+1은 식의 p_max+1을 나타낸 것이다.
else
    p0-1/sigma_tau;
end

% exponential PDP
l=0:lmax;
PDP=p0*exp(-l*Ts/sigma_tau)

