clear all
close all
load z.mat
load topo.mat
topo=-topo;
load XC.mat
load spectral.mat

cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit1 = reshape(Tinit,[1280 240]);
Tinit = sq(Tinit1(:,1,:));

fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit1 = reshape(Sinit,[1280 240]);
Sinit = sq(Sinit1(:,1,:));
cd ..
% V velocity
for i = 7;
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));      
        S = sq(ncread('HR2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
        T = sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));  
        S = sq(ncread('HR3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        T = sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
        S = sq(ncread('HR4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
        T = sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));  
        S = sq(ncread('HR5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
        T = sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1])); 
        S = sq(ncread('HR6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
        T = sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
    end
 a = [XC(740)/1000 XC(1280)/1000]; b = [topo(740) z(201)]; 
   figure(1)
   
    pcolor(XC/1000,z,V'); shading flat
    caxis([-0.2 1]); colorbar;
    colormap('bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gcf,'color','w');
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
    set(gcf,'color','w')
    set(gca,'Fontsize',14)
    xlabel('X Position (km)','Fontsize',16)
    ylabel('Depth (m)','Fontsize',16)
    title('Tracer Concentration','Fontsize',16);
    ylim([-2500 0]); xlim([0 75]);
    %mymovie2(i)=getframe(gcf);
    %clf
   
    figure(3)
    pcolor(XC/1000,z,W'); shading flat
    caxis([-0.01 0.01]); colorbar;
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
    caxis([-.06 0.06]); colorbar;
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
    
    figure(5)
    pcolor(XC/1000,z,T'); shading flat
    caxis([-2.0 0]); colormap(spectral);
    colorbar;
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'deg. C');
    %set(gcf,'color','w')
    set(gca,'Fontsize',14)
    xlabel('X Position (km)','Fontsize',16)
    ylabel('Depth (m)','Fontsize',16)
    title('Temperature','Fontsize',16);
    ylim([-2500 0]); xlim([0 75]);
    %line(a,b,'Linewidth',2,'Color','k')
    %mymovie5(i)=getframe(gcf);
    %clf
    
    figure(6)
    pcolor(XC/1000,z,S'); shading flat
    caxis([34.45 36]); colormap(spectral);
    colorbar;
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'psu');
    %set(gcf,'color','w')
    set(gca,'Fontsize',14)
    xlabel('X Position (km)','Fontsize',16)
    ylabel('Depth (m)','Fontsize',16)
    title('Salinity','Fontsize',16);
    ylim([-2500 0]); xlim([0 75]);
    %line(a,b,'Linewidth',2,'Color','k')
    %mymovie6(i)=getframe(gcf);
    %clf
    i
end

% figure(7)
% pcolor(XC/1000,z,Tinit1'); shading flat
% colorbar; hold on; caxis([-0.9 0]); colormap(spectral);
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% title('Initial Potential Temperature'), 
% h = colorbar; title(h,'\circC');
% xlabel('X Position (km)')
% ylabel('Depth (m)')
% 
% figure(8)
% pcolor(XC/1000,z,Sinit1'); shading flat
% colorbar; hold on; caxis([34.45 34.95]); colormap(spectral);
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% title('Initial Salinity');
% h = colorbar; title(h,'psu');
% xlabel('X Position (km)')
% ylabel('Depth (m)')

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


%to play: movie(gcf,mymovie1)
