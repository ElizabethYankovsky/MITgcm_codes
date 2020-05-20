clear all
close all
%
%
%Create timechange matrix from using code: histogramanal
%Create fluxes (Ffinal matrices) from using code histogramfluxes
load dx.mat
dy=111.11;
%load Ffinal3.mat
%Ffinal3=nansum(Ffinal3(1:120,:),1);
load Ffinal2.mat
Ffinal2=nansum(Ffinal2(1:120,:),1);
load Ffinal1.mat
Ffinal1=nansum(Ffinal1(1:120,:),1);


load timechange1.mat
load timechange2.mat
%load timechange3.mat
volume1=92.4; %in km^3
volume2=5256.7;
%volume2=1081;
%volume3=7422;

cd Originalinput
fid1= fopen('Qnet.forcing','r','b');
Q=fread(fid1,'real*8');
Q= reshape(Q,[640 900]);
Q = squeeze(Q(:,1));

fid2= fopen('SF.forcing','r','b');
SF=fread(fid2,'real*8');
SF = reshape(SF,[640 900]);
SF = squeeze(SF(:,1));
cd ..

forcing = -SF*(7.7*10^-4)+Q*(3.2*10^-5)/(3974); %kg/(m^2*s)
forcingarea=dx*dy*900; %m^2 INTEGRATED OVER Y, NOT OVER X
time = 30*24*3600;%s
totalfx=forcing.*forcingarea*time; %kg

source1=sum(totalfx(1:170)); %kg
source2=sum(totalfx(171:500)); %kg
%source3=sum(totalfx(341:600)); %kg


bins = [1027.6:0.05:1029.2];
plotbins = bins(1:length(bins)-1)+(bins(2)-bins(1))/2;
%Contain corresponding respective values for Hydrostatic simulation for all plots in
%order (a is timechange1 b is -Ffinal1 etc.)
% load a.mat 
% load b.mat 
% load c.mat
% load d.mat
% load e.mat 
% load f.mat 
% load g.mat 
% load h.mat 
% load k.mat
figure(1)
subplot(3,1,1)
barh(plotbins,timechange1/volume1*100,'hist');
set(gca,'YTick',bins(1:4:end));
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)');
xlabel('Percentage of Region 1 Volume');
title('Time change region 1');
grid on; set(gca,'YDir','reverse')
xlim([-150 150])

subplot(3,1,2)
barh(plotbins,(-Ffinal1)/volume1*100,'hist');
set(gca,'YTick',bins(1:4:end));
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)');
xlabel('Percentage of Region 1 Volume');
title('Advection (positive into region 1)');
grid on; set(gca,'YDir','reverse')
xlim([-150 150])

subplot(3,1,3)
barh(plotbins,(timechange1-(-Ffinal1))/volume1*100,'hist');
set(gca,'YTick',bins(1:4:end));
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)');
xlabel('Percentage of Region 1 Volume');
title('Time change-advection (positive {->} creation)');
grid on; set(gca,'YDir','reverse');
xlim([-150 150]);

set(gcf,'units','points','position',[50,50,400,500])

figure(2)
subplot(3,1,1)
barh(plotbins,timechange2/volume2*100,'hist');
set(gca,'YTick',bins(1:4:end));
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)');
%xlabel('Percentage of region volume');
title('Time change within region');
grid on; set(gca,'YDir','reverse');
xlim([-17 17])

subplot(3,1,2)
barh(plotbins,(Ffinal1-Ffinal2)/volume2*100,'hist');
set(gca,'YTick',bins(1:4:end));
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)');
%xlabel('Percentage of region volume');
title('Advection into region');
grid on; set(gca,'YDir','reverse');
xlim([-17 17])

subplot(3,1,3)
barh(plotbins,(timechange2-(Ffinal1-Ffinal2))/volume2*100,'hist');
set(gca,'YTick',bins(1:4:end));
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)');
xlabel('Percentage of region volume');
title('Time change - advection ');
grid on; set(gca,'Ydir','reverse');
xlim([-17 17]);

set(gcf,'units','points','position',[50,50,400,500])


% figure(3)
% subplot(3,1,1)
% barh(plotbins,timechange3,'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('{Volume (km^3)}','Fontsize',8);
% title('Time change region 3','Fontsize',8);
% grid on; set(gca,'Ydir','reverse');
% xlim([-800 800]);
% 
% subplot(3,1,2)
% barh(plotbins,(Ffinal2-Ffinal3),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('{Volume (km^3)}','Fontsize',8);
% title('Advection (positive into region 3)','Fontsize',8);
% grid on; set(gca,'Ydir','reverse');
% xlim([-800 800]);
% 
% subplot(3,1,3)
% barh(plotbins,k-(timechange3-(Ffinal2-Ffinal3)),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('{Volume (km^3)}','Fontsize',8);
% title('Time change-advection','Fontsize',8);
% grid on; set(gca,'Ydir','reverse');
% xlim([-800 800]);





