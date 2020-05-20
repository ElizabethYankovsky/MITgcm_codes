clear all
close all
load z.mat; z=z-z(1);
load topo.mat
topo=repmat(topo,1,900);
YC = 111.111:111.111:99999.9; 
%Plotting x coordinate
XC=ncread('Original1.nc','X');


for i =240
    if i>=1 && i<=40
        Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));        
    elseif i>=81 && i<=120
        Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));       
    elseif i>=121 && i<=160
        Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=201
        Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));        
    elseif i>=201 && i<=240
        Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));       
    end
    figure(101)
    meshz(XC/1000,YC/1000,topo')
    set(gca,'Fontsize',10); xlabel('X position (km)','Fontsize',10)
    ylabel('Y position (km)','Fontsize',10); 
    zlabel('Depth, (m)','Fontsize',10); %title('Topography','Fontsize',10)
    view(50,30)
    %view(25,10);
    set(gca,'Color',[0.75 0.9 1])
    load brown.mat; colormap(brown)
    hold on
    Tracer=permute(Tracer,[2 1 3]);
    p=patch(isosurface(XC/1000,YC/1000,z,Tracer,0.3));
    isonormals(XC/1000,YC/1000,z,Tracer,p)
    set(p,'Facecolor','r','EdgeColor','none');
    camlight 
    lighting flat 
    set(gcf,'Color','w')
    xlim([0 75]); 
    drawnow
    %mymovie1(i)=getframe(gcf);
    %clf
    i


end  
































