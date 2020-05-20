clear all
close all
load z.mat
load dz.mat
load dx.mat
load XC.mat
z = z-z(1);


dzm = repmat(dz',900,1);
dx = dx;
dy = 111.111;

myD = ncread('grid.nc','Depth');

[hfacC,ddz]=hfac(dz',-myD,0.05,0);

%Defining 3 yz faces through which fluxes are calculated
 area1=dy*sq(ddz(169,:,:));
 area2=dy*sq(ddz(499,:,:));
% area3=dy*sq(ddz(599,:,:));


bins = [1027.6:0.05:1029.2];
S1=sq(nanmean(ncread('Original4.nc','S',[169 1 1 1],[2 Inf Inf 1])));
S2=sq(nanmean(ncread('Original4.nc','S',[499 1 1 1],[2 Inf Inf 1])));
%S3=sq(nanmean(ncread('Original4.nc','S',[599 1 1 1],[2 Inf Inf 1])));
T1=sq(nanmean(ncread('Original4.nc','Temp',[169 1 1 1],[2 Inf Inf 1])));
T2=sq(nanmean(ncread('Original4.nc','Temp',[499 1 1 1],[2 Inf Inf 1])));
%T3=sq(nanmean(ncread('Original4.nc','Temp',[599 1 1 1],[2 Inf Inf 1])));
density01=densmdjwf(S1,T1,zeros(900,120));
density02=densmdjwf(S2,T2,zeros(900,120));
%density03=densmdjwf(S3,T3,zeros(900,120));

for i =121:240 
    %Reading in temperature, salinity velocity at each of the three faces
    if i>=1 && i<=40
        S1=sq(nanmean(ncread('Original1.nc','S',[169 1 1 i],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original1.nc','S',[499 1 1 i],[2 Inf Inf 1])));
        %S3=sq(nanmean(ncread('Original1.nc','S',[599 1 1 i],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original1.nc','Temp',[169 1 1 i],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original1.nc','Temp',[499 1 1 i],[2 Inf Inf 1])));
        %T3=sq(nanmean(ncread('Original1.nc','Temp',[599 1 1 i],[2 Inf Inf 1])));
        U1=sq(ncread('Original1.nc','U',[170 1 1 i],[1 Inf Inf 1]));
        U2=sq(ncread('Original1.nc','U',[500 1 1 i],[1 Inf Inf 1]));
        %U3=sq(ncread('Original1.nc','U',[600 1 1 i],[1 Inf Inf 1]));

    elseif i>=41 && i<=80
        S1=sq(nanmean(ncread('Original2.nc','S',[169 1 1 i-40],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original2.nc','S',[499 1 1 i-40],[2 Inf Inf 1])));
        %S3=sq(nanmean(ncread('Original2.nc','S',[599 1 1 i-40],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original2.nc','Temp',[169 1 1 i-40],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original2.nc','Temp',[499 1 1 i-40],[2 Inf Inf 1])));
        %T3=sq(nanmean(ncread('Original2.nc','Temp',[599 1 1 i-40],[2 Inf Inf 1])));
        U1=sq(ncread('Original2.nc','U',[170 1 1 i-40],[1 Inf Inf 1]));
        U2=sq(ncread('Original2.nc','U',[500 1 1 i-40],[1 Inf Inf 1]));
        %U3=sq(ncread('Original2.nc','U',[600 1 1 i-40],[1 Inf Inf 1]));
        
    elseif i>=81 && i<=120
        S1=sq(nanmean(ncread('Original3.nc','S',[169 1 1 i-80],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original3.nc','S',[499 1 1 i-80],[2 Inf Inf 1])));
        %S3=sq(nanmean(ncread('Original3.nc','S',[599 1 1 i-80],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original3.nc','Temp',[169 1 1 i-80],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original3.nc','Temp',[499 1 1 i-80],[2 Inf Inf 1])));
        %T3=sq(nanmean(ncread('Original3.nc','Temp',[599 1 1 i-80],[2 Inf Inf 1])));
        U1=sq(ncread('Original3.nc','U',[170 1 1 i-80],[1 Inf Inf 1]));
        U2=sq(ncread('Original3.nc','U',[500 1 1 i-80],[1 Inf Inf 1]));
        %U3=sq(ncread('Original3.nc','U',[600 1 1 i-80],[1 Inf Inf 1]));
       
    elseif i>=121 && i<=160
        S1=sq(nanmean(ncread('Original4.nc','S',[169 1 1 i-120],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original4.nc','S',[499 1 1 i-120],[2 Inf Inf 1])));
       % S3=sq(nanmean(ncread('Original4.nc','S',[599 1 1 i-120],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original4.nc','Temp',[169 1 1 i-120],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original4.nc','Temp',[499 1 1 i-120],[2 Inf Inf 1])));
       % T3=sq(nanmean(ncread('Original4.nc','Temp',[599 1 1 i-120],[2 Inf Inf 1])));
        U1=sq(ncread('Original4.nc','U',[170 1 1 i-120],[1 Inf Inf 1]));
        U2=sq(ncread('Original4.nc','U',[500 1 1 i-120],[1 Inf Inf 1]));
       % U3=sq(ncread('Original4.nc','U',[600 1 1 i-120],[1 Inf Inf 1]));
    elseif i>=161 && i<=200
        S1=sq(nanmean(ncread('Original5.nc','S',[169 1 1 i-160],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original5.nc','S',[499 1 1 i-160],[2 Inf Inf 1])));
        %S3=sq(nanmean(ncread('Original5.nc','S',[599 1 1 i-160],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original5.nc','Temp',[169 1 1 i-160],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original5.nc','Temp',[499 1 1 i-160],[2 Inf Inf 1])));
        %T3=sq(nanmean(ncread('Original5.nc','Temp',[599 1 1 i-160],[2 Inf Inf 1])));
        U1=sq(ncread('Original5.nc','U',[170 1 1 i-160],[1 Inf Inf 1]));
        U2=sq(ncread('Original5.nc','U',[500 1 1 i-160],[1 Inf Inf 1]));
        %U3=sq(ncread('Original5.nc','U',[600 1 1 i-160],[1 Inf Inf 1]));
       
    elseif i>=201 && i<=240
        S1=sq(nanmean(ncread('Original6.nc','S',[169 1 1 i-200],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original6.nc','S',[499 1 1 i-200],[2 Inf Inf 1])));
        %S3=sq(nanmean(ncread('Original6.nc','S',[599 1 1 i-200],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original6.nc','Temp',[169 1 1 i-200],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original6.nc','Temp',[499 1 1 i-200],[2 Inf Inf 1])));
        %T3=sq(nanmean(ncread('Original6.nc','Temp',[599 1 1 i-200],[2 Inf Inf 1])));
        U1=sq(ncread('Original6.nc','U',[170 1 1 i-200],[1 Inf Inf 1]));
        U2=sq(ncread('Original6.nc','U',[500 1 1 i-200],[1 Inf Inf 1]));
        %U3=sq(ncread('Original6.nc','U',[600 1 1 i-200],[1 Inf Inf 1]));
       
    end
    %Calculating densities at each of the three faces
    density1= densmdjwf(S1,T1,zeros(900,120))-density01;
    density2= densmdjwf(S2,T2,zeros(900,120))-density02;
    %density3= densmdjwf(S3,T3,zeros(900,120))-density03;
    density1t= densmdjwf(S1,T1,zeros(900,120));
    density2t= densmdjwf(S2,T2,zeros(900,120));
    %density3t= densmdjwf(S3,T3,zeros(900,120));    
   
    %Calculating mass flux into each region [kg] at each time step
    %at the end of the code, sum(mass1) to get total for all time
    mass1(i-120) =nansum(nansum(-density1.*U1.*area1))*21600;
    mass2(i-120) =(nansum(nansum(density1.*U1.*area1))-nansum(nansum(density2.*U2.*area2)))*21600;
    %mass3(i) =(nansum(nansum(density2.*U2.*area2))-nansum(nansum(density3.*U3.*area3)))*21600;
    
    %Creating histogram
    flux1 = area1.*U1;
    flux2 = area2.*U2;
    %flux3 = area3.*U3;
    for k = 1:length(bins)-1;
        Ffinal1(i-120,k) = nansum(flux1(density1t>=bins(k) & density1t<bins(k+1)))*21600/10^9;%*dt and convert to km^3   
        Ffinal2(i-120,k) = nansum(flux2(density2t>=bins(k) & density2t<bins(k+1)))*21600/10^9; 
        %Ffinal3(i,k) = nansum(flux3(density3t>=bins(k) & density3t<bins(k+1)))*21600/10^9;
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
grid on; xlim([-50 50]);
set(gca,'YDir','reverse')

subplot(2,1,2)
barh(plotbins,nansum(Ffinal2(1:120,:),1),'hist');
set(gca,'YTick',bins(1:4:end),'Fontsize',8);
ylim([bins(1) bins(end)])
ylabel('Density (kg/m^3)','Fontsize',8);
xlabel('Integrated in time flux, (km^3)','Fontsize',8); grid on;
title('Region 2-edge','Fontsize',8);
set(gca,'YDir','reverse')
xlim([-20 20]);

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
