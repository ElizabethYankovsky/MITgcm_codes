clear all
close all
load XC.mat
load z.mat

cd Originalinput
fid1= fopen('topog.slope','r','b');
topo=fread(fid1,'real*8');
topo = reshape(topo,[640 900]);
topo = sq(topo(:,10)); topo(1)=0;
cd ..

Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 1 1 40],[Inf Inf Inf 1]));
figure(4)
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
for i =[1 300 600 700]
    figure(i)
    area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
    hold on
    Traceri=sq(Tracer(:,i,:))';
    pcolor(XC,z,Traceri); shading flat;
    caxis([0 1]);
    colormap bluewhitered; colorbar;
    xlabel('X Position (m)','Fontsize',12)
    ylabel('Depth (m)','Fontsize',12)
    title('Tracer Concentration','Fontsize',12);
    ylim([-2500 0]);
end
% figure(4)
% test = sq(Tracer(:,:,2));
% pcolor(test')
% colormap bluewhitered; colorbar;
% xlabel('X Position (m)','Fontsize',12)
% ylabel('Depth (m)','Fontsize',12)
% title('Tracer: overlay of all xz-slices in domain','Fontsize',12);
% ylim([-2500 0]);

Tracerxz= sq(nanmean(Tracer,2))';
figure(5)
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC/1000,z,Tracerxz); shading flat;
caxis([0 1]); colormap bluewhitered; 
c=colorbar;
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Alongshore-Averaged Tracer Concentration','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);