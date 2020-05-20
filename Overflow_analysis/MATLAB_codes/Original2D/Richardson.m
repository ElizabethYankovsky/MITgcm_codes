clear all
close all
%
%
%
load z.mat; %z=z-z(1);
YC = 111.111:111.111:99999.9;
XC=ncread('HR1.nc','X');
load topo.mat

for i = 75
    if i>=1 && i<=40
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
        T=sq(nanmean(ncread('HR1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[1280 Inf Inf 1]),2));
    elseif i>=41 && i<=80
        S=sq(ncread('HR2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
        T=sq(nanmean(ncread('HR2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1])); 
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[1280 Inf Inf 1]),2)); 
    elseif i>=81 && i<=120
        S=sq(ncread('HR3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        T=sq(nanmean(ncread('HR3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1])); 
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[1280 Inf Inf 1]),2));
    elseif i>=121 && i<=160
        S=sq(ncread('HR4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
        T=sq(nanmean(ncread('HR4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[1280 Inf Inf 1]),2));
    elseif i>=161 && i<=201
        S=sq(ncread('HR5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
        T=sq(nanmean(ncread('HR5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));    
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[1280 Inf Inf 1]),2));
    elseif i>=201 && i<=240
        S=sq(ncread('HR6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
        T=sq(nanmean(ncread('HR6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));    
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[1280 Inf Inf 1]),2)); 
    end
   %density = densmdjwf(S,T,zeros(1280,240));
end

for x = 1:1280;
    for y=1:239;
        p = -((z(y)+z(y+1))/2)*9.81*1028/10000; %pressure in dbar
        rho1=densmdjwf(S(x,y),T(x,y),p);
        rho2=densmdjwf(S(x,y+1),T(x,y+1),p);

        delz=z(y+1)-z(y); %negative
        N2(x,y)=-9.81/1028 * (rho2-rho1)/delz; %mostly positive
    end
end





%g=9.81;
%rho_o=1028;
dz=diff(z);
dz=repmat(dz,1,1280)';
%delrho=diff(density,1,2);
%drho_dz=delrho./dz;
%N2=(-g/rho_o)*drho_dz;

delU = diff(U,1,2);
dU_dz =abs(delU./dz);
Ri = N2./(dU_dz.^2);


figure(1);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:240),N2'); shading flat;
caxis([-1e-6 10e-6]); colormap(bluewhitered); colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('N^2 value')
ylabel('Depth (m)'); xlabel('X Position (m)');
box on; set(gca,'Layer','top');

figure(2);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:240),dU_dz'); shading flat;
caxis([0 .005]); colormap bluewhitered; colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('Magnitude of dU/dz');
ylabel('Depth (m)'); xlabel('X Position (m)');
box on; set(gca,'Layer','top');

load redblue.mat
figure(3);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:240),Ri'); shading flat;
caxis([-1 1]); colormap(redblue); colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('Richardson number');
ylabel('Depth (m)'); xlabel('X Position (m)');
box on; set(gca,'Layer','top');






















