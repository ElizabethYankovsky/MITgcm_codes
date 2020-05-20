clear all
close all

load XC.mat; XC=XC/1000;
load topo.mat

load a3_60.mat; load b3_60.mat; load c3_60.mat; load d3_60.mat; load e3_60.mat;
load a3_10.mat; load b3_10.mat; load c3_10.mat; load d3_10.mat; load e3_10.mat;

load a2_60.mat; load b2_60.mat; load c2_60.mat; load d2_60.mat; load e2_60.mat;
load a2_10.mat; load b2_10.mat; load c2_10.mat; load d2_10.mat; load e2_10.mat;

figure(1)
set(gcf,'units','points','position', [82.2857  139.5918  561.3061  667.1020])
subplot(3,1,1)
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
xlim([0 75]); ylim([-2500 0]); grid on;
set(gca,'Fontsize',14)

subplot(3,1,2)
plot(XC,c3_10,'Color',[230 0 5]/255,'Linewidth',2);
grid on; hold on; 
plot(XC,a3_10,'Color',[150 0 150]/255,'Linewidth',2);
plot(XC,b3_10,'Color',[0 0 190]/255,'Linewidth',2); 
plot(XC,d3_10,'Color',[240 140 15]/255,'Linewidth',2) 
plot(XC,e3_10,'Color',[15 170 100]/255,'Linewidth',2) 
residual = smooth(a3_10+b3_10-c3_10+d3_10+e3_10,30);
plot(XC(10:640),residual(10:640),':k','Linewidth',3);
%legend('Time change','Conversion of PE to KE','Conversion of KE to DISS','Advection flux','Pressure flux','Residual')
ylabel('[m^2/s^3]')
title('10 Days')
xlim([0 75]); grid on
ylim([-1.5e-6 1.5e-6]);
set(gca,'Fontsize',14);

subplot(3,1,3)
plot(XC,c3_60,'Color',[230 0 5]/255,'Linewidth',2); %c
grid on; hold on; 
plot(XC,a3_60,'Color',[150 0 150]/255,'Linewidth',2);
plot(XC,b3_60,'Color',[0 0 190]/255,'Linewidth',2); %b
plot(XC,d3_60,'Color',[240 140 15]/255,'Linewidth',2) %d
plot(XC,e3_60,'Color',[15 170 100]/255,'Linewidth',2) %e
residual = movmean(a3_60+b3_60-c3_60+d3_60+e3_60,50);
plot(XC(10:640),residual(10:640),':k','Linewidth',3);
%legend('Time change','Conversion of PE to KE','Conversion of KE to DISS','Advection flux','Pressure flux','Residual')
title('Original forcing')
xlim([0 75])
ylabel('[m^2/s^3]'); xlabel('X Position (km)')
title('60 Days')
ylim([-1.5e-6 1.5e-6]);
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


%%%% THE 2D RESULTS %%%%%%%%%%%%%%%%

load XC2D.mat; load topo2D.mat;
figure(2)
set(gcf,'units','points','position', [82.2857  139.5918  561.3061  667.1020])
subplot(3,1,1)
area(XC2D,-topo2D,-2500,'Facecolor',[.8 .8 .8])
xlim([0 75]); ylim([-2500 0]); grid on;
set(gca,'Fontsize',14)

subplot(3,1,2)
plot(XC2D,(e2_10),'Color',[230 0 5]/255,'Linewidth',2); grid on; hold on;
plot(XC2D,a2_10,'Color',[150 0 150]/255,'Linewidth',2); 
plot(XC2D,b2_10,'Color',[0 0 190]/255,'Linewidth',2);
plot(XC2D,c2_10,'Color',[240 140 15]/255,'Linewidth',2);
plot(XC2D,d2_10,'Color',[15 170 100]/255,'Linewidth',2);
plot(XC2D,smooth(a2_10+b2_10+c2_10+d2_10-e2_10),':k','Linewidth',3);
%legend('Time change','Conversion of PE to KE','Conversion of KE to DISS','Advection flux','Pressure flux','Residual')
ylabel('[m^2/s^3]')
title('10 Days')
xlim([0 75]); 
ylim([-1.5e-6 1.5e-6]);
set(gca,'Fontsize',14);

subplot(3,1,3)
plot(XC2D,(e2_60),'Color',[230 0 5]/255,'Linewidth',2); grid on; hold on;
plot(XC2D,a2_60,'Color',[150 0 150]/255,'Linewidth',2); 
plot(XC2D,b2_60,'Color',[0 0 190]/255,'Linewidth',2);
plot(XC2D,c2_60,'Color',[240 140 15]/255,'Linewidth',2);
plot(XC2D,d2_60,'Color',[15 170 100]/255,'Linewidth',2);
residual=smooth(a2_60+b2_60+c2_60+d2_60-e2_60,30);
plot(XC2D(20:1280),residual(20:1280),':k','Linewidth',3);
%legend('Time change','Conversion of PE to KE','Conversion of KE to DISS','Advection flux','Pressure flux','Residual')
title('Original forcing')
xlim([0 75])
ylabel('[m^2/s^3]'); xlabel('X Position (km)')
title('60 Days')
ylim([-1.5e-6 1.5e-6]);
set(gca,'Fontsize',14);

h=subplot(3,1,1)
set(gca,'layer','top'); ylabel('Depth (m)');
set(h,'position',[0.1300 0.785 0.7750 0.2]);
set(gca,'xticklabel',{[]}) 
g=subplot(3,1,2);
set(g,'position',[0.1300 0.450 0.7750 0.29]);
%legend('Time change','Conversion of PE to KE','Conversion of KE to DISS','Advection flux','Pressure flux','Residual')
set(gca,'xticklabel',{[]}) 
f=subplot(3,1,3);
set(f,'position',[0.13 0.11 0.775 0.29])
























