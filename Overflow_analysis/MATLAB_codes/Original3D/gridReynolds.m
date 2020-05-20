clear all
close all
load dz.mat
load dx.mat
vertical = repmat(dz,1,900,640);
vertical = permute(vertical,[3 2 1]);
horizontalx = repmat(dx,1,900,120);
horizontaly = repmat(111.111,640,900,120);


for i =200;
    if i>=1 && i<=40
%         S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
%         T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
          U=sq(ncread('Original1.nc','U',[1 1 1 i],[640 900 120 1]));
          V=sq(ncread('Original1.nc','V',[1 1 1 i],[640 900 120 1]));
%         Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
          W=sq(ncread('Original1.nc','W',[1 1 1 i],[640 900 120 1]));
    elseif i>=41 && i<=80
 %         S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
 %         T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
          U=sq(ncread('Original2.nc','U',[1 1 1 i-40],[640 900 120 1]));
          V=sq(ncread('Original2.nc','V',[1 1 1 i-40],[640 900 120 1]));
%         Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));
          W=sq(ncread('Original2.nc','W',[1 1 1 i-40],[640 900 120 1]));
    elseif i>=81 && i<=120
        %  S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        %  T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
          U=sq(ncread('Original3.nc','U',[1 1 1 i-80],[640 900 120 1]));
          V=sq(ncread('Original3.nc','V',[1 1 1 i-80],[640 900 120 1]));
%         Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1])); 
          W=sq(ncread('Original3.nc','W',[1 1 1 i-80],[640 900 120 1]));
    elseif i>=121 && i<=160
%          S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
%          T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
          U=sq(ncread('Original4.nc','U',[1 1 1 i-120],[640 900 120 1]));
          V=sq(ncread('Original4.nc','V',[1 1 1 i-120],[640 900 120 1]));
%         Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
          W=sq(ncread('Original4.nc','W',[1 1 1 i-120],[640 900 120 1]));
    elseif i>=161 && i<=201
%          S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
%          T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
          U=sq(ncread('Original5.nc','U',[1 1 1 i-160],[640 900 120 1]));
          V=sq(ncread('Original5.nc','V',[1 1 1 i-160],[640 900 120 1]));
%         Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1])); 
          W=sq(ncread('Original5.nc','W',[1 1 1 i-160],[640 900 120 1]));
    elseif i>=201 && i<=240
%         S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
%         T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
          U=sq(ncread('Original6.nc','U',[1 1 1 i-200],[640 900 120 1]));
          V=sq(ncread('Original6.nc','V',[1 1 1 i-200],[640 900 120 1]));
%         Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));      
          W=sq(ncread('Original6.nc','W',[1 1 1 i-200],[640 900 120 1]));
    end
     
    Viscosityz = abs(W.*vertical/.10);
    Viscosityx = abs(U.*horizontalx/10);
    Viscosityy = abs(V.*horizontaly/10);
    
    Rez = abs(W.*vertical/.01);
    Rex = abs(U.*horizontalx/2.5);
    Rey = abs(V.*horizontaly/2.5);
    i
end  

j=500;
load XC.mat
load z.mat
load topo.mat
% figure(1)
% area(XC,topo,-2500,'Facecolor',[.8 .8 .8]);
% hold on
% pcolor(XC,z,(sq(Viscosityz(:,j,:))'));
% shading flat;
% c=colorbar; 
% xlabel('X Position (m)'); ylabel('Depth (m)');
% title('Z Minimum viscosity (m^2/s) so that Re_{gz}<=2');
% xlim([0 75000]); ylim([-2500 0]);
% 
% figure(2)
% area(XC,topo,-2500,'Facecolor',[.8 .8 .8]);
% hold on
% pcolor(XC,z,(sq(Viscosityx(:,j,:))'));
% shading flat;
% c=colorbar; 
% xlabel('X Position (m)'); ylabel('Depth (m)');
% title('X Minimum viscosity (m^2/s) so that Re_{gx}<=2');
% xlim([0 75000]); ylim([-2500 0]);
% 
% figure(3)
% area(XC,topo,-2500,'Facecolor',[.8 .8 .8]);
% hold on
% pcolor(XC,z,(sq(Viscosityy(:,j,:))'));
% shading flat;
% c=colorbar; 
% xlabel('X Position (m)'); ylabel('Depth (m)');
% title('Y Minimum viscosity (m^2/s) so that Re_{gy}<=2');
% xlim([0 75000]); ylim([-2500 0]);

figure(4)
area(XC,topo,-2500,'Facecolor',[.8 .8 .8]);
hold on
pcolor(XC,z,(sq(Rez(:,j,:))'));
shading flat;
c=colorbar; 
xlabel('X Position (m)'); ylabel('Depth (m)');
title('Grid Reynolds Number in z');
xlim([0 75000]); ylim([-2500 0]);

figure(5)
area(XC,topo,-2500,'Facecolor',[.8 .8 .8]);
hold on
pcolor(XC,z,(sq(Rex(:,j,:))'));
shading flat;
c=colorbar; 
xlabel('X Position (m)'); ylabel('Depth (m)');
title('Grid Reynolds Number in x');
xlim([0 75000]); ylim([-2500 0]);

figure(6)
area(XC,topo,-2500,'Facecolor',[.8 .8 .8]);
hold on
pcolor(XC,z,(sq(Rey(:,j,:))'));
shading flat;
c=colorbar; 
xlabel('X Position (m)'); ylabel('Depth (m)');
title('Grid Reynolds Number in y');
xlim([0 75000]); ylim([-2500 0]);







