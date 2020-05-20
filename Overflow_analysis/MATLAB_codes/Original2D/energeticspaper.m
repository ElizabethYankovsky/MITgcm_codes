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

ZC = ncread('grid.nc','Z');
Z = repmat(ZC,1,1280)';
KEaverage=zeros(1280,11);
Pref = -9.81*1032*Z/10000;
densityinit = densmdjwf(Sinit(1:1280,:),Tinit(1:1280,:),Pref);


for i =220:240%:240;
    j=i-119;
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
        Eta=sq(ncread('HR1.nc','Eta',[1 1 i],[Inf Inf 1]));
        PNH=sq(ncread('HR1.nc','phi_nh',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));      
        S = sq(ncread('HR2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
        T = sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
        Eta=sq(ncread('HR2.nc','Eta',[1 1 i-40],[Inf Inf 1]));
        PNH=sq(ncread('HR2.nc','phi_nh',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));  
        S = sq(ncread('HR3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        T = sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
        Eta=sq(ncread('HR3.nc','Eta',[1 1 i-80],[Inf Inf 1]));
        PNH=sq(ncread('HR3.nc','phi_nh',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
        S = sq(ncread('HR4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
        T = sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
        Eta=sq(ncread('HR4.nc','Eta',[1 1 i-120],[Inf Inf 1]));
        PNH=sq(ncread('HR4.nc','phi_nh',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));  
        S = sq(ncread('HR5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
        T = sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
        Eta=sq(ncread('HR5.nc','Eta',[1 1 i-160],[Inf Inf 1]));
        PNH=sq(ncread('HR5.nc','phi_nh',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1])); 
        S = sq(ncread('HR6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
        T = sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
        Eta=sq(ncread('HR6.nc','Eta',[1 1 i-200],[Inf Inf 1]));
        PNH=sq(ncread('HR6.nc','phi_nh',[1 1 1 i-200],[Inf Inf Inf 1]));
    end
    
    
   
    KE=0.5*(U.^2+V.^2+W.^2); 
    
   dzmat1=dzmat; dzmat1(:,1)=dzmat(:,1)+Eta;
   densityfull=densmdjwf(S,T,Pref);
   density = densmdjwf(S,T,Pref)-densityinit;
   PH = cumsum(density/1032*9.81.*dzmat1,2);
   Pressure = PH+PNH;
   Pcalc1 = Pressure;
   Pcalc3=Pcalc1;

    [Pcalc1z Pcalc1x]=gradient(Pcalc1.*U);
  % [Pcalc2z Pcalc2x]=gradient(Pcalc2.*V/1027.8);
    [Pcalc3z Pcalc3x]=gradient(Pcalc3.*W);
    
    [KEz KEx]=gradient(KE);
    [Uz Ux]=gradient(U);
    [Vz Vx]=gradient(V);
    [Wz Wx]=gradient(W);
    Ux=Ux./dxmat; Vx=Vx./dxmat; Wx=Wx./dxmat; KEx=KEx./dxmat; 
    Pcalc1x=Pcalc1x./dxmat; Pcalc3z=Pcalc3z./dzmat;
    Uz=Uz./dzmat; Vz=Vz./dzmat; Wz=Wz./dzmat; KEz=KEz./dzmat;

    flux1i=-U.*KEx-W.*KEz;
    flux2i=-Pcalc1x-Pcalc3z;
    
     
 
    CPE_KE(j,:)=(-9.81)./(1032*depth).*nansum(W.*(density).*lengthz,2);
    CKE_DISSstep=-2.5*(Ux.^2+Vx.^2+Wx.^2)-0.01*(Uz.^2+Vz.^2+Wz.^2);
    CKE_DISS(j,:) = (1./depth).*nansum(CKE_DISSstep.*lengthz,2);
    
    %flux1(j,:)=nanmean(flux1i,2);
    %flux2(j,:)=nanmean(flux2i,2);
    flux1(j,:)=(1./depth).*nansum(flux1i.*lengthz,2);
    flux2(j,:)=(1./(depth)).*nansum(flux2i.*lengthz,2);
    i

end  

figure(2)
a=smooth(nanmean(CPE_KE),50);
b=smooth(nanmean(CKE_DISS),50);
c=smooth(nanmean(flux1),50);
d=smooth(nanmean(flux2),50);
load dKEdt10
e=smooth(dKEdt10,50);
plot(XC/1000,a,'Color',[.8 .2 .47],'Linewidth',2); grid on; hold on;
plot(XC/1000,b,'Color','c','Linewidth',2);


plot(XC/1000,(e),'Color','y','Linewidth',2);
plot(XC/1000,c,'Color',[0 0.5 0],'Linewidth',2);
plot(XC/1000,d,'Color',[0 0.5 1],'Linewidth',2);
plot(XC/1000,smooth(a+b+c+d-e,100),':k','Linewidth',2);
legend('Conversion of PE to KE','Conversion of KE to DISS','Time change','Advection','Pressure flux')
xlabel('X Distance (km)')
ylabel('Energy/mass/second [m^2/s^3]')
title('Original forcing')
xlim([0 75])
%ylim([-10e-7 10e-7]);



