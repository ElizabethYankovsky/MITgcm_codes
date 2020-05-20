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
for i = 230:240;
    j =j+1; 
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        Wn=sq(ncread('HR1.nc','W',[1 1 1 i+1],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        Vn=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i+1],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
        Un=sq(ncread('HR1.nc','U',[1 1 1 i+1],[1280 Inf Inf 1]));
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR1.nc','S',[1 1 1 i+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR1.nc','Temp',[1 1 1 i+1],[1280 Inf Inf 1]));
       % Tracer=sq(ncread('HRtracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        Wn=sq(ncread('HR2.nc','W',[1 1 1 i-40+1],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        Vn=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40+1],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
        Un=sq(ncread('HR2.nc','U',[1 1 1 i-40+1],[1280 Inf Inf 1]));
        S=sq(ncread('HR2.nc','S',[1 1 1 i-40],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR2.nc','S',[1 1 1 i-40+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR2.nc','Temp',[1 1 1 i-40+1],[1280 Inf Inf 1]));
        %Tracer=sq(ncread('HRtracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));        
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        Wn=sq(ncread('HR3.nc','W',[1 1 1 i-80+1],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        Vn=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80+1],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
        Un=sq(ncread('HR3.nc','U',[1 1 1 i-80+1],[1280 Inf Inf 1]));
        S=sq(ncread('HR3.nc','S',[1 1 1 i-80],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR3.nc','S',[1 1 1 i-80+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR3.nc','Temp',[1 1 1 i-80+1],[1280 Inf Inf 1]));
    %    Tracer=sq(ncread('HRtracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));       
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        Wn=sq(ncread('HR4.nc','W',[1 1 1 i-120+1],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        Vn=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120+1],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
        Un=sq(ncread('HR4.nc','U',[1 1 1 i-120+1],[1280 Inf Inf 1]));
        S=sq(ncread('HR4.nc','S',[1 1 1 i-120],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR4.nc','S',[1 1 1 i-120+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR4.nc','Temp',[1 1 1 i-120+1],[1280 Inf Inf 1]));
   %     Tracer=sq(ncread('HRtracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        Wn=sq(ncread('HR5.nc','W',[1 1 1 i-160+1],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        Vn=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160+1],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
        Un=sq(ncread('HR5.nc','U',[1 1 1 i-160+1],[1280 Inf Inf 1]));
        S=sq(ncread('HR5.nc','S',[1 1 1 i-160],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR5.nc','S',[1 1 1 i-160+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR5.nc','Temp',[1 1 1 i-160+1],[1280 Inf Inf 1]));
   %     Tracer=sq(ncread('HRtracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));        
    elseif i>=200 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        Wn=sq(ncread('HR6.nc','W',[1 1 1 i-200+1],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        Vn=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200+1],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
        Un=sq(ncread('HR6.nc','U',[1 1 1 i-200+1],[1280 Inf Inf 1]));
        S=sq(ncread('HR6.nc','S',[1 1 1 i-200],[1280 Inf Inf 1]));
        Sn=sq(ncread('HR6.nc','S',[1 1 1 i-200+1],[1280 Inf Inf 1]));
        T=sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[1280 Inf Inf 1]));
        Tn=sq(ncread('HR6.nc','Temp',[1 1 1 i-200+1],[1280 Inf Inf 1]));
 %       Tracer=sq(ncread('HRtracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));       
    end

    density = densmdjwf(S,T,zeros(1280,240));
    densityn= densmdjwf(Sn,Tn,zeros(1280,240));
    
    
    [dUdz, dUdx]=gradient(U,z,XC);
    [dUdzn, dUdxn]=gradient(Un,z,XC);
    
    [dWdz, dWdx]=gradient(W,z,XC);
    [dWdzn, dWdxn]=gradient(Wn,z,XC);
    
    [dVdz, dVdx]=gradient(V,z,XC);
    [dVdzn, dVdxn]=gradient(Vn,z,XC);
    
    [drhodz, drhodx]=gradient(density,z,XC);
    [drhodzn, drhodxn]=gradient(densityn,z,XC);
    
    g = 9.8; rho_o=1027.7;
    f=1.43e-4;
    Q(j,:,:) =(drhodx.*dVdz - drhodz.*(dVdx+f))*g/rho_o; %defined as -omega_a dot grad rho
    Qn(j,:,:)=(drhodxn.*dVdzn-drhodzn.*(dVdxn+f))*g/rho_o; %new PV
    dQdt(j,:,:)=(Qn(j,:,:)-Q(j,:,:))/21600;
     i
end
Qmean=sq(nanmean(Q,1));
dQdttot=sq((Q(j,:,:)-Q(1,:,:))/((j-1)*21600));
figure(i)
    pcolor(XC,z,Qmean');
    shading flat
    caxis([-1e-11 0e-11]);
    colormap(bluewhitered); %colorbar;
    title('Average PV: vorticity*grad(buoyancy)'); colorbar
     hold on
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
    % xlim([30000 60000]);
     ylim([-2500 0])
     xlabel('X Position (m)'); ylabel('Depth (m)');
     
figure(i+1)
     pcolor(XC,z,sq(nanmean(dQdt,1))'); shading flat; title('Average dQ/dt');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-1e-15 0e-15]); colormap(bluewhitered); colorbar;   
     
%      figure(i+2)
%      pcolor(XC,z,dQdttot'); shading flat; title('dQdt overall');
%      hold on; grid on;
%      area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
%      caxis([-1e-15 0e-15]); colormap(bluewhitered); colorbar; 
     
         
     
     figure(i+6)
     pcolor(XC,z,V'); shading flat; title('V');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-.4 .4]); colormap(bluewhitered); colorbar;
     
     figure(i+7)
     pcolor(XC,z,U'); shading flat; title('U');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])  
     caxis([-0.01 0.01]); colormap(bluewhitered); colorbar;
     
     figure(i+8)
     pcolor(XC,z,W'); shading flat; title('W');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-0.001 0.001]); colormap(bluewhitered); colorbar;
     
     
     
     
     
     