clear all
close all

dx = ncread('grid.nc','dxF');
dz = ncread('grid.nc','drF');
load XC.mat

dzmat = repmat(dz',1280,1);
dxmat = repmat(dx,1,240);
fraction=sq(ncread('grid.nc','HFacC',[1 1 1],[Inf 1 Inf]));
lengthz = dzmat.*fraction;
depth = nansum(lengthz(1:1280,1:240),2);
depths = nansum(lengthz(1:1280,1:239),2);
%Initial Conditions
cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit = reshape(Tinit,[1280 240]);
%Tinit = sq(Tinit(:,1,:));

fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit = reshape(Sinit,[1280 240]);
cd ..
densityinit = densmdjwf(Sinit(1:1280,:),Tinit(1:1280,:),zeros(1280,240));
%densityinit = nanmean(nanmean(densityinit(1:135,1:3)));

ZC = ncread('grid.nc','Z');
Z = repmat(ZC,1,1280)';
KEaverage=zeros(1280,11);

for i =35:45%:240;
    j=i-34;
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));      
        S = sq(ncread('HR2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
        T = sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));  
        S = sq(ncread('HR3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        T = sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
        S = sq(ncread('HR4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
        T = sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));  
        S = sq(ncread('HR5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
        T = sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1])); 
        S = sq(ncread('HR6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
        T = sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
    end
    
    Umean = U; %THIS IS 2D SO WE DON'T ALONGSLOPE AVERAGE
    Vmean = V;
    Wmean = W;
    density = densmdjwf(S,T,zeros(1280,240));
    %computing u',v',w' and dU/d(x,y) dV/d(x,y) dW/d(x,y) for later
    %alongshore averaging. In the loop we calculate quantitues at each y
    %point, averaging applied outside for generality to nonlinear
    %situations.
    KE(:,j)=nanmean(0.5*(U.^2+V.^2+W.^2),2); 


    
     dxlarge = repmat(dx(1:1279),1,239);
     dzlarge = repmat(dz(1:239),1,1279)';
     dVdx= diff(V(1:1280,1:239),1,1)./dxlarge; 
     dVdz= diff(V(1:1279,1:240),1,2)./dzlarge; 

     
     dUdx= diff(U(1:1280,1:239),1,1)./dxlarge;
     dUdz= diff(U(1:1279,1:240),1,2)./dzlarge; 

     
     dWdx= diff(W(1:1280,1:239),1,1)./dxlarge;
     dWdz= diff(W(1:1279,1:240),1,2)./dzlarge;




     PEtot=9.81*Z.*density;
     %PE=(1./(1027.8*depth)).*nansum(PEtot.*lengthz,2);
    
     PEdiff =PEtot-densityinit.*Z*9.81;
     PEd(j,:) = (1./(1027.8*depth)).*nansum(PEdiff.*lengthz,2);
     CPE_KE(j,:)=(-9.81./(1027.8*depth)).*nansum(W.*(density-densityinit).*lengthz,2);

    CKE_DISSstep=2.5*(dUdx.^2+dVdx.^2+dWdx.^2)+0.01*(dUdz.^2+dVdz.^2+dWdz.^2);
    CKE_DISS(j,:) = (1./depths(1:1279)).*nansum(CKE_DISSstep.*lengthz(1:1279,1:239),2);
    i

end  

figure(2)
a=smooth(nanmean(CPE_KE),50);
b=smooth(nanmean(CKE_DISS),50);
plot(XC/1000,a,'Color',[.8 .2 .47],'Linewidth',2); grid on; hold on;
plot(XC(1:1279)/1000,b,'Color','k','Linewidth',2);

plot(XC(1:1279)/1000,a(1:1279)-b,'Color',[0 0.5 0],'Linewidth',2);
load dKEdt60
plot(XC/1000,dKEdt60,'b','Linewidth',2);

legend('Conversion of PE to KE','Conversion of KE to DISS','Difference','DKE/Dt')
xlabel('X Distance (km)')
ylabel('Energy/mass/second [m^2/s^3]')
title('Original forcing')
xlim([0 75])
ylim([-2e-7 12e-7]);


















