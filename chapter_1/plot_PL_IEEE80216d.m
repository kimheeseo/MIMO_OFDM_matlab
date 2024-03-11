% plot_PL_IEEE80216d.m
clear, clf, clc
fc=2e9; htx=[30 30]; hrx=[2 10]; distance=[1:1000];
for k=1:2
    y_IEEE16da(k,:)=PL_IEEE80216d(fc,distance,'A',htx(k),hrx(k),'atnt');
    y_IEEE16db(k,:)=PL_IEEE80216d(fc,distance,'B',htx(k),hrx(k),'atnt');
    y_IEEE16dc(k,:)=PL_IEEE80216d(fc,distance,'C',htx(k),hrx(k),'atnt');

    y_MIEEE16da(k,:)=PL_IEEE80216d(fc,distance,'A',htx(k),hrx(k),'atnt', 'mod');
    y_MIEEE16db(k,:)=PL_IEEE80216d(fc,distance,'B',htx(k),hrx(k),'atnt', 'mod');
    y_MIEEE16dc(k,:)=PL_IEEE80216d(fc,distance,'C',htx(k),hrx(k),'atnt', 'mod');
end

figure
semilogx(distance,y_IEEE16da(1,:),'k:','linewidth',1.5)
hold on
semilogx(distance,y_IEEE16db(1,:),'b:','linewidth',1.5)
hold on
semilogx(distance,y_IEEE16dc(1,:),'r:','linewidth',1.5)
hold on

semilogx(distance,y_IEEE16da(2,:),'k-','linewidth',1.5)
hold on
semilogx(distance,y_IEEE16db(2,:),'b-','linewidth',1.5)
hold on
semilogx(distance,y_IEEE16dc(2,:),'r-','linewidth',1.5)
hold on
grid on

axis([1 1000 10 150])
title(['IEEE 802.16d Path-loss Model, f_c=',num2str(fc/1e6),'MHz'])
xlabel('Distance[m]'), ylabel('Pathloss[dB]')
legend('type A - h_{Tx}=30m, h_{Rx}=2m','type B - h_{Tx}=30m, h_{Rx}=2m','type C - h_{Tx}=30m, h_{Rx}=2m' ,'type A - h_{Tx}=30m, h_{Rx}=10m','type B - h_{Tx}=30m, h_{Rx}=10m','type C - h_{Tx}=30m, h_{Rx}=10m')

figure
semilogx(distance,y_MIEEE16da(1,:),'k:','linewidth',1.5)
hold on
semilogx(distance,y_MIEEE16db(1,:),'b:','linewidth',1.5)
hold on
semilogx(distance,y_MIEEE16dc(1,:),'r:','linewidth',1.5)
hold on

semilogx(distance,y_MIEEE16da(2,:),'k-','linewidth',1.5)
hold on
semilogx(distance,y_MIEEE16db(2,:),'b-','linewidth',1.5)
hold on
semilogx(distance,y_MIEEE16dc(2,:),'r-','linewidth',1.5)
hold on

grid on, axis([1 1000 10 150])
title(['Modified IEEE 802.16d Path-loss Model, f_c=', num2str(fc/1e6), 'MHz'])
xlabel('Distance[m]'), ylabel('Pathloss[dB]')
legend('type A - h_{Tx}=30m, h_{Rx}=2m','type B - h_{Tx}=30m, h_{Rx}=2m','type C - h_{Tx}=30m, h_{Rx}=2m','type A - h_{Tx}=30m, h_{Rx}=10m','type B - h_{Tx}=30m, h_{Rx}=10m','type C - h_{Tx}=30m, h_{Rx}=10m')
