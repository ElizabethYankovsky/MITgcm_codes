clear all
close all
load xcarray.mat
load zarray.mat
load U.mat; load V.mat; load W.mat;
load topo.mat; load a.mat; load b.mat;

figure(101)
ha=tight_subplot(2,2,0.07,0.10,0.085)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*1.7 pos(4)*1.3])

axes(ha(1))
load bins.mat
load day5.mat; load day10.mat; 
load day18.mat; load day20.mat; load day30.mat; load day60.mat;
loglog(1./bins(1:470),(day5),'Color',[0 0 .5],'Linewidth',2);
set(gca,'Fontsize',12);
%xlabel('Wavelength, m','Fontsize',14);
set(ha(1),'xticklabel',[])
ylabel('Spectral energy [m^3s^{-2}]','Fontsize',14);
%title('(U^2+W^2)^{1/2} spectrum'); 
set(gca,'XDir','reverse'); grid on;
hold on
loglog(1./bins(1:470),(day10),'Color',[0 .5 0],'Linewidth',2);
loglog(1./bins(1:470),smooth(day18),'Color',[1 .65 0],'Linewidth',2);
loglog(1./bins(1:470),smooth(day20),'Color',[1 0 0],'Linewidth',2);
loglog(1./bins(1:470),smooth(day30),'Color',[0.5 0 0.5],'Linewidth',2);
loglog(1./bins(1:470),smooth(day60),'Color',[0 0.5 .8],'Linewidth',2);
%legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Fontsize',10,'Location','Southwest');
ylim([1e-15 1e0]);
%pbaspect([1 .7 .7])
box on
text(0.9,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%

axes(ha(2))
pcolor(xcarray/1000,zarray,sqrt(U.^2+W.^2)'); shading flat
caxis([0 0.01]); 
colorbar;
colormap(ha(2),bluewhitered);
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
h = colorbar; title(h,'m/s');
set(gca,'Fontsize',12)
%xlabel('X Position (km)','Fontsize',14)
set(ha(2),'xticklabel',[])
ylabel('Depth (m)','Fontsize',14)
title('(U^2+W^2)^{1/2}','Fontsize',14);
ylim([-2500 0]); xlim([0 75]);
line(a,b,'Linewidth',2,'Color','k')
pbaspect([1 0.8846 .8846]); 
box on
text(0.02,0.98,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')

axes(ha(3))
load day5T.mat; load day10T.mat; 
load day18T.mat; load day20T.mat; load day30T.mat; load day60T.mat;
loglog(1./bins(1:470),(day5T),'Color',[0 0 .5],'Linewidth',2);
set(gca,'Fontsize',12);
xlabel('Wavelength, m','Fontsize',14); 
ylabel('Spectral energy [m^3s^{-2}]','Fontsize',14);
%set(ha(3),'yticklabel',[])
%title('Total velocity spectrum'); 
set(gca,'XDir','reverse'); grid on;
hold on
loglog(1./bins(1:470),(day10T),'Color',[0 .5 0],'Linewidth',2);
loglog(1./bins(1:470),smooth(day18T),'Color',[1 .65 0],'Linewidth',2);
loglog(1./bins(1:470),smooth(day20T),'Color',[1 0 0],'Linewidth',2);
loglog(1./bins(1:470),smooth(day30T),'Color',[0.5 0 0.5],'Linewidth',2);
loglog(1./bins(1:470),smooth(day60T),'Color',[0 0.5 .8],'Linewidth',2);
legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Fontsize',10,'Location','Southwest');
ylim([1e-15 1e0]); 
box on
%pbaspect([1 .7 .7])
text(0.9,0.98,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%

axes(ha(4))
pcolor(xcarray/1000,zarray,sqrt(U.^2+W.^2+V.^2)'); shading flat
caxis([0 1]); 
colorbar;
colormap(ha(4),bluewhitered);
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
h = colorbar; title(h,'m/s');
set(gca,'Fontsize',12)
xlabel('X position (km)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14)
%set(ha(4),'yticklabel',[]);
title('Total velocity magnitude','Fontsize',14);
ylim([-2500 0]); xlim([0 75]);
line(a,b,'Linewidth',2,'Color','k')
pbaspect([1 0.8846 .8846]); 
box on
text(0.02,0.98,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
set(gca,'Layer','top')
%print(gcf,'fig13.jpg','-djpeg','-r500')

