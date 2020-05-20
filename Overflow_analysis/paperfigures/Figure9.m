clear all
close all
load XC.mat; load YC.mat; load z.mat; load topo.mat;
load XC1.mat; load YC1.mat; load z1.mat;
load brown.mat; load QOG.mat; load TracerOG.mat; load Tracereighth.mat;
load Qeighth.mat
figure(101)
%GAP MARGIN HEIGHT MARGIN WIDTH
ha=tight_subplot(2,2,0.08,0.06,0.1)
pos = get(gcf, 'Position'); %width=pos(3) height=pos(4);
set(gcf,'Position',[pos(1) pos(2) pos(3)*1.5 pos(4)*1.5])

%Tracer for original
axes(ha(1));
    meshz(XC1/1000,YC1/1000,topo')
    set(gca,'Fontsize',12); xlabel('X position (km)','Fontsize',12)
    ylabel('Y position (km)','Fontsize',12); 
    zlabel('Depth (m)','Fontsize',12); %title('Topography','Fontsize',10)
    view(50,30)
    %view(25,10);
    set(gca,'Color',[150/255 177/255 210/255])
    set(get(gca,'xlabel'),'rotation', -30);
	set(get(gca,'ylabel'),'rotation',  20);
    grid on
    set(gcf,'InvertHardCopy','off')
    set(gcf,'Color','w')
    text(0.02,0.98,'a','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)
    colormap(brown)
    hold on
    %TracerOG=permute(TracerOG,[2 1 3]);
    p=patch(isosurface(XC1/1000,YC1/1000,z1,TracerOG,0.3));
    isonormals(XC1/1000,YC1/1000,z1,TracerOG,p)
    set(p,'Facecolor','r','EdgeColor','none');
    camlight;  lighting flat 
    set(gcf,'Color','w')
    xlim([0 75]); zlim([-2500 0]);
    
%Tracer for eighth
axes(ha(2))
 meshz(XC1/1000,YC1/1000,topo')
    set(gca,'Fontsize',12); %xlabel('X position (km)','Fontsize',12)
    %ylabel('Y position (km)','Fontsize',12); 
   % zlabel('Depth, (m)','Fontsize',12); %title('Topography','Fontsize',10)
    view(50,30);
    set(gca,'Color',[150/255 177/255 210/255])
    set(get(gca,'xlabel'),'rotation', -30);
	set(get(gca,'ylabel'),'rotation',  20);
    grid on
    set(gcf,'InvertHardCopy','off')
    set(gcf,'Color','w')
    text(0.02,0.98,'b','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)
    colormap(brown)
    hold on
   % Tracereighth=permute(Tracereighth,[2 1 3]);
    p=patch(isosurface(XC1/1000,YC1/1000,z1,Tracereighth,0.25));
    isonormals(XC1/1000,YC1/1000,z1,Tracereighth,p)
    set(p,'Facecolor','r','EdgeColor','none');
    camlight 
    lighting flat 
    set(gcf,'Color','w')
    xlim([0 75]); zlim([-2500 0]);
    drawnow

axes(ha(3)) 
%PV for original forcing
    meshz(XC/1000,YC/1000,topo')
    set(gca,'Fontsize',12); xlabel('X position (km)','Fontsize',12)
    ylabel('Y position (km)','Fontsize',12)
    zlabel('Depth (m)','Fontsize',12); 
    view(50,30); %original previously(50,30)
    set(gca,'Color',[150/255 177/255 210/255])
    set(get(gca,'xlabel'),'rotation', -30);
	set(get(gca,'ylabel'),'rotation',  20);
    grid on
    set(gcf,'InvertHardCopy','off')
    set(gcf,'Color','w')
    text(0.02,0.98,'c','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)
    colormap(brown);
    
    hold on
    QOG(QOG<0)=-100;
    variable = permute(QOG,[2 1 3]);
    p =patch(isosurface(XC(1:639)/1000,YC(1:899)/1000,z(1:119),variable,-100));
    isonormals(XC(1:639)/1000,YC(1:899)/1000,z(1:119),variable,p)
    set(p,'Facecolor','b','EdgeColor','none');
    camlight; lighting flat; set(gcf,'Color','w'); xlim([0 75]); zlim([-2500 0]);
    
axes(ha(4))
%PV FOR eighth
    meshz(XC/1000,YC/1000,topo')
    set(gca,'Fontsize',12); %xlabel('X position (km)','Fontsize',12)
    %ylabel('Y position (km)','Fontsize',12)
    %zlabel('Depth, (m)','Fontsize',12); 
    view(50,30); %original previously(50,30) and for movies use 25,10
    set(gca,'Color',[150/255 177/255 210/255])
    set(get(gca,'xlabel'),'rotation', -30);
	set(get(gca,'ylabel'),'rotation',  20);
    grid on
    set(gcf,'InvertHardCopy','off')
    set(gcf,'Color','w')
    text(0.02,0.98,'d','Units', 'Normalized', 'VerticalAlignment','Top','Fontsize',20)
     colormap(brown);
    hold on
    Qeighth(Qeighth<0)=-100;
    variable1 = permute(Qeighth,[2 1 3]);
    p =patch(isosurface(XC(1:639)/1000,YC(1:899)/1000,z(1:119),variable1,-100));
    isonormals(XC(1:639)/1000,YC(1:899)/1000,z(1:119),variable1,p)
    set(p,'Facecolor','b','EdgeColor','none');
    camlight; lighting flat; set(gcf,'Color','w'); xlim([0 75]); zlim([-2500 0]);
    drawnow
    
    
%print(gcf,'fig9.jpg','-djpeg','-r500')
    
    
    
    
    
    
    
    
    
    
    
    
  