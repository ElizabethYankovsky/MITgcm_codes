clear all
close all
load z.mat
load dz.mat
load dx.mat
load XC.mat
z = z-z(1);


dzm = repmat(dz',1);
dx = dx;
dy = 111.111;

myD = ncread('grid.nc','Depth');

[hfacC,ddz]=hfac(dz',-myD,0.05,0);

%Defining 3 yz faces through which fluxes are calculated
 area1=dy*sq(ddz(339,:))';
 area2=dy*sq(ddz(999,:))';


bins = [1027.6:0.05:1029.2];
S1=sq(nanmean(ncread('Eighth5.nc','S',[339 1 1 40],[2 Inf Inf 1])));
S2=sq(nanmean(ncread('Eighth5.nc','S',[999 1 1 40],[2 Inf Inf 1])));

T1=sq(nanmean(ncread('Eighth5.nc','Temp',[339 1 1 40],[2 Inf Inf 1])));
T2=sq(nanmean(ncread('Eighth5.nc','Temp',[999 1 1 40],[2 Inf Inf 1])));

density01=densmdjwf(S1,T1,zeros(240,1));
density02=densmdjwf(S2,T2,zeros(240,1));


for i =361:480 
  %Reading in temperature, salinity velocity at each of the three faces
    if i>=1 && i<=80
        S1=sq(nanmean(ncread('Eighth1.nc','S',[339 1 1 i],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Eighth1.nc','S',[999 1 1 i],[2 Inf Inf 1])));

        T1=sq(nanmean(ncread('Eighth1.nc','Temp',[339 1 1 i],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Eighth1.nc','Temp',[999 1 1 i],[2 Inf Inf 1])));

        U1=sq(ncread('Eighth1.nc','U',[340 1 1 i],[1 Inf Inf 1]));
        U2=sq(ncread('Eighth1.nc','U',[1000 1 1 i],[1 Inf Inf 1]));


    elseif i>=81 && i<=160
        S1=sq(nanmean(ncread('Eighth2.nc','S',[339 1 1 i-80],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Eighth2.nc','S',[999 1 1 i-80],[2 Inf Inf 1])));
    
        T1=sq(nanmean(ncread('Eighth2.nc','Temp',[339 1 1 i-80],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Eighth2.nc','Temp',[999 1 1 i-80],[2 Inf Inf 1])));
        
        U1=sq(ncread('Eighth2.nc','U',[340 1 1 i-80],[1 Inf Inf 1]));
        U2=sq(ncread('Eighth2.nc','U',[1000 1 1 i-80],[1 Inf Inf 1]));
        
    elseif i>=161 && i<=240
        S1=sq(nanmean(ncread('Eighth3.nc','S',[339 1 1 i-160],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Eighth3.nc','S',[999 1 1 i-160],[2 Inf Inf 1])));
        
        T1=sq(nanmean(ncread('Eighth3.nc','Temp',[339 1 1 i-160],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Eighth3.nc','Temp',[999 1 1 i-160],[2 Inf Inf 1])));

        U1=sq(ncread('Eighth3.nc','U',[340 1 1 i-160],[1 Inf Inf 1]));
        U2=sq(ncread('Eighth3.nc','U',[1000 1 1 i-160],[1 Inf Inf 1]));
        
    elseif i>=241 && i<=320
        S1=sq(nanmean(ncread('Eighth4.nc','S',[339 1 1 i-240],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Eighth4.nc','S',[999 1 1 i-240],[2 Inf Inf 1])));
        
        T1=sq(nanmean(ncread('Eighth4.nc','Temp',[339 1 1 i-240],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Eighth4.nc','Temp',[999 1 1 i-240],[2 Inf Inf 1])));

        U1=sq(ncread('Eighth4.nc','U',[340 1 1 i-240],[1 Inf Inf 1]));
        U2=sq(ncread('Eighth4.nc','U',[1000 1 1 i-240],[1 Inf Inf 1]));
        
    elseif i>=321 && i<=400
        S1=sq(nanmean(ncread('Eighth5.nc','S',[339 1 1 i-320],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Eighth5.nc','S',[999 1 1 i-320],[2 Inf Inf 1])));
        
        T1=sq(nanmean(ncread('Eighth5.nc','Temp',[339 1 1 i-320],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Eighth5.nc','Temp',[999 1 1 i-320],[2 Inf Inf 1])));

        U1=sq(ncread('Eighth5.nc','U',[340 1 1 i-320],[1 Inf Inf 1]));
        U2=sq(ncread('Eighth5.nc','U',[1000 1 1 i-320],[1 Inf Inf 1]));
        
    elseif i>=401 && i<=480
        S1=sq(nanmean(ncread('Eighth6.nc','S',[339 1 1 i-400],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Eighth6.nc','S',[999 1 1 i-400],[2 Inf Inf 1])));
        
        T1=sq(nanmean(ncread('Eighth6.nc','Temp',[339 1 1 i-400],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Eighth6.nc','Temp',[999 1 1 i-400],[2 Inf Inf 1])));

        U1=sq(ncread('Eighth6.nc','U',[340 1 1 i-400],[1 Inf Inf 1]));
        U2=sq(ncread('Eighth6.nc','U',[1000 1 1 i-400],[1 Inf Inf 1]));
       
    end
  
    %Calculating densities at each of the three faces
    density1= densmdjwf(S1,T1,zeros(240,1))-density01;
    density2= densmdjwf(S2,T2,zeros(240,1))-density02;

    density1t= densmdjwf(S1,T1,zeros(240,1));
    density2t= densmdjwf(S2,T2,zeros(240,1));
    
   
    %Calculating mass flux into each region [kg] at each time step
    %at the end of the code, sum(mass1) to get total for all time
    mass1(i-360) =nansum(nansum(-density1.*U1.*area1))*21600;
    mass2(i-360) =(nansum(nansum(density1.*U1.*area1))-nansum(nansum(density2.*U2.*area2)))*21600;
   
    
    %Creating histogram
    flux1 = area1.*U1;
    flux2 = area2.*U2;

    for k = 1:length(bins)-1;
        Ffinal1(i-360,k) = nansum(flux1(density1t>=bins(k) & density1t<bins(k+1)))*21600/10^9;%*dt and convert to km^3   
        Ffinal2(i-360,k) = nansum(flux2(density2t>=bins(k) & density2t<bins(k+1)))*21600/10^9; 
    end
   
    i

end

%Total mass into region 1:
totalmass1 = nansum(mass1);
totalmass2 = nansum(mass2);
%totalmass3 = nansum(mass3);

plotbins = bins(1:length(bins)-1)+(bins(2)-bins(1))/2;

figure(1)
subplot(2,1,1)
barh(plotbins,nansum(Ffinal1(1:120,:),1),'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',8);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Integrated in time flux, km^3','Fontsize',8);
title('Region 1-2','Fontsize',8);
grid on; 
%xlim([-50 50]);
set(gca,'YDir','reverse')

subplot(2,1,2)
barh(plotbins,nansum(Ffinal2(1:120,:),1),'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',8);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Integrated in time flux, (km^3)','Fontsize',8); grid on;
title('Region 2-edge','Fontsize',8);
set(gca,'YDir','reverse')
%xlim([-20 20]);

%subplot(3,1,3)
% barh(plotbins,nansum(Ffinal3(1:120,:),1),'hist');
% set(gca,'YTick',bins(1:4:end),'Fontsize',8);
% ylim([bins(1) bins(end)])
% ylabel('Density (kg/m^3)','Fontsize',8);
% xlabel('Integrated in time flux, (km^3)','Fontsize',8); grid on;
% title('Region 3-edge','Fontsize',8);
% set(gca,'YDir','reverse')
% xlim([-1 1]);
% 
% % 
% % 
% % 
% 
