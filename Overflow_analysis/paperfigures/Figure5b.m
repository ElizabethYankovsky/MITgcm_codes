clear all
close all
load z.mat
load topo.mat
load XC.mat
load ang_mom20.mat; load density20.mat; load Q20.mat;
load ang_mom30.mat; load density30.mat; load Q30.mat
load ang_mom60.mat; load density60.mat; load Q60.mat


figure(101)
ha=tight_subplot(2,3,0.03,0.1,0.1)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*2 pos(4)*1.5])

axes(ha(1))
    contour(XC/1000,z,density20',[1027.6:.02:1029.4],'r','linewidth',1.5); 
    caxis([1027.6 1029]); hold on;
    contour(XC/1000,z,ang_mom20',[.01:.2:10.11],'k','linewidth',1.5)
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gcf,'color','w');
  %  legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    set(ha(1),'xticklabel',[]);
    ylabel('Depth (m)','Fontsize',14)
    xlim([30 60]); ylim([-2500 -500]);
    pbaspect([1 0.8846 .8846]); box on;
    title('20 Days');
    text(0.02,0.90,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
    
axes(ha(2))
    contour(XC/1000,z,density30',[1027.6:.02:1029.4],'r','linewidth',1.5); 
    caxis([1027.6 1029]); hold on;
    contour(XC/1000,z,ang_mom30',[.01:.2:10.11],'k','linewidth',1.5)
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gcf,'color','w');
   % legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    set(ha(2),'yticklabel',[]);
    set(ha(2),'xticklabel',[]);
    xlim([30 60]); ylim([-2500 -500]);
    pbaspect([1 0.8846 .8846]); box on;
    title('30 Days')
    text(0.02,0.90,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
    
    
axes(ha(3))
    contour(XC/1000,z,density60',[1027.6:.02:1029.4],'r','linewidth',1.5); 
    caxis([1027.6 1029]); hold on;
    contour(XC/1000,z,ang_mom60',[.01:.2:10.11],'k','linewidth',1.5)
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gcf,'color','w');
    legend('Density (kg/m^3)','Angular momentum (m/s)')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    set(ha(3),'yticklabel',[]); 
    set(ha(3),'xticklabel',[]);
    xlim([30 60]); ylim([-2500 -500]);
    pbaspect([1 0.8846 .8846]); box on;
    title('60 Days');
    text(0.02,0.90,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
    
axes(ha(4))    
    pcolor(XC(1:1279)/1000,z(1:239),Q20');
    shading flat
    %colorbar
    caxis([-.5e-9 .5e-9]);
    colormap(ha(4),bluewhitered)
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    %h = colorbar; title(h,{'Ertel PV', '1/s^3'});
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    xlim([30 60]);
    ylim([-2500 -500]);
    pbaspect([1 0.8846 .8846]); box on;
    text(0.02,0.90,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
 
axes(ha(5))    
    pcolor(XC(1:1279)/1000,z(1:239),Q30');
    shading flat
   % colorbar
    caxis([-.5e-9 .5e-9]);
    colormap(ha(5),bluewhitered)
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
  %  h = colorbar; title(h,{'Ertel PV', '1/s^3'});
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
   % ylabel('Depth (m)','Fontsize',14)
    set(ha(5),'yticklabel',[]);
    xlim([30 60]); ylim([-2500 -500])
    pbaspect([1 0.8846 .8846]); box on;
    text(0.02,0.90,'e','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
       

axes(ha(6))    
    pcolor(XC(1:1279)/1000,z(1:239),Q60');
    pbaspect([1 0.8846 .8846]); 
    shading flat
 %   colorbar
    caxis([-.5e-9 .5e-9]);
    colormap(ha(6),bluewhitered)
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
  %  h = colorbar; title(h,{'Ertel PV', '1/s^3'});
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
   % ylabel('Depth (m)','Fontsize',14)
   set(ha(6),'ytick',[]);
   xlim([30 60]); ylim([-2500 -500])   
   pbaspect([1 0.8846 .8846]); box on;
   text(0.02,0.90,'f','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
   set(gca,'Layer','top')  

%   print(gcf,'fig5.jpg','-djpeg','-r500')  
    
    
