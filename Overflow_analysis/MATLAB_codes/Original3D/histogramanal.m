clear all
close all
load z.mat
load dz.mat
load dx.mat
load XC.mat
z = z-z(1);
% ZC=z-z(1);
% YC=111.111:111.111:99999.9;
% XC=ncread('Original1.nc','X');

dz = dz;
dx = dx;
dy = 111.111;

%Initial:
Si=sq(ncread('Original4.nc','S',[1 1 1 1],[Inf Inf Inf 1]));
Ti=sq(ncread('Original4.nc','Temp',[1 1 1 1],[Inf Inf Inf 1]));

densityi = densmdjwf(Si,Ti,zeros(640,900,120));
%Last time step:
Sf=sq(ncread('Original6.nc','S',[1 1 1 40],[Inf Inf Inf 1]));
Tf=sq(ncread('Original6.nc','Temp',[1 1 1 40],[Inf Inf Inf 1]));
densityf = densmdjwf(Sf,Tf,zeros(640,900,120));


myD = ncread('grid.nc','Depth');
[hfacC,ddz]=hfac(dz',-myD,0.05,0);
volume=zeros(640,900,120); %FIND V of each grid cell
for i =1:640
    for j = 1:120
        volume(i,:,j) = dy*dx(i)*ddz(i,:,j);
    end
end
%previously volume1 was same, volume 2 was 171-340.
volume1=volume(1:170,:,:); volume2=volume(171:500,:,:); %volume3=volume(341:600,:,:);
density1i=densityi(1:170,:,:); density2i=densityi(171:500,:,:); %density3i=densityi(341:600,:,:);
density1f=densityf(1:170,:,:); density2f=densityf(171:500,:,:); %density3f=densityf(341:600,:,:);

volume1total=sum(sum(sum(volume1)))/10^9; volume2total=sum(sum(sum(volume2)))/10^9;
%Density bins
bins = [1027.6:0.05:1029.2];%1028.6 1028.8 1029 1029.2 1029.4];

for i = 1:length(bins)-1;
    Vinitial1(i) = nansum(volume1(density1i>=bins(i) & density1i<bins(i+1)))/10^9;%volumetot*100;   
    Vfinal1(i)   = nansum(volume1(density1f>=bins(i) & density1f<bins(i+1)))/10^9;%volumetot*100;

    Vinitial2(i) = nansum(volume2(density2i>=bins(i) & density2i<bins(i+1)))/10^9;%volumetot*100;   
    Vfinal2(i)   = nansum(volume2(density2f>=bins(i) & density2f<bins(i+1)))/10^9;%volumetot*100;

    %Vinitial3(i) = nansum(volume3(density3i>=bins(i) & density3i<bins(i+1)))/10^9;%volumetot*100;   
    %Vfinal3(i)   = nansum(volume3(density3f>=bins(i) & density3f<bins(i+1)))/10^9;%volumetot*100;
end
timechange1=Vfinal1-Vinitial1; %units km^3
timechange2=Vfinal2-Vinitial2; %units km^3
%timechange3=Vfinal3-Vinitial3;
save timechange1.mat timechange1
save timechange2.mat timechange2
%save timechange3.mat timechange3

plotbins = bins(1:length(bins)-1)+(bins(2)-bins(1))/2;
figure(1)
subplot(2,1,1)
barh(plotbins,(Vinitial1)/volume1total*100,'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',6);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Percentage of Region 1 volume','Fontsize',8);
title('Region 1, Initial','Fontsize',8);
grid on; set(gca,'YDir','reverse');
%xlim([0 65]);

subplot(2,1,2)
barh(plotbins,(Vinitial2)/volume2total*100,'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',6);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Percentage of Region 2 volume','Fontsize',8); grid on;
title('Region 2, Initial','Fontsize',8);
set(gca,'YDir','reverse')
%xlim([0 360]);

% subplot(3,1,3)
% barh(plotbins,(Vinitial3),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('{Volume (km^3)}','Fontsize',8); grid on;
% title('Region 3, Initial','Fontsize',8);
% xlim([0 6000]); set(gca,'YDir','reverse')


figure(2)
subplot(2,1,1)
barh(plotbins,(Vfinal1)/volume1total*100,'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',6);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Percentage of Region 1 volume','Fontsize',8); grid on;
title('Region 1, Final','Fontsize',8);
%xlim([0 65]); set(gca,'YDir','reverse')


subplot(2,1,2)
barh(plotbins,(Vfinal2)/volume2total*100,'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',6);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Percentage of Region 2 volume','Fontsize',8);
title('Region 2, Final','Fontsize',8); grid on;
%xlim([0 360]); set(gca,'YDir','reverse')


% subplot(3,1,3)
% barh(plotbins,(Vfinal3),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('{Volume (km^3)}','Fontsize',8); grid on;
% title('Region 3, Final','Fontsize',8);
% xlim([0 6000]); set(gca,'YDir','reverse')

figure(3)
subplot(2,1,1)
barh(plotbins,(Vfinal1-Vinitial1)/volume1total*100,'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',6);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Percentage of Region 1 volume','Fontsize',8);
title('Region 1, Final-Initial','Fontsize',8); 
grid on; set(gca,'YDir','reverse')
%xlim([-70 10]);

subplot(2,1,2)
barh(plotbins,(Vfinal2-Vinitial2)/volume2total*100,'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',6);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Percentage of Region 2 volume','Fontsize',8); grid on;
%xlim([-120 250])
title('Region 2, Final-Initial','Fontsize',8);
set(gca,'YDir','reverse')

% subplot(3,1,3)
% barh(plotbins,(Vfinal3-Vinitial3),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('Volume (km^3)','Fontsize',8); grid on;
% xlim([-1200 800])
% title('Region 3, Final-Initial','Fontsize',8);
% set(gca,'YDir','reverse')

% NHdeltaV1=Vfinal1-Vinitial1;
% NHdeltaV2=Vfinal2-Vinitial2;
%NHdeltaV3=Vfinal3-Vinitial3;
%figure(4)
%load HdeltaV1.mat
%load HdeltaV2.mat
%load HdeltaV3.mat

% subplot(2,1,1)
% barh(plotbins,(HdeltaV1-NHdeltaV1),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('Volume (km^3)','Fontsize',8);
% title('Region 1, Final-Initial difference (HS-NHS)','Fontsize',8); 
% grid on; set(gca,'YDir','reverse')
% xlim([-5 5]);
% 
% subplot(2,1,2)
% barh(plotbins,(HdeltaV2-NHdeltaV2),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('Volume (km^3)','Fontsize',8); grid on;
% xlim([-50 50])
% title('Region 2, Final-Initial difference (HS-NHS)','Fontsize',8);
% set(gca,'YDir','reverse')

% subplot(3,1,3)
% barh(plotbins,(HdeltaV3-NHdeltaV3),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',6);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('Volume (km^3)','Fontsize',8); grid on;
% xlim([-50 50])
% title('Region 3, Final-Initial difference (HS-NHS)','Fontsize',8);
% set(gca,'YDir','reverse')










































