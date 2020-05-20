clear all
close all
load z.mat
load topo.mat
slope = topo;
topo=repmat(topo,1,900); %for other plots use topo=-topo instead of this line
load XC.mat
YC = 111.111:111.111:99999.9;

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

% V velocity
for i =120
    if i>=1 && i<=40
          S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
          T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
          U=sq(ncread('Original1.nc','U',[2 1 1 i],[Inf Inf Inf 1]));
          V=sq(ncread('Original1.nc','V',[1 2 1 i],[Inf Inf Inf 1]));
          Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
          W=sq(ncread('Original1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));

    elseif i>=41 && i<=80
           S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
           T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
           U=sq(ncread('Original2.nc','U',[2 1 1 i-40],[Inf Inf Inf 1]));
           V=sq(ncread('Original2.nc','V',[1 2 1 i-40],[Inf Inf Inf 1]));
          Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));
           W=sq(ncread('Original2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
           S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
           T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
           U=sq(ncread('Original3.nc','U',[2 1 1 i-80],[Inf Inf Inf 1]));
           V=sq(ncread('Original3.nc','V',[1 2 1 i-80],[Inf Inf Inf 1]));
           Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1])); 
           W=sq(ncread('Original3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
           S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
           T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
           U=sq(ncread('Original4.nc','U',[2 1 1 i-120],[Inf Inf Inf 1]));
           V=sq(ncread('Original4.nc','V',[1 2 1 i-120],[Inf Inf Inf 1]));
          Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
           W=sq(ncread('Original4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=201
           S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
           T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
           U=sq(ncread('Original5.nc','U',[2 1 1 i-160],[Inf Inf Inf 1]));
           V=sq(ncread('Original5.nc','V',[1 2 1 i-160],[Inf Inf Inf 1]));
          Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1])); 
           W=sq(ncread('Original5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
           S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
           T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
           U=sq(ncread('Original6.nc','U',[2 1 1 i-200],[Inf Inf Inf 1]));
           V=sq(ncread('Original6.nc','V',[1 2 1 i-200],[Inf Inf Inf 1]));
          Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));      
           W=sq(ncread('Original6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
    end
    density = densmdjwf(S,T,zeros(640,900,120));
    
    dVx = diff(V,1,1);
    dx=diff(XC); dx = repmat(dx,1,900,120); %size 639x900x120
    dVdx = dVx./dx; %size 639x900x120
    
    dUdy=diff(U,1,2)/111.111;
    
    dVz = diff(V,1,3);
    dz = repmat(diff(z),1,640,900); dz = permute(dz,[2 3 1]);
    dVdz = dVz./dz; %size 640x900x119
    dUdz = (diff(U,1,3))./dz; %size 640x900x119
    
    drhox = diff(density,1,1);
    drhodx=drhox./dx; %size 639x900x120
    drhody=diff(density,1,2)/111.111;
    drhoz = diff(density,1,3);
    drhodz=drhoz./dz; %size 640x899x120
    
    g = 9.8; rho_o=1027.7;
    f=1.43e-4;
    dVdz=dVdz(1:639,1:899,1:119); drhodx=drhodx(1:639,1:899,1:119);
    dUdz=dUdz(1:639,1:899,1:119); drhody=drhody(1:639,1:899,1:119);
    drhodz=drhodz(1:639,1:899,1:119); dVdx=dVdx(1:639,1:899,1:119);
    dUdy=dUdy(1:639,1:899,1:119);
    %Q =(g/rho_o)*(drhodx.*dVdz)-(g/rho_o)*drhodz.*(dVdx+f); %2D CALC
    Q =(g/rho_o)*(drhodx.*dVdz - drhody.*dUdz)- (g/rho_o)*drhodz.*(dVdx-dUdy+f);
    Q1=Q;
    
%     figure(i)
%     meshz(XC/1000,YC/1000,topo')
%     set(gca,'Fontsize',10); xlabel('X Position (km)','Fontsize',10)
%     ylabel('Y Position (km)','Fontsize',10)
%     zlabel('Depth, (m)','Fontsize',10); 
%     view(25,10); %original previously(50,30)
%     set(gca,'Color',[.75 .9 1]);
%     load brown.mat; colormap(brown);
%     hold on
%     Q(Q<0)=-100;
%     variable = permute(Q,[2 1 3]);
%     p =patch(isosurface(XC(1:639)/1000,YC(1:899)/1000,z(1:119),variable,-100));
%     isonormals(XC(1:639)/1000,YC(1:899)/1000,z(1:119),variable,p)
%     set(p,'Facecolor','b','EdgeColor','none');
%     camlight; lighting flat; set(gcf,'Color','w'); xlim([0 75]);
%     drawnow
%     i
end


figure(i+1)
yslice =450;
area(XC,slope,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC(2:640),z(2:120),squeeze(Q(:,yslice,:))'); shading flat;
xlim([0 75000]); ylim([-2500 0]);
colormap('bluewhitered'); title('Location of negative PV')
 caxis([-1e-25 0]); colormap(bluewhitered);

figure(i+2)
area(XC,-slope,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC(2:640),z(2:120),squeeze(Q1(:,yslice,:))'); shading flat;
ylim([-2500 0]); caxis([-1e-11 1e-9]);
colormap('bluewhitered'); colorbar; title('PV values');

a=(g/rho_o)*(drhodx.*dVdz - drhody.*dUdz);
b=dVdx-dUdy+f;
c=(g/rho_o)*drhodz.*(dVdx-dUdy+f);

% figure(i+3)
% area(XC,-slope,-2500,'Facecolor',[.8 .8 .8])
% hold on
% pcolor(XC(2:640),z(2:120),squeeze(a(:,yslice,:))'); shading flat;
% xlim([0 75000]); ylim([-2500 0]); caxis([-1e-9 1e-9]);
% colormap('bluewhitered'); colorbar; title('(g/rho_o)*(drho/dx.*dV/dz - drho/dy.*dU/dz)');
% 
% figure(i+4)
% area(XC,-slope,-2500,'Facecolor',[.8 .8 .8])
% hold on
% pcolor(XC(2:640),z(2:120),squeeze(b(:,yslice,:))'); shading flat;
% xlim([0 75000]); ylim([-2500 0]); caxis([-.001 .001]);
% colormap('bluewhitered'); colorbar; title('dVdx-dUdy+f (Absolute vorticity)');
% 
% figure(i+5)
% area(XC,-slope,-2500,'Facecolor',[.8 .8 .8])
% hold on
% pcolor(XC(2:640),z(2:120),squeeze(c(:,yslice,:))'); shading flat;
% xlim([0 75000]); ylim([-2500 0]); caxis([-1e-9 1e-9]);
% colormap('bluewhitered'); colorbar; title('(g/rho_o)*drhodz.*(dVdx-dUdy+f))');
% 
figure(i+6)
area(XC,-slope,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z,squeeze(U(:,yslice,:))'); shading flat;
xlim([0 75000]); ylim([-2500 0]); caxis([-.5 .5]);
colormap('bluewhitered'); colorbar; title('U velocity (m/s)');

figure(i+7)
area(XC,-slope,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z,sq(Tracer(:,yslice,:))'); shading flat;
xlim([0 75000]); ylim([-2500 0]); caxis([0 1]);
colormap('bluewhitered'); colorbar; title('Tracer');

figure(i+8)
area(XC,-slope,-2500,'Facecolor',[.8 .8 .8])
hold on
pcolor(XC,z,squeeze(V(:,yslice,:))'); shading flat;
xlim([0 75000]); ylim([-2500 0]); caxis([-.05 .05]);
colormap('bluewhitered'); colorbar; title('W velocity (m/s)');

Tracer = sq(Tracer(:,yslice,:))';
Tracer(isnan(Tracer))=0;
U = squeeze(U(:,yslice,:))';
V = squeeze(V(:,yslice,:))';
Q1 = squeeze(Q1(:,yslice,:))';


