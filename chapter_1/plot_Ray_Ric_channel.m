N=200000;
level=30;K_dB=[-40 15];
gss=['k-s';'b-o';'r-^'];

% rayleigh model
Rayleigh_ch=Ray_model(N);
[temp,x]=hist(abs(Rayleigh_ch(1,:)),level);
plot(x,temp, gss(1,:))
hold on

% rician model
for i=1:length(K_dB)
    Rician_ch(i,:)=Ric_model(K_dB(i),N);
    [temp, x]=hist(abs(Rician_ch(i,:)),level);
    plot(x,temp,gss(i+1,:))
end
xlabel('x')
ylabel('occurrence')
legend('rayleigh','rician','K=-40dB','Rician,K=15dB')
