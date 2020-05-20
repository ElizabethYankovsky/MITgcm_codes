clear all
close all
load z.mat
load topo.mat
load XC.mat; load YC.mat
load Tracerxz.mat; load value.mat; load Tracer.mat;
load Tracerxz1_8.mat; load value1_8.mat; load Tracer1_8.mat;
load Tracerxz2.mat; load value2.mat; load Tracer2.mat;

figure(101)
ha=tight_subplot(3,3,0.06,0.07,0.08)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*2 pos(4)*2])

axes(ha(1))
pcolor(XC/1000,z,Tracerxz2);
shading flat; 
colorbar; caxis([0 1]); colormap(ha(1),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X position (km)','Fontsize',14)
%set(ha(1),'xticklabel',[]);
ylabel('Depth (m)','Fontsize',14) 
box on;
pbaspect([1 .8846 .8846])
text(0.9,0.90,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(2))
pcolor(XC/1000,YC/1000,(sq(value2)'));
shading flat;
caxis([0 1]); colormap(ha(2),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X position (km)','Fontsize',14)
%set(ha(2),'xticklabel',[]);
%set(ha(2),'yticklabel',[]);
ylabel('Y position (km)','Fontsize',14)
ylim([0 100]); xlim([0 75]);
pbaspect([1 .8 .8]);
box on;
text(0.9,0.90,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(3))
pcolor(XC/1000,YC/1000,sq(Tracer2(:,:,2))');
shading flat;
 caxis([0 1]); colormap(ha(3),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X position (km)','Fontsize',14)
%set(ha(3),'xticklabel',[]);
%set(ha(3),'yticklabel',[])
%ylabel('Y position (km)','Fontsize',14)
xlim([0 75]); ylim([0 100]);
pbaspect([1 .8 .8]); 
box on;
text(0.9,0.90,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(4))
pcolor(XC/1000,z,Tracerxz);
shading flat; 
colorbar; caxis([0 1]); colormap(ha(4),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X position (km)','Fontsize',14)
%set(ha(4),'xticklabel',[]);
ylabel('Depth (m)','Fontsize',14) 
box on;
pbaspect([1 .8846 .8846])
text(0.9,0.90,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(5))
pcolor(XC/1000,YC/1000,(sq(value)'));
shading flat;
caxis([0 1]); colormap(ha(5),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X position (km)','Fontsize',14)
%set(ha(5),'xticklabel',[]);
%set(ha(2),'yticklabel',[]);
ylabel('Y position (km)','Fontsize',14)
ylim([0 100]); xlim([0 75]);
pbaspect([1 .8 .8]);
box on;
text(0.9,0.90,'e','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(6))
pcolor(XC/1000,YC/1000,sq(Tracer(:,:,2))');
shading flat;
caxis([0 1]); colormap(ha(6),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
%xlabel('X position (km)','Fontsize',14)
%set(ha(6),'xticklabel',[]);
%set(ha(3),'yticklabel',[])
%ylabel('Y position (km)','Fontsize',14)
xlim([0 75]); ylim([0 100]);
pbaspect([1 .8 .8]); 
box on;
text(0.9,0.90,'f','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(7))
pcolor(XC/1000,z,Tracerxz1_8);
shading flat; 
colorbar; caxis([0 1]); colormap(ha(7),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
xlabel('X position (km)','Fontsize',14)
%set(ha(7),'xticklabel',[]);
ylabel('Depth (m)','Fontsize',14) 
pbaspect([1 .8846 .8846])
text(0.9,0.90,'g','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
box on
set(gca,'Layer','top')

axes(ha(8))
pcolor(XC/1000,YC/1000,(sq(value1_8)'));
shading flat;
 caxis([0 1]); colormap(ha(8),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
xlabel('X position (km)','Fontsize',14)
%set(ha(8),'xticklabel',[]);
%set(ha(8),'yticklabel',[]);
ylabel('Y position (km)','Fontsize',14)
ylim([0 100]); xlim([0 75]);
pbaspect([1 .8 .8]);
text(0.9,0.90,'h','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(9))
pcolor(XC/1000,YC/1000,sq(Tracer1_8(:,:,2))');
shading flat;
 caxis([0 1]); colormap(ha(9),bluewhitered)
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8]);
set(gca,'Fontsize',12)
xlabel('X position (km)','Fontsize',14)
%set(ha(9),'xticklabel',[]);
%set(ha(9),'yticklabel',[])
%ylabel('Y position (km)','Fontsize',14)
xlim([0 75]); ylim([0 100]);
pbaspect([1 .8 .8]); 
box on;
text(0.9,0.90,'i','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')
%print(gcf,'fig8.jpg','-djpeg','-r300')



