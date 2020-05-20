clear all
close all
%
%
%
load z.mat; %z=z-z(1);
YC = 111.111:111.111:99999.9;
XC=ncread('Original1.nc','X');
load topo.mat
refpressure1=repmat(-z*1027.7*9.81/10000,1,640,900);
refpressure=permute(refpressure1,[2 3 1]);
for i =240
    if i>=1 && i<=40
        S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
        T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
        U=sq(ncread('Original1.nc','U',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(ncread('Original1.nc','V',[1 1 1 i],[640 900 120 1]));
    elseif i>=41 && i<=80
        S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
        T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
        U=sq(ncread('Original2.nc','U',[1 1 1 i-40],[Inf Inf Inf 1]));  
        V=sq(ncread('Original2.nc','V',[1 1 1 i-40],[640 900 120 1]));
    elseif i>=81 && i<=120
        S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
        U=sq(ncread('Original3.nc','U',[1 1 1 i-80],[Inf Inf Inf 1])); 
        V=sq(ncread('Original3.nc','V',[1 1 1 i-80],[640 900 120 1])); 
    elseif i>=121 && i<=160
        S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
        T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
        U=sq(ncread('Original4.nc','U',[1 1 1 i-120],[Inf Inf Inf 1]));
        V=sq(ncread('Original4.nc','V',[1 1 1 i-120],[640 900 120 1]));
    elseif i>=161 && i<=201
        S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
        T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
        U=sq(ncread('Original5.nc','U',[1 1 1 i-160],[Inf Inf Inf 1]));  
        V=sq(ncread('Original5.nc','V',[1 1 1 i-160],[640 900 120 1]));
    elseif i>=201 && i<=240
        S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
        T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
        U=sq(ncread('Original6.nc','U',[1 1 1 i-200],[Inf Inf Inf 1])); 
        V=sq(ncread('Original6.nc','V',[1 1 1 i-200],[640 900 120 1]));
    end
   density = densmdjwf(S,T,zeros(640,900,120));
   % density = densmdjwf(S,T,refpressure);
end  
U=U(1:640,:,:);
g=9.81;
rho_o=1027.7;
dz=diff(z);
dz=permute(repmat(dz,1,640,900),[2 3 1]);
delrho=diff(density,1,3);
drho_dz=delrho./dz;
N2=(-g/rho_o)*drho_dz;
delU = diff(U,1,3);
dU_dz =abs(delU./dz);
Ri = N2./(dU_dz.^2);

yindex=675;
figure(1);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:120),sq(N2(:,yindex,:))'); shading flat;
caxis([-1 10]*10^-7); colormap(bluewhitered); colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('N^2 value at y=75km')
ylabel('Depth (m)'); xlabel('X Position (m)');

figure(2);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:120),sq(dU_dz(:,yindex,:))'); shading flat;
caxis([0 .005]); colormap bluewhitered; colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('Magnitude of dU/dz at y=75km');
ylabel('Depth (m)'); xlabel('X Position (m)');
load redblue.mat
figure(3);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:120),sq(Ri(:,yindex,:))'); shading flat;
caxis([-1 1]); colormap(redblue); colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('Richardson number at y=75km');
ylabel('Depth (m)'); xlabel('X Position (m)');


figure(4);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:120),sq(nanmean(N2,2))'); shading flat;
caxis([-1 10]*10^-7); colormap(bluewhitered); colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('N^2 value, along-slope averaged')
ylabel('Depth (m)'); xlabel('X Position (m)');

figure(5);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:120),sq(nanmean(dU_dz,2))'); shading flat;
caxis([0 .005]); colormap bluewhitered; colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('Magnitude of dU/dz, along-slope averaged');
ylabel('Depth (m)'); xlabel('X Position (m)');

figure(6);
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z(2:120),sq(nanmean(Ri,2))'); shading flat;
caxis([-1 1]); colormap(redblue); colorbar;
xlim([0 75000]); ylim([-2500 0]);
title('Richardson number, along-slope averaged');
ylabel('Depth (m)'); xlabel('X Position (m)');






















