clear all
close all
load XC.mat; load z.mat; load topo.mat;
load Q1.mat 
load Tracer.mat
load U.mat 
load V.mat
figure(101)
%GAP MARGIN HEIGHT MARGIN WIDTH
ha=tight_subplot(2,2,0.08,0.1,0.1)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*1.5 pos(4)*1.5])

%Tracer for original
    
axes(ha(1));
pcolor(XC/1000,z,Tracer);
    %hold on;% pcolor(XC(1:639)/1000,z(1:119),Q1');
    shading flat; colorbar; caxis([0 1]);
    colormap(ha(1),bluewhitered)
    h=colorbar; colormap(h,'bluewhitered'); 
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('Tracer concentration');
    ylim([-2500 0]);  box on;
    xlim([0 75])
   % set(gca,'xticklabel',[])
    %pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
    
axes(ha(2));
pcolor(XC/1000,z,V);
    %hold on;% pcolor(XC(1:639)/1000,z(1:119),Q1');
    shading flat; colorbar; caxis([-.2 1]);
    colormap(ha(2),bluewhitered)
    h=colorbar; colormap(h,'bluewhitered'); title(h,'m/s');
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    title('Alongshore velocity (V)');
    ylim([-2500 0]); xlim([0 75]); box on; 
    %set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    %pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')

    
axes(ha(3));
pcolor(XC/1000,z,U);
    %hold on;% pcolor(XC(1:639)/1000,z(1:119),Q1');
    shading flat; colorbar; caxis([-.2 .2]);
    colormap(ha(3),bluewhitered)
    h=colorbar; colormap(h,'bluewhitered'); title(h,'m/s');
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('Offshore velocity (U)');
    ylim([-2500 0]); xlim([0 75]); box on; 
   % set(gca,'xticklabel',[])
    %pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
axes(ha(4));
Q1(Q1<0)=-1;
pcolor(XC(1:639)/1000,z(1:119),Q1);
    %hold on;% pcolor(XC(1:639)/1000,z(1:119),Q1');
    shading flat; colorbar; caxis([-2e-10 .5e-8]);
    colormap(ha(4),bluewhitered)
    h=colorbar; colormap(h,'bluewhitered'); title(h,'1/s^3');
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    xlabel('X Position (km)','Fontsize',14)
    xlim([20 60])
    %%ylabel('Depth (m)','Fontsize',14)
    title('Ertel PV');
    ylim([-2500 0]);  box on; 
    set(gca,'yticklabel',[])
    %pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
    
