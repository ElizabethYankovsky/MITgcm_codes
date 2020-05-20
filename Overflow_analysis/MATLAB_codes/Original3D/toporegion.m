clear all
close all
load XC.mat
load z.mat
XC=XC/1000;
cd Originalinput
fid1= fopen('topog.slope','r','b');
topo=fread(fid1,'real*8');
topo = reshape(topo,[640 900]);
topo = sq(topo(:,10)); topo(1)=0;
cd ..

figure(1)
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
ylim([-2500 0])
xlim([0 75])
hold on
plot(z*0,z,'r','Linewidth',1.5)
plot(z*0+XC(170),z,'r','Linewidth',1.5)
plot(z*0+XC(500),z,'r','Linewidth',1.5)
area(XC(626:640),zeros(15),-2500,'Facecolor',[.9 .65 .65]);
text(XC(28),z(20),'Region 1','Fontsize',13,'Color','r');
text(XC(280),z(20),'Region 2','Fontsize',13,'Color','r');
%plot(z*0+XC(600),z,'r','Linewidth',1.5)

title('Topography and domain regions');
ylabel('Depth (m)');
xlabel('X Position (km)');

figure(2)
area(XC,topo,-2500,'Facecolor',[.8 .8 .8]);
ylim([-2500 0])
xlim([0 75])
hold on
area(XC(1:200),0*XC(1:200)-2500,0,'Facecolor',[0.9 0 0],'Facealpha',0.2);
plot(z*0+XC(200),z,'r','Linewidth',1.5)
plot(z*0+XC(200),z,'r','Linewidth',1.5)
