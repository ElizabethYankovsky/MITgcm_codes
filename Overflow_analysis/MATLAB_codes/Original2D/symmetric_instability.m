clear all
close all
load z.mat
load topo.mat
topo=-topo;
load XC.mat

cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit = reshape(Tinit,[1280 240]);
Tinit = sq(Tinit(:,1,:));

fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit = reshape(Sinit,[1280 240]);
Sinit = sq(Sinit(:,1,:));
cd ..
% V velocity
for i = [240];
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[1280 Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[1280 Inf Inf 1]));
       % Tracer=sq(ncread('HRtracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
        S=sq(ncread('HR2.nc','S',[1 1 1 i-40],[1280 Inf Inf 1]));
        T=sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[1280 Inf Inf 1]));
        %Tracer=sq(ncread('HRtracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));        
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
        S=sq(ncread('HR3.nc','S',[1 1 1 i-80],[1280 Inf Inf 1]));
        T=sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[1280 Inf Inf 1]));
    %    Tracer=sq(ncread('HRtracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));       
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
        S=sq(ncread('HR4.nc','S',[1 1 1 i-120],[1280 Inf Inf 1]));
        T=sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[1280 Inf Inf 1]));
   %     Tracer=sq(ncread('HRtracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=201
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
        S=sq(ncread('HR5.nc','S',[1 1 1 i-160],[1280 Inf Inf 1]));
        T=sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[1280 Inf Inf 1]));
   %     Tracer=sq(ncread('HRtracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));        
    elseif i>=201 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
        S=sq(ncread('HR6.nc','S',[1 1 1 i-200],[1280 Inf Inf 1]));
        T=sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[1280 Inf Inf 1]));
 %       Tracer=sq(ncread('HRtracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));       
    end

     density = densmdjwf(S,T,0);
    xnew=repmat(XC,1,240);
    ang_mom= (1.43*10^-4)*xnew+V;
   figure(i)
    contour(XC/1000,z,density',[1027.6:.02:1029.4],'r','linewidth',1.5); 
    caxis([1027.6 1029])
    hold on;
    contour(XC/1000,z,ang_mom',[.01:.2:10.11],'k','linewidth',1.5)
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gcf,'color','w');
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',14)
    xlabel('X Position (km)','Fontsize',16)
    ylabel('Depth (m)','Fontsize',16)
    xlim([30 60]);
    ylim([-2500 -500])


   figure(i+1)
    dVx = diff(V,1,1);
    dx = diff(XC,1); dx = repmat(dx,1,240);
    dVdx = dVx./dx;
    
    dVz = diff(V,1,2);
    dz = diff(z)'; dz = repmat(dz,1280,1);
    dVdz = dVz./dz;
    
    drhox = diff(density,1,1);
    drhodx=drhox./dx;
    drhoz = diff(density,1,2);
    drhodz=drhoz./dz;
    g = 9.8; rho_o=1027.7;
    f=1.43e-4;
    dVdz=dVdz(1:1279,1:239); drhodx=drhodx(1:1279,1:239);
    drhodz=drhodz(1:1279,1:239); dVdx=dVdx(1:1279,1:239);
    Q =(g/rho_o)*drhodx.*dVdz - (g/rho_o)*drhodz.*(dVdx+f);
    pcolor(XC(1:1279)/1000,z(1:239),Q');
    shading flat
    colorbar
    caxis([-.5e-9 .5e-9]);
    colormap(bluewhitered)
     hold on
     area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
     
     h = colorbar; title(h,'1/s^3');
     set(gca,'Fontsize',14)
    xlabel('X Position (km)','Fontsize',16)
    ylabel('Depth (m)','Fontsize',16)
    title('Ertel PV','Fontsize',16);
    xlim([30 60]);
    ylim([-2500 -500])
     
 
 
%     set(gcf,'color','w');
%     i
end
figure(101)
pcolor(XC(1:1279)/1000,z(1:239),((g/rho_o)*drhodx.*dVdz)');
shading flat;
colorbar; caxis([-.5e-9 .5e-9]); colormap(bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Term 1','Fontsize',16);
xlim([30 60]); ylim([-2500 -500]);


figure(102)
pcolor(XC(1:1279)/1000,z(1:239),-((g/rho_o)*drhodz.*(dVdx+f))');
shading flat;
colorbar; caxis([-.5e-9 .5e-9]); colormap(bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Term 2','Fontsize',16);
xlim([30 60]); ylim([-2500 -500]);


% 
% figure(103)
% pcolor(XC(1:1279)/1000,z(1:239),(dVdx+f)');
% shading flat;
% colorbar;  caxis([-1e-3 1e-3]); 
% colormap(bluewhitered)
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% xlim([30 60]); ylim([-2500 -500]);
% xlabel('X Position (km)'); ylabel('Depth (m)');
% title('Absolute vorticity');
% 
% figure(104)
% pcolor(XC(1:1279)/1000,z(1:239),(drhodx)');
% shading flat;
% colorbar; caxis([-1e-4 1e-4]); 
% colormap(bluewhitered)
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% xlim([30 60]); ylim([-2500 -500]);
% xlabel('X Position (km)'); ylabel('Depth (m)');
% title('Drho/dx');
% caxis([-1e-4 1e-4])
% 
% figure(105)
% pcolor(XC(1:1279)/1000,z(1:239),(dVdz)');
% shading flat;
% colorbar; caxis([-1e-2 1e-2])
% colormap(bluewhitered)
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% xlim([30 60]); ylim([-2500 -500]);
% xlabel('X Position (km)'); ylabel('Depth (m)');
% title('dVdz');
% 
figure(120)
Q2=Q;
Q2(Q2>=0)=NaN;
pcolor(XC(1:1279)/1000,z(1:239),Q2');
shading flat;
%colorbar; 
caxis([-1e-20 0]); colormap(bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Location of Negative PV','Fontsize',16);
xlim([30 60]); ylim([-2500 -500]);

% figure(121)
% pcolor(XC/1000,z,U');
% shading flat;
% colorbar; caxis([-.01 0.01])
% colormap(bluewhitered)
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% 
% h = colorbar; title(h,'m/s');
% set(gca,'Fontsize',14)
% xlabel('X Position (km)','Fontsize',16)
% ylabel('Depth (m)','Fontsize',16)
% title('Offshore Velocity (U)','Fontsize',16);
% xlim([30 60]); ylim([-2500 -500]);
% 
% figure(122)
% pcolor(XC/1000,z,V');
% shading flat;
% colorbar; caxis([-.2 1])
% colormap(bluewhitered)
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% 
% h = colorbar; title(h,'m/s');
% set(gca,'Fontsize',14)
% xlabel('X Position (km)','Fontsize',16)
% ylabel('Depth (m)','Fontsize',16)
% title('Alongshore Velocity (V)','Fontsize',16);
% xlim([30 60]); ylim([-2500 -500]);
% 
% figure(123)
% pcolor(XC/1000,z,W');
% shading flat;
% colorbar; caxis([-.01 0.01])
% colormap(bluewhitered)
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
% h = colorbar; title(h,'m/s');
% set(gca,'Fontsize',14)
% xlabel('X Position (km)','Fontsize',16)
% ylabel('Depth (m)','Fontsize',16)
% title('Vertical Velocity (W)','Fontsize',16);
% xlim([30 60]); ylim([-2500 -500]);
% 
% 
% 
% 
% 
% 
% 





















