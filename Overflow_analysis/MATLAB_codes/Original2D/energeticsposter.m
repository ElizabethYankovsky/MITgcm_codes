clear all
close all

load CPE_KE10.mat
load CPE_KE60.mat
load CKE_DISS10.mat
load CKE_DISS60.mat
load XC.mat
load topo.mat
load dKEdt10.mat; load dKEdt60.mat
load flux210.mat; load flux260.mat
figure(1)
%set(gcf,'units','points','position',[50,50,400,500])
set(gcf,'units','points','position',[514,600,560,498])
subplot(3,1,1)
area(XC/1000,-topo,-2500,'Facecolor',[.8 .8 .8])
xlim([0 75]); ylim([-2500 0]); grid on;
set(gca,'Fontsize',14);

subplot(3,1,2)
a=smooth(nanmean(CPE_KE10),50);
b=smooth(nanmean(-CKE_DISS10),50);
d=smooth(nanmean(flux210),50);
e=smooth(dKEdt10,50);

plot(XC/1000,a,'Color',[255 83 73]/255,'Linewidth',1.5); grid on; hold on;
plot(XC/1000,b,'Color',[0 0 0.5],'Linewidth',1.5)
plot(XC/1000,smooth(a-b),':k','Linewidth',1.5);
plot(XC/1000,smooth(e+d),'Color',[25 190 121]/255,'Linewidth',1.5);
legend('Conversion of PE to KE','Conversion of KE to DISS','Difference (Creation-Destruction of KE)','Time change plus flux of KE')
ylabel('[m^2/s^3]')
title('10 Days')
xlim([0 75]); grid on
ylim([-2e-7 12e-7]);
set(gca,'Fontsize',14);

subplot(3,1,3)
a=smooth(nanmean(CPE_KE60),50);
b=smooth(nanmean(-CKE_DISS60),50);
d=smooth(nanmean(flux260),50);
e=smooth(dKEdt60,50);
plot(XC/1000,a,'Color',[255 83 73]/255,'Linewidth',1.5); grid on; hold on;
plot(XC/1000,b,'Color',[0 0 0.5],'Linewidth',1.5)
plot(XC/1000,smooth(a-b),':k','Linewidth',1.5);
plot(XC/1000,smooth(e+d),'Color',[25 190 121]/255,'Linewidth',1.5);
legend('Conversion of PE to KE','Conversion of KE to DISS','Difference (Creation-Destruction of KE)','Time change plus flux of KE')
ylabel('[m^2/s^3]');
title('60 Days')
xlim([0 75]); grid on
ylim([-2e-7 12e-7]);
set(gca,'Fontsize',14);

h=subplot(3,1,1)
set(gca,'layer','top'); ylabel('Depth (m)');
set(h,'position',[0.1300 0.785 0.7750 0.2]);
set(gca,'xticklabel',{[]}) 
g=subplot(3,1,2);
set(g,'position',[0.1300 0.450 0.7750 0.29]);
set(gca,'xticklabel',{[]}) 
f=subplot(3,1,3);
set(f,'position',[0.13 0.11 0.775 0.29])
