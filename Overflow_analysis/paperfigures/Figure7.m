clear all
close all
load z.mat
load topo.mat
load XC.mat
load evolution1_175.mat; load evolution2_175.mat; load evolution3_175.mat;
load Q175.mat; load Qneg175.mat;
load Q60.mat; load Qneg60.mat;
load evolution1_60.mat; load evolution2_60.mat;
load totalevolutionearly.mat; load totalevolutionlate.mat;
g = 9.8; rho_o=1027.7;

figure(101)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*1.5 pos(4)*2.5])

h1=axes('Position',[0.1 0.81 0.3 0.16]);
    pcolor(XC/1000,z,Q175'*g/rho_o);
    hold on; pcolor(XC/1000,z,Qneg175'*g/rho_o*1000);
    shading flat; colorbar; caxis([-3e-10 1e-8]);
    h=colorbar; colormap(h1,'bluewhitered'); title(h,'1/s^3');
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Ertel PV (\boldmath$q$)}','Interpreter','latex','Fontsize',12);
    ylim([-2500 0]); xlim([0 50]); box on; 
    set(gca,'xticklabel',[])
    %pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    set(gca,'Layer','top')
    
h2=axes('Position',[0.5250 0.81 0.3 0.16]); 
    pcolor(XC/1000,z,Q60'*g/rho_o);
    hold on; pcolor(XC/1000,z,Qneg60'*g/rho_o*1000);
    shading flat; colorbar; caxis([-3e-10 1e-8]);
    h=colorbar; colormap(h2,'bluewhitered'); title(h,'1/s^3');
    hold on
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Ertel PV (\boldmath$q$)}','Interpreter','latex','Fontsize',12);
    ylim([-2500 0]); xlim([0 75]); box on; 
    set(gca,'xticklabel',[]); %set(gca,'yticklabel',[]);
    %pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'f','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top')
h3=axes('Position',[0.1 0.62 0.3 0.16]);
    pcolor(XC/1000,z,(totalevolutionearly')); shading flat;
    caxis([-1e-14 1e-14]);
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; colormap(h3,'bluewhitered'); title(h,'1/s^4')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Time change \boldmath$\partial q/\partial t$}','Interpreter','latex','Fontsize',12);
    ylim([-2500 0]); xlim([0 50]); box on; 
    set(gca,'xticklabel',[]); 
    %pbaspect([1.0 0.8846 .8846]);
    set(gca,'Layer','top')
    text(0.02,0.98,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%

h4=axes('Position',[0.5250 0.62 0.3 0.16])
    pcolor(XC/1000,z,(totalevolutionlate')); shading flat;
    caxis([-1e-14 1e-14]);
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; colormap(h4,'bluewhitered'); title(h,'1/s^4')
    set(gca,'Fontsize',12)
    %ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Time change \boldmath$\partial q/\partial t$}','Interpreter','latex','Fontsize',12);
    ylim([-2500 0]); xlim([0 75]); box on;    
     set(gca,'xticklabel',[]); %set(gca,'yticklabel',[]);
    % pbaspect([1 0.8846 .8846]);
     text(0.02,0.98,'g','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top');
%     
h5=axes('Position',[0.1 0.43 0.3 0.16]);
    pcolor(XC/1000,z,(evolution3_175')); shading flat;
    caxis([-1e-15 0e-15]);
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; colormap(h5,'bluewhitered'); title(h,'1/s^4')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Forcing: \boldmath$\nabla\cdot(\omega_aDb/Dt)$}','Interpreter','latex','Fontsize',12);
    ylim([-500 0]); xlim([0 50]); box on; set(gca,'Layer','top');
    set(gca,'xticklabel',[]); 
    %pbaspect([1.0 0.8846 .8846]);
    text(0.02,0.98,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%

h6=axes('Position',[0.5250 0.43 0.3 0.16])
    pcolor(XC/1000,z,(evolution3_175')); shading flat;
    caxis([-1e-15 0e-15]);
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; colormap(h6,'bluewhitered'); title(h,'1/s^4')
    set(gca,'Fontsize',12)
    %ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Forcing: \boldmath$\nabla\cdot(\omega_aDb/Dt)$}','Interpreter','latex','Fontsize',12);
    ylim([-500 0]); xlim([0 75]); box on; set(gca,'Layer','top');
     set(gca,'xticklabel',[]); %set(gca,'yticklabel',[]);
    % pbaspect([1 0.8846 .8846]);
     text(0.02,0.98,'h','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on;
h7=axes('Position',[0.1 0.24 0.3 0.16]);
    pcolor(XC/1000,z,(evolution2_175')); shading flat;
    caxis([-1e-15 0e-15]);
    colormap(h7,'bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'1/s^4')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Friction: \boldmath$\nabla\cdot(F\wedge\nabla b)$}','Interpreter','latex','Fontsize',12);
    ylim([-2500 0]); xlim([0 50]); box on; set(gca,'Layer','top');
    set(gca,'xticklabel',[]); 
    text(0.02,0.98,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    
h8=axes('Position',[0.5250 0.24 0.3 0.16]);
pcolor(XC/1000,z,(evolution2_60')); shading flat;
    caxis([-1e-15 0e-15]);
    colormap(h8,bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'1/s^4')
    set(gca,'Fontsize',12)
    %xlabel('X Position (km)','Fontsize',14)
    %ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Friction: \boldmath$\nabla\cdot(F\wedge\nabla b)$}','Interpreter','latex','Fontsize',12);
    ylim([-2500 0]); xlim([0 75]); box on; set(gca,'Layer','top');
    set(gca,'xticklabel',[]); %set(gca,'yticklabel',[]);
    text(0.02,0.98,'i','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%

h9=axes('Position',[0.1 0.05 0.3 0.16]);
    pcolor(XC/1000,z,(evolution1_175')); shading flat;
    caxis([-1e-15 0e-15]);
    colormap(h9,bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'1/s^4')
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Advection: \boldmath$-\nabla\cdot(\vec{u}q)$}','Interpreter','latex','Fontsize',12);
    ylim([-2500 0]); xlim([0 50]); box on;
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'e','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
    box on; set(gca,'Layer','top');
%     
h10=axes('Position',[0.5250 0.05 0.3 0.16]);
    pcolor(XC/1000,z,(evolution1_60')); shading flat;
    caxis([-1e-15 0e-15]);
    colormap(h10,bluewhitered)
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    h = colorbar; title(h,'1/s^4')
    set(gca,'Fontsize',12)
    xlabel('X position (km)','Fontsize',14)
    %set(gca,'yticklabel',[]);
    %ylabel('Depth (m)','Fontsize',14)
    title('\textbf{Advection: \boldmath$-\nabla\cdot(\vec{u}q)$}','Interpreter','latex','Fontsize',12);
    ylim([-2500 0]); xlim([0 75]); box on;
    pbaspect([1 0.8846 .8846]);
    text(0.02,0.98,'j','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
box on; set(gca,'Layer','top');
set(gcf,'Color','w'); set(gca,'Layer','top');

%print(gcf,'fig7.jpg','-djpeg','-r300')




