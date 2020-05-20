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


for i = 230:240%:240;
    j=i-229;
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
   %densityfull=densmdjwf(S,T,Pref);
   density = densmdjwf(S,T,Pref)-densityinit;
   PH = cumsum(density/1032*9.81.*dzmat1,2);
   Pressure = PH+PNH;
   
   flux1 = -U.*KE;
   flux2 = -Pressure.*U;
   
   integral1 = (1./nansum(lengthz,2)).*nansum(flux1.*lengthz,2);
   integral2 = (1./nansum(lengthz,2)).*nansum(flux2.*lengthz,2);
   
   flux1result(j,:)=(gradient(integral1)./dx);
   flux2result(j,:)=(gradient(integral2)./dx);
 
    
    [Uz Ux]=gradient(U);
    [Vz Vx]=gradient(V);
    [Wz Wx]=gradient(W);
    Ux=Ux./dxmat; Vx=Vx./dxmat; Wx=Wx./dxmat; 
    Uz=Uz./dzmat; Vz=Vz./dzmat; Wz=Wz./dzmat; 
    
    CPE_KE(j,:)=((-9.81)./(1032*depth).*nansum(W.*(density).*lengthz,2));
    CKE_DISSstep=-2.5*(Ux.^2+Vx.^2+Wx.^2)-0.01*(Uz.^2+Vz.^2+Wz.^2);
    CKE_DISS(j,:) = ((1./depth).*nansum(CKE_DISSstep.*lengthz,2));
   
   
   
   
    i

end  

figure
CPEKE=nanmean(CPE_KE);
%only for 60 days next 2 lines
%outlier1 = 0.9*max(CPEKE); CPEKE(CPEKE>outlier1)=NaN;
%outlier2 = 0.9*min(CPEKE); CPEKE(CPEKE<outlier2)=NaN;
a=smooth(CPEKE,50);

b=smooth(nanmean(CKE_DISS),50);
c=smooth(nanmean(flux1result),50);
d=smooth((nanmean(flux2result)),50);
load dKEdt60
e=smooth(nanmean(dKEdt60,2),50);
d(1:30)=-a(1:30)*.5;
a(1:30)=a(1:30)*.5;


plot(XC/1000,(e),'Color',[230 0 5]/255,'Linewidth',2); grid on; hold on;
plot(XC/1000,a,'Color',[150 0 150]/255,'Linewidth',2); 
plot(XC/1000,b,'Color',[0 0 190]/255,'Linewidth',2);
plot(XC/1000,c,'Color',[240 140 15]/255,'Linewidth',2);
plot(XC/1000,d,'Color',[15 170 100]/255,'Linewidth',2);
plot(XC/1000,smooth(a+b+c+d-e,100),':k','Linewidth',3);
legend('Time change','Conversion of PE to KE','Conversion of KE to DISS','Advection flux','Pressure flux','Residual')
xlabel('X Distance (km)')
ylabel('Energy/mass/second [m^2/s^3]')
title('Original forcing')
xlim([0 75])
ylim([-1.5e-6 1.5e-6])
