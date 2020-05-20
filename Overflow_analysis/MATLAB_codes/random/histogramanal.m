clear all
close all
load z.mat
load dz.mat
load dx.mat

% ZC=z-z(1);
% YC=111.111:111.111:99999.9;
% XC=ncread('Original1.nc','X');

dz = dz;
dx = dx;
dy = 111.111;

%Initial:
Si=sq(ncread('Original1.nc','S',[1 1 1 1],[Inf Inf Inf 1]));
Ti=sq(ncread('Original1.nc','Temp',[1 1 1 1],[Inf Inf Inf 1]));
densityi = densmdjwf(Si,Ti,zeros(640,900,120));
%Last time step:
Sf=sq(ncread('Original6.nc','S',[1 1 1 40],[Inf Inf Inf 1]));
Tf=sq(ncread('Original6.nc','Temp',[1 1 1 40],[Inf Inf Inf 1]));
densityf = densmdjwf(Sf,Tf,zeros(640,900,120));

volume=zeros(640,900,120); %same for all y slices, so only in xz plane
for i =1:640
    for j = 1:120
        volume(i,:,j) = dy*dx(i)*dz(j);
    end
end
volumetot=sum(sum(sum(volume)));
%Density bins
bins = [1027.6:0.05:1029];%1028.6 1028.8 1029 1029.2 1029.4];

for i = 1:length(bins)-1;
    Vinitial(i) = sum(volume(densityi>=bins(i) & densityi<bins(i+1)))/10^9;%volumetot*100;   
    Vfinal(i)   = sum(volume(densityf>=bins(i) & densityf<bins(i+1)))/10^9;%volumetot*100;
end


plotbins = bins(1:length(bins)-1)+(bins(2)-bins(1))/2;
figure(1)
bar(plotbins,Vinitial,'hist');
set(gca,'XTick',bins(1:4:end),'Fontsize',8);
xlim([bins(1) bins(end)])
xlabel('Density (kg/m^3)','Fontsize',12);
ylabel('Volume (km^3)','Fontsize',12);
title('Initial distribution','Fontsize',12);
grid on;

figure(2)
bar(plotbins,Vfinal,'hist');
set(gca,'XTick',bins(1:4:end),'Fontsize',8);
xlim([bins(1) bins(end)])
xlabel('Density (kg/m^3)','Fontsize',12);
ylabel('Volume (km^3)','Fontsize',12);
title('Final (day 60) distribution','Fontsize',12);
grid on;
ylim([0 7000])

figure(3)
bar(plotbins,Vfinal-Vinitial,'hist');
set(gca,'XTick',bins(1:4:end),'Fontsize',8);
xlim([bins(1) bins(end)])
xlabel('Density (kg/m^3)','Fontsize',12);
ylabel('Volume (km^3)','Fontsize',12);
title('Final-Initial distribution','Fontsize',12);
grid on








