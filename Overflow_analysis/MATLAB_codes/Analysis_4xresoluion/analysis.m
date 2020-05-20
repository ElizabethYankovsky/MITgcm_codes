clear all
close all
load z.mat
load topo.mat
load XC.mat


for i = 300;
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
 a = [XC(1480)/1000 XC(2560)/1000]; b = [topo(1480) z(401)]; 
    figure(1)
   
    pcolor(XC/1000,z,V'); shading flat
    caxis([-0.2 1]); colorbar;
    colormap('bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    %set(gcf,'color','w');
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Alongshore Velocity (V)','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);
    %mymovie1(i)=getframe(gcf);
    %clf
    
    figure(2)
    pcolor(XC/1000,z,Tracer'); shading flat
    caxis([0 1]); colorbar;
    colormap('bluewhitered')
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    %line(a,b,'Linewidth',2,'Color','k');
    %set(gcf,'color','w')
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Tracer Concentration','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);

   % mymovie2(i)=getframe(gcf);
   % clf
    figure(3)
    pcolor(XC/1000,z,W'); shading flat
    caxis([-0.005 0.005]); colorbar;
    colormap('bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    %set(gcf,'Color','w')
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Vertical Velocity (W)','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);
%line(a,b,'Linewidth',2,'Color','k');

    %mymovie3(i)=getframe(gcf);
    %clf
    figure(4)
    pcolor(XC/1000,z,U'); shading flat
    caxis([-.025 0.025]); colorbar;
    colormap('bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    %set(gcf,'color','w')
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Offshore Velocity (U)','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);
%line(a,b,'Linewidth',2,'Color','k')
    %mymovie4(i)=getframe(gcf);
    %clf
    i
end
% load spectral.mat
% figure(5)
% pcolor(XC/1000,z,Tinit1'); shading flat
% colorbar; hold on; caxis([-0.9 0]); colormap(spectral);
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% title('Initial Potential Temperature'), 
% h = colorbar; title(h,'\circC');
% xlabel('X Position (km)')
% ylabel('Depth (m)')
% 
% figure(6)
% pcolor(XC/1000,z,Sinit1'); shading flat
% colorbar; hold on; caxis([34.45 34.95]); colormap(spectral);
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% title('Initial Salinity');
% h = colorbar; title(h,'psu');
% xlabel('X Position (km)')
% ylabel('Depth (m)')
% 
% densityinit = densmdjwf(Sinit1,Tinit1,zeros(1280,240));
% figure(7)
% pcolor(XC/1000,z,densityinit'); shading flat
% colorbar; hold on; caxis([1027.6 1028.1]); colormap(spectral);
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% %title('Initial Potential Density')
% h = colorbar; title(h,'kg/m^3');
% set(gca,'Fontsize',14)
% xlabel('X Position (km)','Fontsize',16)
% ylabel('Depth (m)','Fontsize',16)
% ylim([-2500 0]); xlim([0 75]);
% 
% 
% 
