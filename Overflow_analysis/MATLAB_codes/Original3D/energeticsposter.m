clear all
close all

load PEtoKE10.mat
load PEtoKE60.mat
load KEtoDISS10.mat
load KEtoDISS60.mat
load XC.mat
load topo.mat
load timechange10.mat; load timechange60.mat
load flux210.mat; load flux260.mat;
figure(1)

%set(gcf,'units','points','position',[50,50,400,500])
set(gcf,'units','points','position',[514,600,560,498])
subplot(3,1,1)
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
xlim([0 75]); ylim([-2500 0]); grid on;
set(gca,'Fontsize',14)

subplot(3,1,2)
plot(XC/1000,smooth(nanmean(PEtoKE10,2),30),'Color',[255 83 73]/255,'Linewidth',1.5); grid on; hold on;
plot(XC/1000,smooth(nanmean(-KEtoDISS10,2),25),'Color',[0 0 0.5],'Linewidth',1.5)
a1=smooth(nanmean(PEtoKE10,2),30)-smooth(nanmean(-KEtoDISS10,2),25);
plot(XC/1000,smooth(a1),':k','Linewidth',1.5);
plot(XC/1000,smooth(nanmean(timechange10,2)+nanmean(flux210,2),25),'Color',[25 190 121]/255,'Linewidth',1.5);
%plot(XC/1000,dKEdt10,'Color',[25 190 121]/255,'Linewidth',1.5);
legend('Conversion of PE to KE','Conversion of KE to DISS','Difference (Creation-Destruction of KE)','Time change plus flux of KE')
ylabel('[m^2/s^3]')
title('10 Days')
xlim([0 75]); grid on
ylim([-2e-7 12e-7]);
set(gca,'Fontsize',14);

subplot(3,1,3)
plot(XC/1000,smooth(nanmean(PEtoKE60,2),30),'Color',[255 83 73]/255,'Linewidth',1.5); grid on; hold on;
plot(XC/1000,smooth(nanmean(-KEtoDISS60,2),25),'Color',[0 0 0.5],'Linewidth',1.5)
a2=smooth(nanmean(PEtoKE60,2),30)-smooth(nanmean(-KEtoDISS60,2),25)
plot(XC/1000,smooth(a2),':k','Linewidth',1.5);
plot(XC/1000,smooth(nanmean(timechange60,2)+nanmean(flux260,2),25),'Color',[25 190 121]/255,'Linewidth',1.5);
%plot(XC/1000,dKEdt10,'Color',[25 190 121]/255,'Linewidth',1.5);
legend('Conversion of PE to KE','Conversion of KE to DISS','Difference (Creation-Destruction of KE)','Time change plus flux of KE')
ylabel('[m^2/s^3]'); xlabel('X Position (km)')

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

