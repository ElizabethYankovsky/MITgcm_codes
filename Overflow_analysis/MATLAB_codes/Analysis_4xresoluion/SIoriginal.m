clear all
close all
load z.mat
load topo.mat
load XC.mat



for i = [321];
    if i>=1 && i<=80
        W=sq(ncread('state1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('state1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('state1.nc','U',[1 1 1 i],[2560 Inf Inf 1]));
        S=sq(ncread('state1.nc','S',[1 1 1 i],[2560 Inf Inf 1]));
        T=sq(ncread('state1.nc','Temp',[1 1 1 i],[2560 Inf Inf 1]));
       % Tracer=sq(ncread('tracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=81 && i<=160
        W=sq(ncread('state2.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('state2.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('state2.nc','U',[1 1 1 i-80],[2560 Inf Inf 1]));
        S=sq(ncread('state2.nc','S',[1 1 1 i-80],[2560 Inf Inf 1]));
        T=sq(ncread('state2.nc','Temp',[1 1 1 i-80],[2560 Inf Inf 1]));
        %Tracer=sq(ncread('tracer2.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));        
    elseif i>=161 && i<=240
        W=sq(ncread('state3.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('state3.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('state3.nc','U',[1 1 1 i-160],[2560 Inf Inf 1]));
        S=sq(ncread('state3.nc','S',[1 1 1 i-160],[2560 Inf Inf 1]));
        T=sq(ncread('state3.nc','Temp',[1 1 1 i-160],[2560 Inf Inf 1]));
    %    Tracer=sq(ncread('tracer3.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));           
    elseif i>=241
        W=sq(ncread('stateHR.nc','W',[1 1 1 i-240],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('stateHR.nc','V',[1 1 1 i-240],[Inf Inf Inf 1]),2));
        U=sq(ncread('stateHR.nc','U',[1 1 1 i-240],[2560 Inf Inf 1]));
        %Tracer=sq(ncread('tracerHR.nc','tracer',[1 1 1 i-240],[Inf Inf Inf 1]));  
        S = sq(ncread('stateHR.nc','S',[1 1 1 i-240],[Inf Inf Inf 1]));
        T = sq(ncread('stateHR.nc','Temp',[1 1 1 i-240],[Inf Inf Inf 1]));
    end

     density = densmdjwf(S,T,0);
    xnew=repmat(XC,1,480);
    ang_mom= (1.43*10^-4)*xnew+V;
   figure(i)
    contour(XC/1000,z,density',[1027.61:.02:1029.41],'r','linewidth',1.5); 
    caxis([1027.6 1029])
    hold on;
    contour(XC/1000,z,ang_mom',[.01:.2:10.11],'k','linewidth',1.5)
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gcf,'color','w');
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    xlim([30 60]);
    ylim([-2500 -500])
    box on
    set(gca,'Layer','top')


   figure(i+1)
    dVx = diff(V,1,1);
    dx = diff(XC,1); dx = repmat(dx,1,480);
    dVdx = dVx./dx;
    
    dVz = diff(V,1,2);
    dz = diff(z)'; dz = repmat(dz,2560,1);
    dVdz = dVz./dz;
    
    drhox = diff(density,1,1);
    drhodx=drhox./dx;
    drhoz = diff(density,1,2);
    drhodz=drhoz./dz;
    g = 9.8; rho_o=1027.7;
    f=1.43e-4;
    dVdz=dVdz(1:2559,1:479); drhodx=drhodx(1:2559,1:479);
    drhodz=drhodz(1:2559,1:479); dVdx=dVdx(1:2559,1:479);
    Q =(g/rho_o)*drhodx.*dVdz - (g/rho_o)*drhodz.*(dVdx+f);
    pcolor(XC(1:2559)/1000,z(1:479),Q');
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
    box on
     set(gca,'Layer','top')
 
 
end
figure(101)
pcolor(XC(1:2559)/1000,z(1:479),((g/rho_o)*drhodx.*dVdz)');
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
pcolor(XC(1:2559)/1000,z(1:479),-((g/rho_o)*drhodz.*(dVdx+f))');
shading flat;
colorbar; caxis([-.5e-9 .5e-9]); colormap(bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Term 2','Fontsize',16);
xlim([30 60]); ylim([-2500 -500]);
set(gca,'Layer','top')

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
pcolor(XC(1:2559)/1000,z(1:479),Q2');
shading flat;
%colorbar; 
caxis([-1e-11 0]); 
colormap(bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
xlabel('X Position (km)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14)
title('Location of negative Ertel PV','Fontsize',14);
xlim([30 60]); ylim([-2500 -500]);
box on
set(gca,'Layer','top')
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





















