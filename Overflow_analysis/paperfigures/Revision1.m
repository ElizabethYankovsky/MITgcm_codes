clear all
close all
load z1.mat; load z2.mat; load z3.mat;
load topo1.mat; load topo2.mat; load topo3.mat;
load XC1.mat; load XC2.mat; load XC3.mat
load density1.mat; load ang_mom1.mat; 
load density2.mat; load ang_mom2.mat; 
load density3.mat; load ang_mom3.mat; 
load Q1.mat; load Q2.mat; load Q3.mat;
load Q4.mat; load density4.mat; load ang_mom4.mat;

figure(101)
%GAP MARGIN HEIGHT MARGIN WIDTH
ha=tight_subplot(4,2,0.02,0.06,0.15)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*1.5 pos(4)*2.5])

axes(ha(1))
    pcolor(XC1(1:639)/1000,z1(1:119),Q1'); shading flat
    caxis([-1e-11 0]); 
    colormap(ha(1),bluewhitered)
    hold on
    area(XC1/1000,topo1,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('Location of negative Ertel PV','Fontsize',14);
    xlim([30 60]); ylim([-2500 -500]); box on; 
    set(gca,'xticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(2))   
    contour(XC1/1000,z1,density1',[1027.6:.02:1029.4],'r','linewidth',1); 
    caxis([1027.6 1029])
    hold on
    contour(XC1/1000,z1,ang_mom1',[.01:.2:10.11],'k','linewidth',1)
    area(XC1/1000,topo1,-2500,'Facecolor',[.8 .8 .8])
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    xlim([30 60]);
    ylim([-2500 -500]); box on; 
    set(gca,'xticklabel',[]); set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'e','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(3))
    pcolor(XC2(1:1279)/1000,z2(1:239),Q2'); shading flat
    caxis([-1e-11 0]);  %originally 0.06 on both sides
    colormap(ha(3),bluewhitered)
    hold on;
    area(XC2/1000,topo2,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    xlim([30 60]); ylim([-2500 -500]); box on; 
    set(gca,'xticklabel',[]); 
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(4))
    contour(XC2/1000,z2,density2',[1027.6:.02:1029.4],'r','linewidth',1); 
    caxis([1027.6 1029])
    hold on;
    contour(XC2/1000,z2,ang_mom2',[.01:.2:10.11],'k','linewidth',1)
    area(XC2/1000,topo2,-2500,'Facecolor',[.8 .8 .8]);
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    xlim([30 60]);
    ylim([-2500 -500]); box on; 
    set(gca,'xticklabel',[]); set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'f','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')

    
axes(ha(5))
    pcolor(XC3(1:2559)/1000,z3(1:479),Q3'); shading flat
    caxis([-1e-11 0]);
    colormap(ha(5),bluewhitered)
    hold on;
    area(XC3/1000,topo3,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    xlim([30 60]); ylim([-2500 -500]); box on; 
    set(gca,'xticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(6))
    contour(XC3/1000,z3,density3',[1027.6:.02:1029.4],'r','linewidth',1); 
    caxis([1027.6 1029])
    hold on;
    contour(XC3/1000,z3,ang_mom3',[.01:.2:10.11],'k','linewidth',1)
    area(XC3/1000,topo3,-2500,'Facecolor',[.8 .8 .8])
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    xlim([30 60]); ylim([-2500 -500]); box on; 
    set(gca,'xticklabel',[]); set(gca,'yticklabel',[]);
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'g','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(7))
    pcolor(XC3(1:2559)/1000,z3(1:479),Q4'); shading flat;
    hold on;
    caxis([-1e-11 0]); colormap(bluewhitered)
    area(XC3/1000,topo3,-2500,'Facecolor',[.8 .8 .8]);
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)

    xlim([30 60]); ylim([-2500 -500]); box on;
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
    
axes(ha(8))
    contour(XC3/1000,z3,density4',[1027.6:.02:1029.4],'r','linewidth',1);
    caxis([1027.6 1029])
    hold on;
    contour(XC3/1000,z3,ang_mom4',[.01:.2:10.11],'k','linewidth',1)
    area(XC3/1000,topo3,-2500,'Facecolor',[.8 .8 .8])
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',16)
    xlim([30 60]); ylim([-2500 -500]); box on; 
    set(gca,'yticklabel',[])
    pbaspect([1 0.8846 .8846]);
    text(0.05,0.2,'h','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')

set(gcf,'Color','w');
%print(gcf,'fig4.jpg','-djpeg','-r500')



















