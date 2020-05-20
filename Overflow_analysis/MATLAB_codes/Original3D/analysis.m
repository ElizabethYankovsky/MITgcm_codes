clear all
close all
load z.mat
load topo.mat
topo=topo;
load XC.mat

%Initial Conditions
cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit = reshape(Tinit,[640 900 120]);
Tinit = sq(Tinit(:,1,:));

fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit = reshape(Sinit,[640 900 120]);
Sinit = sq(Sinit(:,1,:));
cd ..
densityinit = densmdjwf(Sinit,Tinit,0);
% V velocity
for i = 120;
    index=450;
    if i>=1 && i<=40
%         S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
%         T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
          U=sq(ncread('Original1.nc','U',[2 index 1 i],[Inf 1 Inf 1]));
          V=sq(ncread('Original1.nc','V',[1 index 1 i],[Inf 1 Inf 1]));
          Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 index 1 i],[Inf 1 Inf 1]));
          W=sq(ncread('Original1.nc','W',[1 index 1 i],[Inf 1 Inf 1]));
    elseif i>=41 && i<=80
 %         S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
 %         T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
          U=sq(ncread('Original2.nc','U',[2 index 1 i-40],[Inf 1 Inf 1]));
          V=sq(ncread('Original2.nc','V',[1 index 1 i-40],[Inf 1 Inf 1]));
          Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 index 1 i-40],[Inf 1 Inf 1]));
          W=sq(ncread('Original2.nc','W',[1 index 1 i-40],[Inf 1 Inf 1]));
    elseif i>=81 && i<=120
        %  S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        %  T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
          U=sq(ncread('Original3.nc','U',[2 index 1 i-80],[Inf 1 Inf 1]));
          V=sq(ncread('Original3.nc','V',[1 index 1 i-80],[Inf 1 Inf 1]));
          Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 index 1 i-80],[Inf 1 Inf 1])); 
          W=sq(ncread('Original3.nc','W',[1 index 1 i-80],[Inf 1 Inf 1]));
    elseif i>=121 && i<=160
%          S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
%          T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
          U=sq(ncread('Original4.nc','U',[2 index 1 i-120],[Inf 1 Inf 1]));
          V=sq(ncread('Original4.nc','V',[1 index 1 i-120],[Inf 1 Inf 1]));
          Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 index 1 i-120],[Inf 1 Inf 1]));
          W=sq(ncread('Original4.nc','W',[1 index 1 i-120],[Inf 1 Inf 1]));
    elseif i>=161 && i<=201
%          S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
%          T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
          U=sq(ncread('Original5.nc','U',[2 index 1 i-160],[Inf 1 Inf 1]));
          V=sq(ncread('Original5.nc','V',[1 index 1 i-160],[Inf 1 Inf 1]));
          Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 index 1 i-160],[Inf 1 Inf 1])); 
          W=sq(ncread('Original5.nc','W',[1 index 1 i-160],[Inf 1 Inf 1]));
    elseif i>=201 && i<=240
%         S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
%         T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
          U=sq(ncread('Original6.nc','U',[2 index 1 i-200],[Inf 1 Inf 1]));
          V=sq(ncread('Original6.nc','V',[1 index 1 i-200],[Inf 1 Inf 1]));
          Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 index 1 i-200],[Inf 1 Inf 1]));      
          W=sq(ncread('Original6.nc','W',[1 index 1 i-200],[Inf 1 Inf 1]));
    end
    figure(1)
    pcolor(XC/1000,z,V'); shading flat
    caxis([-0.2 1]); colorbar;
    colormap('bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    title('V (m/s)'); xlim([0 75]); ylim([-2500 0]);
    %set(gcf,'color','w');
    %mymovie1(i)=getframe(gcf);
    %clf
    
    figure(2)
    pcolor(XC/1000,z,Tracer'); shading flat
    caxis([0 1]); colorbar;
    colormap('bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    title('Tracer Value'); xlim([0 75]); ylim([-2500 0]);
   % set(gcf,'color','w')
    %mymovie2(i)=getframe(gcf);
    %clf
    figure(3)
    pcolor(XC/1000,z,W'); shading flat
    caxis([-0.01 0.01]); colorbar;
    colormap('bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    title('W (m/s)'); xlim([0 75]); ylim([-2500 0]);
    %set(gcf,'Color','w')
    %mymovie3(i)=getframe(gcf);
   % clf
    figure(4)
    pcolor(XC/1000,z,U'); shading flat
    caxis([-.06 0.06]); colorbar;
    colormap('bluewhitered')
    hold on;
    area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
    title('U (m/s)'); xlim([0 75]); ylim([-2500 0]);
    %set(gcf,'color','w')
    %mymovie4(i)=getframe(gcf);
    %clf
    i
end





