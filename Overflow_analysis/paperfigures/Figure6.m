clear all
close all
load z.mat
load topo.mat
topo=-topo;
load XC.mat
load Q20.mat; load Term1_20.mat; load Term2_20.mat;
load Q60.mat; load Term1_60.mat; load Term2_60.mat;


figure(101)
ha=tight_subplot(2,3,0.02,0.06,0.11)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*2 pos(4)*1.25])

axes(ha(1))
pcolor(XC(1:1279)/1000,z(1:239),Q20');
shading flat; 
caxis([-1e-11 0]); colormap(ha(1),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X Position (km)','Fontsize',14)
%set(ha(1),'xticklabel',[]);
ylabel({'20 Days','Depth (m)'},'Fontsize',14)
title('Location of negative Ertel PV','Fontsize',14);
xlim([30 60]); ylim([-2500 -500]);
%pbaspect([1 0.8846 .8846]); 
box on;
pbaspect([1 .65 .65])

text(0.02,0.90,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(2))
pcolor(XC(1:1279)/1000,z(1:239),Term1_20');
shading flat;
h=colorbar; caxis([-.5e-9 .5e-9]); colormap(ha(2),bluewhitered)
title(h,'1/s^3'); hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X Position (km)','Fontsize',14)
%set(ha(2),'xticklabel',[]);
set(ha(2),'yticklabel',[]);
%ylabel('Depth (m)','Fontsize',14)
title('Term 1','Fontsize',14);
xlim([30 60]); ylim([-2500 -500]);
pbaspect([1 0.8846 .8846]); box on;
text(0.02,0.90,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(3))
pcolor(XC(1:1279)/1000,z(1:239),Term2_20');
shading flat;
h=colorbar; caxis([-.5e-9 .5e-9]); colormap(ha(3),bluewhitered)
title(h,'1/s^3'); hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X Position (km)','Fontsize',14)
%set(ha(3),'xticklabel',[]);
set(ha(3),'yticklabel',[])
%ylabel('Depth (m)','Fontsize',14)
title('Term 2','Fontsize',14);
xlim([30 60]); ylim([-2500 -500]);
pbaspect([1 0.8846 .8846]); box on;
text(0.02,0.90,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(4))
pcolor(XC(1:1279)/1000,z(1:239),Q60');
shading flat; 
caxis([-1e-11 0]); colormap(ha(4),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
xlabel('X position (km)','Fontsize',14)
ylabel({'60 Days','Depth (m)'},'Fontsize',14)
title('Location of negative Ertel PV','Fontsize',14);
xlim([30 60]); ylim([-2500 -500]);
%pbaspect([1 0.8846 .8846]); box on;
box on;
pbaspect([1 .65 .65])
text(0.02,0.90,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(5))
pcolor(XC(1:1279)/1000,z(1:239),Term1_60');
shading flat;
h=colorbar; caxis([-.5e-9 .5e-9]); colormap(ha(5),bluewhitered)
title(h,'1/s^3'); hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
xlabel('X position (km)','Fontsize',14)
set(ha(5),'yticklabel',[]);
%ylabel('Depth (m)','Fontsize',14)
title('Term 1','Fontsize',14);
xlim([30 60]); ylim([-2500 -500]);
pbaspect([1 0.8846 .8846]); box on;
text(0.02,0.90,'e','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(6))
pcolor(XC(1:1279)/1000,z(1:239),Term2_60');
shading flat;
h=colorbar; caxis([-.5e-9 .5e-9]); colormap(ha(6),bluewhitered)
title(h,'1/s^3'); hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
xlabel('X position (km)','Fontsize',14)
set(ha(6),'yticklabel',[])
%ylabel('Depth (m)','Fontsize',14)
title('Term 2','Fontsize',14);
xlim([30 60]); ylim([-2500 -500]);
pbaspect([1 0.8846 .8846]); box on;
text(0.02,0.90,'f','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

%   print(gcf,'fig6.jpg','-djpeg','-r500')  
