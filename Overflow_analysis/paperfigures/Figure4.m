clear all
close all
load z.mat
load topo.mat
load XC.mat
load Tracer20.mat; load Tracer60.mat;
load U20.mat; load U60.mat;
load W20.mat; load W60.mat;
load V20.mat; load V60.mat;

figure(101)
%GAP MARGIN HEIGHT MARGIN WIDTH
ha=tight_subplot(4,2,0.04,0.06,0.1)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*1.5 pos(4)*2.5])

axes(ha(1))
    pcolor(XC/1000,z,Tracer20'); shading flat
    caxis([0 1]); colorbar;
    colormap(ha(1),bluewhitered)
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title({'20 Days','Tracer concentration'},'Fontsize',14);
    ylim([-2500 0]); xlim([0 75]); box on; 
    set(gca,'xticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(2))   
    pcolor(XC/1000,z,Tracer60'); shading flat
    caxis([0 1]); colorbar;
    colormap(ha(2),bluewhitered)
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    title({'60 Days','Tracer concentration'},'Fontsize',14);
    ylim([-2500 0]); xlim([0 75]); box on; 
    set(gca,'xticklabel',[]); set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'e','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(3))
    pcolor(XC/1000,z,U20'); shading flat
    caxis([-.01 0.01]); colorbar; %originally 0.06 on both sides
    colormap(ha(3),bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('Offshore velocity (U)','Fontsize',14);
    ylim([-2500 0]); xlim([0 75]); box on; 
    set(gca,'xticklabel',[]); 
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(4))
    pcolor(XC/1000,z,U60'); shading flat
    caxis([-.01 0.01]); colorbar;
    colormap(ha(4),bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    title('Offshore velocity (U)','Fontsize',14);
    ylim([-2500 0]); xlim([0 75]); box on; 
    set(gca,'xticklabel',[]); set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'f','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')

    
axes(ha(5))
    pcolor(XC/1000,z,V20'); shading flat
    caxis([-0.2 1]); colorbar;
    colormap(ha(5),bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('Alongshore velocity (V)','Fontsize',14);
    ylim([-2500 0]); xlim([0 75]); box on; 
    set(gca,'xticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(6))
    pcolor(XC/1000,z,V60'); shading flat
    caxis([-0.2 1]); colorbar;
    colormap(ha(6),bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    title('Alongshore velocity (V)','Fontsize',14);
    ylim([-2500 0]); xlim([0 75]); box on; 
    set(gca,'xticklabel',[]); set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'g','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(7))
    pcolor(XC/1000,z,W20'); shading flat
    caxis([-0.005 0.005]); colorbar; %originally 0.01 on both sides
    colormap(ha(7),bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('Vertical velocity (W)','Fontsize',14);
    ylim([-2500 0]); xlim([0 75]); box on;
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(8))
    pcolor(XC/1000,z,W60'); shading flat
    caxis([-0.005 0.005]); colorbar;
    colormap(ha(8),bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',16)
    title('Vertical velocity (W)','Fontsize',14);
    ylim([-2500 0]); xlim([0 75]); box on; 
    set(gca,'yticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'h','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')

set(gcf,'Color','w');
%print(gcf,'fig4.jpg','-djpeg','-r500')



















