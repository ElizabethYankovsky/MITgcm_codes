clear all
close all
load z.mat
load topo.mat
load XC.mat
load U40.mat; load U60.mat
load Q40.mat; load Q60.mat;
load angmom40.mat; load angmom60.mat; load density40.mat; load density60.mat;
load redblue.mat
load Ri40.mat; load Ri60.mat;
figure(101)
%GAP MARGIN HEIGHT MARGIN WIDTH
ha=tight_subplot(4,2,0.04,0.06,0.13)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*1.5 pos(4)*2.5])

axes(ha(1))
    pcolor(XC/1000,z,U40'); shading flat
    caxis([-.025 0.025]); colorbar;
    colormap(ha(1),bluewhitered)
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title({'40 Days','Offshore velocity (U)'},'Fontsize',14);
    ylim([-1900 -700]); xlim([32 40]); box on; 
    %set(gca,'xticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(2))   
    pcolor(XC/1000,z,U60'); shading flat
    caxis([-.025 0.025]); colorbar;
    colormap(ha(2),bluewhitered)
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'m/s');
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    title({'60 Days','Offshore velocity (U)'},'Fontsize',14);
    ylim([-1900 -700]); xlim([32 40]); box on; 
    %set(gca,'xticklabel',[]); 
    set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'e','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(3))
    pcolor(XC(1:2559)/1000,z(1:479),Q40'); shading flat
    caxis([-1e-11 0]); colorbar; 
    colormap(ha(3),bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('Location of negative Ertel PV','Fontsize',14);
    ylim([-1900 -700]); xlim([32 40]); box on; 
    %set(gca,'xticklabel',[]); 
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(4))
    pcolor(XC(1:2559)/1000,z(1:479),Q60'); shading flat
    caxis([-1e-11 0]); colorbar;
    colormap(ha(4),bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    title('Location of negative Ertel PV','Fontsize',14);
    ylim([-1900 -700]); xlim([32 40]); box on; 
    %set(gca,'xticklabel',[]); 
    set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'f','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(5))
    pcolor(XC/1000,z(2:480),Ri40'); shading flat
    caxis([-1.1 1.1]); colorbar; %originally 0.01 on both sides
    colormap(ha(5),redblue)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    ylabel('Depth (m)','Fontsize',14)
    title('Richardson number','Fontsize',14);
    ylim([-1600 -800]); xlim([32 40]); box on; 
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(6))
    pcolor(XC/1000,z(2:480),Ri60'); shading flat
    caxis([-1.1 1.1]); colorbar;
    colormap(ha(6),redblue)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %ylabel('Depth (m)','Fontsize',16)
    title('Richardson number','Fontsize',14);
    ylim([-1600 -800]); xlim([32 40]); box on; 
    set(gca,'yticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'g','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(7))
    contour(XC/1000,z,density40',[1027.6:.005:1029.4],'r','linewidth',1.2);
    caxis([1027.6 1029]);
    hold on; colorbar; caxis([-1 1])
    contour(XC/1000,z,angmom40',[.01:.2:10.11],'k','linewidth',1.5)
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    ylim([-1600 -800]); xlim([32 40]); box on; 
    %set(gca,'xticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(8))
    contour(XC/1000,z,density60',[1027.6:.0048:1029.4],'r','linewidth',1.2);
    caxis([1027.6 1029]);
    hold on; colorbar; caxis([-1 1])
    contour(XC/1000,z,angmom60',[.01:.2:10.11],'k','linewidth',1.5)
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    ylim([-1600 -800]); xlim([32 40]); box on; 
    %set(gca,'xticklabel',[]); 
    set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'h','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    

set(gcf,'Color','w');
%print(gcf,'fig4.jpg','-djpeg','-r500')



















