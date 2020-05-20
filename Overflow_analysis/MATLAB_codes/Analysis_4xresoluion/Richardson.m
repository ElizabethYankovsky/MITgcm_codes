clear all
close all
%
%
%
load z.mat; %z=z-z(1);
load XC.mat
load topo.mat

for i = 321
    if i>=1 && i<=80
        W=sq(ncread('state1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('state1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('state1.nc','U',[1 1 1 i],[2560 Inf Inf 1]));
        Tracer=sq(ncread('tracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
        S=sq(ncread('state1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
        T=sq(ncread('state1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=81 && i<=160 
        W=sq(ncread('state2.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('state2.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('state2.nc','U',[1 1 1 i-80],[2560 Inf Inf 1]));
        Tracer=sq(ncread('tracer2.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));      
        S = sq(ncread('state2.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        T = sq(ncread('state2.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=161 && i<=240
        W=sq(ncread('state3.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('state3.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('state3.nc','U',[1 1 1 i-160],[2560 Inf Inf 1]));
        Tracer=sq(ncread('tracer3.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));  
        S = sq(ncread('state3.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
        T = sq(ncread('state3.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=241
        W=sq(ncread('stateHR.nc','W',[1 1 1 i-240],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('stateHR.nc','V',[1 1 1 i-240],[Inf Inf Inf 1]),2));
        U=sq(ncread('stateHR.nc','U',[1 1 1 i-240],[2560 Inf Inf 1]));
        Tracer=sq(ncread('tracerHR.nc','tracer',[1 1 1 i-240],[Inf Inf Inf 1]));  
        S = sq(ncread('stateHR.nc','S',[1 1 1 i-240],[Inf Inf Inf 1]));
        T = sq(ncread('stateHR.nc','Temp',[1 1 1 i-240],[Inf Inf Inf 1]));
    end
   %density = densmdjwf(S,T,zeros(1280,240));
end

for x = 1:2560;
    for y=1:479;
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
dz=repmat(dz,1,2560)';
%delrho=diff(density,1,2);
%drho_dz=delrho./dz;
%N2=(-g/rho_o)*drho_dz;

delU = diff(U,1,2);
delV = diff(V,1,2);
dU_dz =abs(delU./dz);
dV_dz =abs(delV./dz);
Ri = N2./(dU_dz.^2+dV_dz.^2);


figure(1);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:480),N2'); shading flat;
caxis([-1e-6 10e-6]); colormap(bluewhitered); colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('N^2 value')
ylabel('Depth (m)'); xlabel('X Position (m)');
box on; set(gca,'Layer','top');

figure(2);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:480),dU_dz'); shading flat;
caxis([0 .005]); colormap bluewhitered; colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('Magnitude of dU/dz');
ylabel('Depth (m)'); xlabel('X Position (m)');
box on; set(gca,'Layer','top');

load redblue.mat
figure(3);
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC/1000,z(2:480),Ri'); shading flat;
caxis([-1.1 1.1]); colormap(redblue); colorbar;
%xlim([0 75000]); ylim([-2500 0]);
title('Richardson number');
set(gca,'Fontsize',14)
ylabel('Depth (m)'); xlabel('X Position (km)');
box on; set(gca,'Layer','top');
%xlim([20 50])
%ylim([-2200 -500])





















