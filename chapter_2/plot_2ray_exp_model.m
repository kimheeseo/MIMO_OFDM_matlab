scale=1e-9;
Ts=10*scale; % sampling time
t_rms=30*scale; % RMS delay spread
num_ch=10000;

%2-ray model
pow_2=[0.5 0.5]; delay_2=[0 t_rms*2]/scale;
H_2=[Ray_model(num_ch); Ray_model(num_ch)].'*diag(sqrt(pow_2));
avg_pow_h_2=mean(H_2.*conj(H_2));

figure
stem(delay_2, pow_2, 'ko')
hold on
stem(delay_2, avg_pow_h_2,'k.')
xlabel('delay[ns]')
ylabel('channel power[linear]')
title('2-ray model')
legend('ideal','simulation')
axis([-10 140 0 0.7])
%결과를 보면, 2번째 point가 Rayleigh channel model에 의해 60ns만큼 delay된 것을 볼 수 있다. 
% 60ns만큼 delay 된 것은 delay_2에 의해서 알 수 있다.

% Exponential model
pow_e=exp_PDP(t_rms,Ts);
delay_e=[0:length(pow_e)-1]*Ts/scale;

for i=1:length(pow_e)
    H_e(:,i)=Ray_model(num_ch).'*sqrt(pow_e(i));
end

avg_pow_h_e=mean(H_e.*conj(H_e));

figure
stem(delay_e, pow_e,'ko')
hold on
stem(delay_e, avg_pow_h_e,'k.')
xlabel('delay[ns]')
ylabel('channel power[linear]')
title('exponential model')
axis([-10 140 0 0.7])
legend('ideal','simulation')
