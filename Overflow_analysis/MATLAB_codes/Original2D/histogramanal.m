clear all
close all
load z.mat
load dz.mat
load dx.mat
load XC.mat
z = z-z(1);


dz = dz;
dx = dx;
dy = 111.111;

%Initial:
Si=sq(ncread('HR4.nc','S',[1 1 1 1],[Inf Inf Inf 1]));
Ti=sq(ncread('HR4.nc','Temp',[1 1 1 1],[Inf Inf Inf 1]));

densityi = densmdjwf(Si,Ti,zeros(1280,240));
%Last time step:
Sf=sq(ncread('HR6.nc','S',[1 1 1 40],[Inf Inf Inf 1]));
Tf=sq(ncread('HR6.nc','Temp',[1 1 1 40],[Inf Inf Inf 1]));
densityf = densmdjwf(Sf,Tf,zeros(1280,240));


myD = ncread('grid.nc','Depth');
[hfacC,ddz]=hfac(dz',-myD,0.05,0);
volume=zeros(1280,240); %FIND V of each grid cell
for i =1:1280
    for j = 1:240
        volume(i,j) = dy*dx(i)*ddz(i,j);
    end
end
volume1=volume(1:340,:); volume2=volume(341:1000,:); 
density1i=densityi(1:340,:); density2i=densityi(341:1000,:); 
density1f=densityf(1:340,:); density2f=densityf(341:1000,:); 
volume1total=sum(sum(volume1))/10^9; volume2total=sum(sum(volume2))/10^9;
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
%xlim([-120 120]);

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
%xlim([-120 120]); 
set(gca,'YDir','reverse')


subplot(2,1,2)
barh(plotbins,(Vfinal2)/volume2total*100,'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',6);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Percentage of Region 2 volume','Fontsize',8);
title('Region 2, Final','Fontsize',8); grid on;
set(gca,'YDir','reverse')
%xlim([-15 15]);

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
xlim([-120 120]);

subplot(2,1,2)
barh(plotbins,(Vfinal2-Vinitial2)/volume2total*100,'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',6);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Percentage of Region 2 volume','Fontsize',8); grid on;
xlim([-15 15])
title('Region 2, Final-Initial','Fontsize',8);
set(gca,'YDir','reverse')









































