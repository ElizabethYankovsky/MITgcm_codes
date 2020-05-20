clear all
close all
load z.mat; z=z-z(1);
load topo.mat

YC = 111.111:111.111:99999.9; 
%Plotting x coordinate
XC=ncread('Original1.nc','X');

for i =240
    if i>=1 && i<=40
%         S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
%         T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
%         U=sq(ncread('Original1.nc','U',[1 1 1 i],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
%         S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
%         T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
%         U=sq(ncread('Original2.nc','U',[1 1 1 i-40],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));        
    elseif i>=81 && i<=120
%         S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
%         T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
%         U=sq(ncread('Original3.nc','U',[1 1 1 i-80],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));       
    elseif i>=121 && i<=160
%         S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
%         T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
%         U=sq(ncread('Original4.nc','U',[1 1 1 i-120],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=201
%         S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
%         T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
%         U=sq(ncread('Original5.nc','U',[1 1 1 i-160],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));        
    elseif i>=201 && i<=240
%         S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
%         T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
%         U=sq(ncread('Original6.nc','U',[1 1 1 i-200],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));       
    end
     
    a = sq(nanmean(Tracer,2));
    figure(1)
    pcolor(XC,z,a'); shading flat;
    xlabel('X Position (m)');
    ylabel('Depth (m)');
    caxis([0 1]); colorbar;
    colormap bluewhitered
    %xlim([0 75000]);
    hold on;
    area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
    set(gcf,'Color','w')
   % mymovie1(i)=getframe(gcf);
   % clf
    i
end
%movie2avi(mymovie1,'movie1')





















