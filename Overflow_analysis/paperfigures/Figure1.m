clear all
close all
load z.mat; z=z-z(1);
load topo.mat; topo=repmat(topo,1,900);
load YC.mat
load XC.mat



load Z2D.mat
load Sref.mat
load Tref.mat
load Densityref.mat

figure(1)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*2 pos(4)])
subplot(1,2,2)
set(gca,'Fontsize',12)
hl1=plot(Tref,Z2D,'b-','Linewidth',2); hold on
xlim([-1 0.5])
ax1=gca; 
set(ax1,'XMinorTick','off','box','on','xcolor',get(hl1,'color'));
xlabel('Potential temperature (^{\circ}C)');
ax1.YAxis.FontSize=12; 
ax1.YGrid = 'on'; grid on;
ylabel('Depth (m)','Fontsize',14); 
text(0.02,0.98,'b','Units', 'Normalized', 'VerticalAlignment', 'Top','Fontsize',20)
[hl2,ax2,ax3]=floatAxisX(Sref,Z2D,'r','Salinity (psu)',[34.4 35 -2500 0]);
[h13,ax4,ax5]=floatAxisX(Densityref,Z2D,'k','Potential density (kg/m^3)');


%figure(2)
subplot(1,2,1);
    meshz(XC/1000,YC/1000,topo')
    set(gca,'Fontsize',12); xlabel('X position (km)','Fontsize',14)
    ylabel('Y position (km)','Fontsize',14); 
    zlabel('Depth (m)','Fontsize',14); 
    view(50,30)
    set(gca,'Color',[150/255 177/255 210/255])
    load brown.mat; colormap(brown)
 xlim([0 75]); 
 	set(get(gca,'xlabel'),'rotation', -30);
	set(get(gca,'ylabel'),'rotation',  20);
grid on
set(gcf,'InvertHardCopy','off')
set(gcf,'Color','w')
text(0.02,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
%
%print(gcf,'fig1.jpg','-djpeg','-r500')