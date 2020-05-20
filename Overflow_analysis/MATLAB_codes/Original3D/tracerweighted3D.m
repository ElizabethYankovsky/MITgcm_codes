clear all
close all
load Sweighted.mat
load Tweighted.mat
load Uweighted.mat
load densweighted.mat
load densityanomaly.mat

Sweighted(Sweighted==0)=NaN;
Tweighted(Tweighted==0)=NaN;
densweighted(densweighted==0)=NaN;
%densanomaly(densityanomaly==0)=NaN;
load XC.mat
time = linspace((60/240),60,240);

figure(1)
pcolor(XC,time,densweighted'); shading flat; 
xlabel('X coordinate (meters)','Fontsize',12);
ylabel('Time (days)','Fontsize',12);
title('Tracer weighted density [kg/m^3]','Fontsize',12)
colormap jet
caxis([1027.6 1028.7]);
colorbar

figure(2)
pcolor(XC,time,Tweighted'); shading flat; 
xlabel('X coordinate (meters)','Fontsize',12);
ylabel('Time (days)','Fontsize',12);
title('Tracer weighted temperature [C]','Fontsize',12)
colormap jet
caxis([-3 .5]);
colorbar

figure(3)
pcolor(XC,time,Sweighted'); shading flat; 
xlabel('X coordinate (meters)','Fontsize',12);
ylabel('Time (days)','Fontsize',12);
title('Tracer weighted salinity [psu]','Fontsize',12);
caxis([34.3 35.5]);
colormap jet
colorbar

figure(4)
pcolor(XC,time,Uweighted'); shading flat; 
xlabel('X coordinate (meters)','Fontsize',12);
ylabel('Time (days)','Fontsize',12);
title('Tracer weighted U-velocity [m/s]','Fontsize',12);
caxis([-0.12 0.17]);
colormap jet
colorbar

figure(5)
plot(time,densityanomaly'); hold on;
plot(time,time*3600*24*3.41e-5/40,'--k'); grid on;
ylim([0 1.0]); legend('Density Anomaly','Value of Qt/H')
set(gca,'Fontsize',12); 
xlabel('Time (days)','Fontsize',12); 
ylabel('Density anomaly [kg/m^3]','Fontsize',12)
title('Density anomaly','Fontsize',12)




