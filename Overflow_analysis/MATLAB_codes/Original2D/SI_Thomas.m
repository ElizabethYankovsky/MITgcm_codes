clear all
close all
load z.mat
load topo.mat
topo=-topo;
load XC.mat

cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit = reshape(Tinit,[1280 240]);

fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit = reshape(Sinit,[1280 240]);

fid3= fopen('Qnet.forcing','r','b');
heat=fread(fid3,'real*8');
fid4= fopen('SF.forcing','r','b');
salt=fread(fid4,'real*8');
forcingi=(7.84e-4*salt)-(3.92e-5*heat/3974);
cd ..

forcing=zeros(1280,240);
forcing(:,1)=forcingi;
densityinit = densmdjwf(Sinit,Tinit,zeros(1280,240));
j=0;
for i = 240;
    j =j+1; 
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR1.nc','S',[1 1 1 i+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR1.nc','Temp',[1 1 1 i+1],[1280 Inf Inf 1]));
       % Tracer=sq(ncread('HRtracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
        S=sq(ncread('HR2.nc','S',[1 1 1 i-40],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR2.nc','S',[1 1 1 i-40+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR2.nc','Temp',[1 1 1 i-40+1],[1280 Inf Inf 1]));
        %Tracer=sq(ncread('HRtracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));        
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
        S=sq(ncread('HR3.nc','S',[1 1 1 i-80],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR3.nc','S',[1 1 1 i-80+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR3.nc','Temp',[1 1 1 i-80+1],[1280 Inf Inf 1]));
    %    Tracer=sq(ncread('HRtracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));       
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
        S=sq(ncread('HR4.nc','S',[1 1 1 i-120],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR4.nc','S',[1 1 1 i-120+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR4.nc','Temp',[1 1 1 i-120+1],[1280 Inf Inf 1]));
   %     Tracer=sq(ncread('HRtracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
        S=sq(ncread('HR5.nc','S',[1 1 1 i-160],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR5.nc','S',[1 1 1 i-160+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR5.nc','Temp',[1 1 1 i-160+1],[1280 Inf Inf 1]));
   %     Tracer=sq(ncread('HRtracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));        
    elseif i>=201 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
        S=sq(ncread('HR6.nc','S',[1 1 1 i-200],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR6.nc','S',[1 1 1 i-200+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR6.nc','Temp',[1 1 1 i-200+1],[1280 Inf Inf 1]));
 %       Tracer=sq(ncread('HRtracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));       
    end

    density = densmdjwf(S,T,zeros(1280,240));
    densityn= densmdjwf(Sn,Tn,zeros(1280,240));
    
    
    [dUdz, dUdx]=gradient(U,z,XC);
    [dWdz, dWdx]=gradient(W,z,XC);
    [dVdz, dVdx]=gradient(V,z,XC);
    [drhodz, drhodx]=gradient(density,z,XC);
    g = 9.8; rho_o=1027.7;
    f=1.43e-4;
    Q(j,:,:) =(drhodx.*dVdz - drhodz.*(dVdx+f))*g/rho_o; %defined as -omega_a dot grad rho
    

     i
end
Q=sq(nanmean(Q,1));
N2 = (-g/rho_o).*drhodz;
gradhb2 = ((-g/rho_o)*drhodx).^2;
RIb = N2./(dVdz).^2;
comparison = f*(f+dVdx);
comparison2 = f./(f+dVdx);
PHI = atand(-gradhb2./(f^2*N2));
PHIc=atand(-(f+dVdx)/f);

test=zeros(1280,240);
RIbtest = zeros(1280,240);
RIbtest(RIb<comparison2)=RIb(RIb<comparison2); 
test(comparison>0)=RIbtest(comparison>0);

     figure(i+6)
     pcolor(XC,z,Q'); shading flat; title('Location of negative Q');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-1e-20 0]); colormap(bluewhitered); 
     
     figure(i+7)
     pcolor(XC,z,N2'); shading flat; title('N^2');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])  
     caxis([-1e-6 1e-5]); colormap(bluewhitered); colorbar;
     

     

     figure(i+9)
     pcolor(XC,z,log10(abs(RIb))'); shading flat; title('RI_b');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-5 20]); 
     colormap(bluewhitered); colorbar;
     
     
     figure(i+10)
     pcolor(XC,z,comparison'); shading flat; title('f*(f+dV/dx)');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-1e-7 1e-7]); 
     colormap(bluewhitered); colorbar;

     
     figure(i+11)
     pcolor(XC,z,test'); shading flat; title('RI_b where is criterion met');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-2 2]); 
     colormap(bluewhitered); colorbar;  
     
%      figure(i+12)
%      pcolor(XC,z,PHI'); shading flat; title('PHI');
%      hold on; grid on;
%      area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
%      caxis([-180 180]); 
%      colormap(bluewhitered); colorbar; 
%      
%      
     figure(i+13)
     pcolor(XC,z,PHIc'); shading flat; title('PHIc');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-180 180]); 
     colormap(bluewhitered); colorbar; 
%      
     figure(i+14)
     testPHI = zeros(1280,240);
     testPHI(PHI<PHIc)=PHI(PHI<PHIc);
     pcolor(XC,z,testPHI'); shading flat; title('PHI where PHI<PHIc');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-180 180]); 
     colormap(bluewhitered); colorbar; 
     
     
