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
for i =230;
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[1280 Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[1280 Inf Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
        S=sq(ncread('HR2.nc','S',[1 1 1 i-40],[1280 Inf Inf 1]));
        T=sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[1280 Inf Inf 1]));        
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
        S=sq(ncread('HR3.nc','S',[1 1 1 i-80],[1280 Inf Inf 1]));
        T=sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[1280 Inf Inf 1]));       
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
        S=sq(ncread('HR4.nc','S',[1 1 1 i-120],[1280 Inf Inf 1]));
        T=sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[1280 Inf Inf 1]));
    elseif i>=161 && i<=201
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
        S=sq(ncread('HR5.nc','S',[1 1 1 i-160],[1280 Inf Inf 1]));
        T=sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[1280 Inf Inf 1]));        
    elseif i>=201 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
        S=sq(ncread('HR6.nc','S',[1 1 1 i-200],[1280 Inf Inf 1]));
        T=sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[1280 Inf Inf 1]));
    end

    density = densmdjwf(S,T,zeros(1280,240));
    [dUdz, dUdx]=gradient(U,z,XC);
    [dWdz, dWdx]=gradient(W,z,XC);
    [dVdz, dVdx]=gradient(V,z,XC);
    [drhodz, drhodx]=gradient(density,z,XC);
    f=1.43e-4;
    Qn =drhodx.*dVdz - drhodz.*(dVdx+f);
end
for i = i-1;
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
    elseif i>=161 && i<=201
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
    Q =drhodx.*dVdz - drhodz.*(dVdx+f); %defined as -omega_a dot grad rho
    
    %Term 1: U*q
    term1x=U.*Q;
    term1y=V.*Q;
    term1z=W.*Q;
    [na, grad1x]=gradient(term1x,z,XC);
    [grad1z, na]=gradient(term1z,z,XC);
    evolution1=(-grad1x-grad1z)*(g/rho_o);
    
    %Term 2: -grad dot (grad(b) cross F)
    b=(-density);
    [dbdz, dbdx]=gradient(b,z,XC);
    [d2Udz, na]=gradient(dUdz,z,XC);
    [na, d2Udx]=gradient(dUdx,z,XC);
    [d2Vdz, na]=gradient(dVdz,z,XC);
    [na, d2Vdx]=gradient(dVdx,z,XC);
    [d2Wdz, na]=gradient(dWdz,z,XC);
    [na, d2Wdx]=gradient(dWdx,z,XC);
    F1 = 2.5*d2Udx+0.01*d2Udz; F2=2.5*d2Vdx+0.01*d2Vdz; F3= 2.5*d2Wdx+0.01*d2Wdz;
    term2x = -F2.*dbdz;
    %term2y = F1.*dbdz-F3.*dbdx;
    term2z = F2.*dbdx;
    [na, grad2x]=gradient(term2x,z,XC);
    [grad2z, na]=gradient(term2z,z,XC);
    evolution2=(-grad2x-grad2z)*g/rho_o;
    
    %Term 3
    omega1=-dVdz; omega2=dUdz-dWdx; omega3=(dVdx+f);
%     DbDt=(-(densityn-density)./21600) +U.*dbdx+W.*dbdz;
%     term3x=-omega1.*DbDt;
%     term3y=-omega2.*DbDt;
%     term3z=-omega3.*DbDt;
%     [na, grad3x]=gradient(term3x,z,XC);
%     [grad3z, na]=gradient(term3z,z,XC);
%     evolution3=-grad3x-grad3z;
    term3x=-omega1.*forcing/6.5972;
    term3y=-omega2.*forcing/6.5972;
    term3z=-omega3.*forcing/6.5972;
    [na, grad3x]=gradient(term3x,z,XC);
    [grad3z, na]=gradient(term3z,z,XC);
    evolution3=(-grad3x-grad3z)*g/rho_o;
   
%Total
    totalx=term1x+term2x+term3x;
    totalz=term1z+term2z+term3z;
    materialx=term2x+term3x;
    materialz=term2z+term3z;

    [na, gradx]=gradient(totalx,z,XC);
    [gradz, na]=gradient(totalz,z,XC);
    totalevolution=(-gradx-gradz)*g/rho_o;
   [na, gradmx]=gradient(materialx,z,XC);
   [gradmz, na]=gradient(materialz,z,XC);
   materialevolution=(-gradmx-gradmz)*g/rho_o;
    
% 
%     figure(i-1)
%     pcolor(XC,z,(drhodz)');
%     shading flat
%     caxis([-0.01 0.01]);
%     colormap(bluewhitered); colorbar;
%     title('Drho/dz')
%      hold on
%      area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
%      ylim([-2500 0])
%      xlabel('X Position (m)'); ylabel('Depth (m)');   
   figure(i)
    Qneg=Q; Qneg(Qneg>0)=NaN;
    pcolor(XC,z,Q'*g/rho_o);
    hold on; pcolor(XC,z,Qneg'*g/rho_o*1000);
    shading flat
    caxis([-2e-8 2e-8]);
    colormap(bluewhitered); %colorbar;
    title('PV: -omega*grad(sigma)'); colorbar
     hold on
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
    % xlim([30000 60000]);
     ylim([-2500 0])
     xlabel('X Position (m)'); ylabel('Depth (m)');
    
     
     ax1=[-1e-14 0e-14];
    figure(i+1)
    pcolor(XC,z,(evolution1')); shading flat; title('d(PV)/dt by Advection')
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
     caxis(ax1); 
     colorbar; colormap(bluewhitered); 
     
    figure(i+2)
    pcolor(XC,z,(evolution2')); shading flat; title('d(PV)/dt by Friction')
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
     caxis(ax1); colorbar; colormap(bluewhitered); 
    
%     figure(i+3)
%     pcolor(XC,z,(evolution3')); shading flat; title('Heating');
%      hold on; grid on;
%      area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
%      caxis(ax1); colorbar; colormap(bluewhitered); 
%     
    figure(i+4)
    pcolor(XC,z,(totalevolution')); shading flat; title('Predicted dq/dt');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
     caxis(ax1); 
     colorbar; colormap(bluewhitered); 
    
%     figure(i+5)
%     pcolor(XC,z,materialevolution'); shading flat; title('Material Dq/Dt');
%     hold on
%     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]);
%     caxis([-1e-12 1e-12]); colorbar; colormap(bluewhitered);
   
    figure(i+6)
    pcolor(XC,z,(Qn'-Q')/(21600)*g/rho_o); shading flat; title('Actual dq/dt');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
     caxis(ax1); colorbar; colormap(bluewhitered); 
     
     figure(i+7)
     pcolor(XC,z,V'); shading flat; title('V');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-.3 .3]); colormap(bluewhitered); colorbar;
     figure(i+8)
     pcolor(XC,z,U'); shading flat; title('U');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8])  
     caxis([-0.01 0.01]); colormap(bluewhitered); colorbar;
     figure(i+9)
     pcolor(XC,z,W'); shading flat; title('W');
     hold on; grid on;
     area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
     caxis([-0.001 0.001]); colormap(bluewhitered); colorbar;
     
     
     
     
     
     

     i
end