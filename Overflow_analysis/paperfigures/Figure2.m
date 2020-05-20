clear all
close all

load densityanomaly_original.mat %nonrotating case
load densityanomaly_2Df.mat
load densityanomaly3D.mat
load tracer60.mat %AT DAY 20 ACTUALLY
load U60.mat %AT DAY 20 ACTUALLY
load XC.mat
load z.mat
load topo.mat

time  = linspace((5/3)/24,20,288);
seconds = linspace(6000,1728000,288);
H = 40;
Forcing_original = (3.41*10^-5)*seconds/H;


figure('Position',[514 667 650 600])


axes('Position',[.13 .1 .715 .4])
plot(time,densityanomaly_original,'color',[0 0.78 0.55],'Linewidth',1.5); hold on;
plot(linspace(0,60,240),densityanomaly_2Df,'color',[255 83 73]/255,'Linewidth',1.5); hold on;

plot(linspace(0,60,240),densityanomaly3D,'Color',[0 0 0.5],'Linewidth',1.5)

plot(time,Forcing_original,'--k','Linewidth',1.5); grid on;
plot(time,densityanomaly_original,'color',[0 0.78 0.55],'Linewidth',1.5); hold on;
ylim([0 1]); legend('Nonrotating, 2D','Rotating, 2D','Rotating, 3D','Value of Qt/H')
set(gca,'Fontsize',12); 
xlabel('Time (days)','Fontsize',14); 
ylabel('Density anomaly (kg/m^3)','Fontsize',14)
text(0.02,0.98,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
xlim([0 30])

ha2=axes('Position',[.13 .62 .4 .30])
%pbaspect([1 0.8846 .8846]); 
hold on; set(gca,'Fontsize',12);
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
xlim([0 75]); ylim([-2500 0]);
xlabel('X position (km)','Fontsize',14); ylabel('Depth (m)');
pcolor(XC/1000,z,tracer60); shading flat
colorbar; caxis([0 1]); colormap(ha2,'bluewhitered');
box on; set(gca,'Layer','top');
text(0.02,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%

ha3=axes('Position',[.55 .62 .4 .30])
%pbaspect([1 0.8846 .8846]); 
hold on; set(gca,'Fontsize',12)
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
xlim([0 75]); ylim([-2500 0]);
xlabel('X position (km)','Fontsize',14); set(ha3,'ytick',[]);
pcolor(XC/1000,z,U60); shading flat;
set(gca,'Layer','top');
h=colorbar; caxis([-.06 0.06]); colormap(ha3,'bluewhitered'); title(h,'m/s')
box on
text(0.02,0.98,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)%
%print(gcf,'fig2.jpg','-djpeg','-r500')

