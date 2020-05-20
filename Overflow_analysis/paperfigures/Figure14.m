clear all
close all
load z.mat
load topo.mat
topo=-topo;
load XC.mat
load xcarray; load signalV120; load signalW120; load signalU120;
load bins;

figure(101)
ha=tight_subplot(4,2,0.03,0.05,0.085)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*1.7 pos(4)*2.6])

axes(ha(1))
%U SPEC
load day5U.mat; load day10U.mat; 
load day18U.mat; load day20U.mat; load day30U.mat; load day60U.mat;
loglog(1./bins(1:1400),(day5U),'Color',[0 0 .5],'Linewidth',2);
set(gca,'Fontsize',12);
%xlabel('Wavelength, m','Fontsize',14); 
set(ha(1),'xticklabel',[])
ylabel('Spectral energy [m^3s^{-2}]','Fontsize',14);
%title('U velocity spectrum'); 
set(gca,'XDir','reverse'); grid on;
hold on
loglog(1./bins(1:1400),(day10U),'Color',[0 .5 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day18U),'Color',[1 .65 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day20U),'Color',[1 0 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day30U),'Color',[0.5 0 0.5],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day60U),'Color',[0 0.5 .8],'Linewidth',2);
%legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Fontsize',10);
ylim([1e-17 1e0]); box on;
text(0.9,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
ylim([1e-17 1e0]); box on;

axes(ha(3))
%V SPEC
load day5V.mat; load day10V.mat; 
load day18V.mat; load day20V.mat; load day30V.mat; load day60V.mat;
loglog(1./bins(1:1400),(day5V),'Color',[0 0 .5],'Linewidth',2);
set(gca,'Fontsize',12);
%xlabel('Wavelength, m','Fontsize',14); 
set(ha(3),'xticklabel',[])
ylabel('Spectral energy [m^3s^{-2}]','Fontsize',14);
%title('V velocity spectrum'); 
set(gca,'XDir','reverse'); grid on;
hold on
loglog(1./bins(1:1400),(day10V),'Color',[0 .5 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day18V),'Color',[1 .65 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day20V),'Color',[1 0 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day30V),'Color',[0.5 0 0.5],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day60V),'Color',[0 0.5 .8],'Linewidth',2);
%legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Fontsize',10);
ylim([1e-17 1e0]); box on
text(0.9,0.98,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%


axes(ha(5))
%W SPEC
load day5W.mat; load day10W.mat; 
load day18W.mat; load day20W.mat; load day30W.mat; load day60W.mat;
loglog(1./bins(1:1400),(day5W),'Color',[0 0 .5],'Linewidth',2);
set(gca,'Fontsize',12);
%xlabel('Wavelength, m','Fontsize',14); 
set(ha(5),'xticklabel',[])
ylabel('Spectral energy [m^3s^{-2}]','Fontsize',14);
%title('W velocity spectrum'); 
set(gca,'XDir','reverse'); grid on;
hold on
loglog(1./bins(1:1400),(day10W),'Color',[0 .5 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day18W),'Color',[1 .65 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day20W),'Color',[1 0 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day30W),'Color',[0.5 0 0.5],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day60W),'Color',[0 0.5 .8],'Linewidth',2);
%legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Fontsize',10);
ylim([1e-17 1e0]); box on
text(0.9,0.98,'e','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%


axes(ha(7))
%TOTAL SPEC
load day5T.mat; load day10T.mat; 
load day18T.mat; load day20T.mat; load day30T.mat; load day60T.mat;
loglog(1./bins(1:1400),(day5T),'Color',[0 0 .5],'Linewidth',2);
set(gca,'Fontsize',12);
xlabel('Wavelength, m','Fontsize',14); ylabel('Spectral energy [m^3s^{-2}]','Fontsize',14);
%title('Total velocity spectrum'); 
set(gca,'XDir','reverse'); grid on;
hold on
loglog(1./bins(1:1400),(day10T),'Color',[0 .5 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day18T),'Color',[1 .65 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day20T),'Color',[1 0 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day30T),'Color',[0.5 0 0.5],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day60T),'Color',[0 0.5 .8],'Linewidth',2);
legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Location','Southwest');
ylim([1e-17 1e0]);
text(0.9,0.98,'g','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
ylim([1e-17 1e0]); box on;

axes(ha(2))
%U Velocity
pcolor(xcarray/1000,(111.111:111.111:99999.9)/1000,signalU120); shading flat; 
caxis([-0.1 0.1]); colormap(ha(2),bluewhitered); 
ylabel('Y position (km)','Fontsize',14); 
set(ha(2),'xticklabel',[])
title('Offshore velocity (U)'); colorbar; box on;
pbaspect([1 0.8846 .8846]); 
text(0.02,0.98,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
h = colorbar; title(h,'m/s');
set(gca,'Layer','top')

axes(ha(4))
%V Velocity
pcolor(xcarray/1000,(111.111:111.111:99999.9)/1000,signalV120); shading flat; 
caxis([-0.1 0.1]); colormap(ha(4),bluewhitered); 
ylabel('Y position (km)','Fontsize',14);
set(ha(4),'xticklabel',[])
title('Alongshore velocity (V)'); colorbar; box on;
pbaspect([1 0.8846 .8846]);
text(0.02,0.98,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
h = colorbar; title(h,'m/s');
set(gca,'Layer','top')

axes(ha(6))
%W Velocity
pcolor(xcarray/1000,(111.111:111.111:99999.9)/1000,signalW120); shading flat; 
caxis([-0.01 0.01]); colormap(ha(6),bluewhitered); 
ylabel('Y position (km)','Fontsize',14);
set(ha(6),'xticklabel',[])
title('Vertical velocity (W)'); colorbar; box on;
pbaspect([1 0.8846 .8846]); 
text(0.02,0.98,'f','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
h = colorbar; title(h,'m/s');
set(gca,'Layer','top')

axes(ha(8))
%Total Velocity
pcolor(xcarray/1000,(111.111:111.111:99999.9)/1000,signal120); shading flat; 
caxis([0 0.5]); colormap(ha(8),bluewhitered); 
xlabel('X position (km)','Fontsize',14); ylabel('Y position (km)','Fontsize',14);
title('Total velocity magnitude'); colorbar; box on;
pbaspect([1 0.8846 .8846]); 
text(0.02,0.98,'h','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
h = colorbar; title(h,'m/s');
%print(gcf,'fig14.jpg','-djpeg','-r300')
set(gca,'Layer','top')


