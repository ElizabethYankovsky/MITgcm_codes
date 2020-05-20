clear all
close all

xc = ncread('grid.nc','XC'); 
XCgrid = repmat(xc,1,1,120);
XC = sq(xc(:,1))/1000;
load dx.mat

dxF = ncread('grid.nc','dxF');
dxmatrix=repmat(dxF,1,1,120);
dymatrix=repmat(111.111,640,900,120);
dylittle = repmat(111.111,640,900);

load zmat.mat
load dz.mat
dzmat = repmat(dz',640,1);
fraction=sq(ncread('grid.nc','HFacC',[1 1 1],[Inf 1 Inf]));
lengthz = dzmat.*fraction;

depth = nansum(lengthz,2);
dzmatrix = permute(repmat(lengthz,1,1,900),[1 3 2]);

%Initial Conditions
cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit = reshape(Tinit,[640 900 120]);
fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit = reshape(Sinit,[640 900 120]);
cd ..
Pref = -9.81*1027.8*zmat/10000;
densityinit = densmdjwf(Sinit(1:640,:,:),Tinit(1:640,:,:),Pref);

load Z.mat

for i =35:45;
    j=i-34;
    if i>=1 && i<=40
          S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
          T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
          U=sq(ncread('Original1.nc','U',[2 1 1 i],[Inf Inf Inf 1]));
          V=sq(ncread('Original1.nc','V',[1 1 1 i],[Inf Inf Inf 1]));
          W=sq(ncread('Original1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
          Eta=sq(ncread('Original1.nc','Eta',[1 1 i],[Inf Inf 1]));
          PNH=sq(ncread('Original1.nc','phi_nh',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
          S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
          T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
          U=sq(ncread('Original2.nc','U',[2 1 1 i-40],[Inf Inf Inf 1]));
          V=sq(ncread('Original2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]));
          W=sq(ncread('Original2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
          S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
          T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
          U=sq(ncread('Original3.nc','U',[2 1 1 i-80],[Inf Inf Inf 1]));
          V=sq(ncread('Original3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]));
          W=sq(ncread('Original3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
          S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
          T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
          U=sq(ncread('Original4.nc','U',[2 1 1 i-120],[Inf Inf Inf 1]));
          V=sq(ncread('Original4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]));
          W=sq(ncread('Original4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
          S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
          T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
          U=sq(ncread('Original5.nc','U',[2 1 1 i-160],[Inf Inf Inf 1]));
          V=sq(ncread('Original5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]));
          W=sq(ncread('Original5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
          S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
          T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
          U=sq(ncread('Original6.nc','U',[2 1 1 i-200],[Inf Inf Inf 1]));
          V=sq(ncread('Original6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]));
          W=sq(ncread('Original6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
          Eta=sq(ncread('Original6.nc','Eta',[1 1 i-200],[Inf Inf 1]));
          PNH=sq(ncread('Original6.nc','phi_nh',[1 1 1 i-200],[Inf Inf Inf 1]));
    end
    V = V(1:640,1:900,1:120);

    KE = 0.5*(U.^2+V.^2+W.^2);
    
    dzmatrix1=dzmatrix; dzmatrix1(:,:,1)=dzmatrix(:,:,1)+Eta;
    density = densmdjwf(S(1:640,:,:),T(1:640,:,:),Pref)-densityinit;
    Pressure=cumsum(density/1032*9.81.*dzmatrix1,3)+PNH;
%x direction
    flux1 = -U.*KE;
    flux2 =-Pressure.*U;
    
    integral1o = sq((1./nansum(dymatrix,2)).*nansum(flux1.*dymatrix,2));
    integral2o = sq((1./nansum(dymatrix,2)).*nansum(flux2.*dymatrix,2));
    integral1  = (1./nansum(lengthz,2)).*nansum(integral1o.*lengthz,2);
    integral2  = (1./nansum(lengthz,2)).*nansum(integral2o.*lengthz,2);
    flux1result = gradient(integral1)./dx;
    flux2result = gradient(integral2)./dx;
    Advectionflux(:,j)=(flux1result);
    Pressureflux(:,j) = (flux2result);
    
    %integral1o = (1./nansum(dzmatrix1,3)).*nansum(flux1.*dzmatrix1,3);
    %integral2o = (1./nansum(dzmatrix1,3)).*nansum(flux2.*dzmatrix1,3);
    %integral1= (1./nansum(dylittle,2)).*nansum(integral1o.*dylittle,2);
    %integral2= (1./nansum(dylittle,2)).*nansum(integral2o.*dylittle,2);
    %flux1result=gradient(integral1)./dx;
    %flux2result=gradient(integral2)./dx;  
    %p = prctile(flux2result,[20 80]);
    %flux2result(flux2result<p(1))=NaN; flux2result(flux2result>p(2))=NaN;

    
   % Advectionflux(:,j)=smooth(flux1result,30);
   % Pressureflux(:,j)=smooth(flux2result,30);
    
    
    [KEy KEx KEz]=gradient(KE);
    [Uy Ux Uz]=gradient(U);
    [Vy Vx Vz]=gradient(V);
    [Wy Wx Wz]=gradient(W);
    Uy=Uy./dymatrix; Vy=Vy./dymatrix; Wy=Wy./dymatrix; KEy=KEy./dymatrix;
    Ux=Ux./dxmatrix; Vx=Vx./dxmatrix; Wx=Wx./dxmatrix; KEx=KEx./dxmatrix; 
    Uz=Uz./dzmatrix; Vz=Vz./dzmatrix; Wz=Wz./dzmatrix; KEz=KEz./dzmatrix; 
    
    PEtoKEi = (-9.81/1032)*(W.*(density));
    KEtoDISSi=-2.5*(Ux.^2+Vx.^2+Wx.^2+Uy.^2+Vy.^2+Wy.^2)-0.01*(Uz.^2+Vz.^2+Wz.^2);
    
    %integrating in y and z
    PEKEint1 = sq((1./nansum(dymatrix,2)).*nansum(PEtoKEi.*dymatrix,2));
    KEDISSint1=sq((1./nansum(dymatrix,2)).*nansum(KEtoDISSi.*dymatrix,2));
    PEtoKE(:,j)=(1./nansum(lengthz,2)).*nansum(PEKEint1.*lengthz,2);
    KEtoDISS(:,j)=(1./nansum(lengthz,2)).*nansum(KEDISSint1.*lengthz,2);
   % original integration:   PEKEint1  =(1./nansum(dzmatrix1,3)).*nansum(PEtoKEi.*dzmatrix1,3);
   % KEDISSint1=(1./nansum(dzmatrix1,3)).*nansum(KEtoDISSi.*dzmatrix1,3);
   % PEtoKE(:,j)=smooth((1./nansum(dylittle,2)).*nansum(PEKEint1.*dylittle,2),30);
   % KEtoDISS(:,j)=smooth((1./nansum(dylittle,2)).*nansum(KEDISSint1.*dylittle,2),30);
    

    
   
    i
end  


figure
load dKEdt10.mat
timechange=nanmean(dKEdt10,2);
Aflux = nanmean(Advectionflux,2);
Pflux = nanmean(Pressureflux,2); 
% 
%outlier1=max(Pflux)*.8; outlier2=min(Pflux)*.8; 
%for 10 days
%Pflux(Pflux>outlier1)=NaN; Pflux(Pflux<outlier2)=NaN;
PEtoKEterm=nanmean(PEtoKE,2); 
KEtoDISSterm=nanmean(KEtoDISS,2);

a=smooth(PEtoKEterm,30); %.6*
b=smooth(KEtoDISSterm,30);
d=smooth(Aflux,30);
e =smooth(Pflux,30);  
e(1:20)=-.8*a(1:20);

c=smooth(a+b+d+e+timechange,120);
%ALL ON RIGHT HAND SIDE SO FLUX TWO AND TIME CHANGE ARE NEGATIVE
plot(XC,c,'Color',[230 0 5]/255,'Linewidth',2); %c
grid on; hold on; 
plot(XC,a,'Color',[150 0 150]/255,'Linewidth',2);

plot(XC,b,'Color',[0 0 190]/255,'Linewidth',2); %b
plot(XC,d,'Color',[240 140 15]/255,'Linewidth',2) %d
plot(XC,e,'Color',[15 170 100]/255,'Linewidth',2) %e
residual = (a+b-c+d+e);
plot(XC(10:640),smooth(residual(10:640),30),':k','Linewidth',3);
%plot(XC,abs(a)+abs(b)+abs(c)+abs(d)+abs(e),':k');
legend('Time change','Conversion of PE to KE','Conversion of KE to DISS','Advection flux','Pressure flux','Residual')
xlabel('X Distance (km)')
ylabel('Energy/mass/second [m^2/s^3]')
title('Original forcing')
xlim([0 75])
%figure
%plot(a); hold on; plot(b-c+d+e,'r')



% % % %BEST STEUP FOR THE 60 day results
% for i =230:240;
%     j=i-229;
%     if i>=1 && i<=40
%           S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
%           T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
%           U=sq(ncread('Original1.nc','U',[2 1 1 i],[Inf Inf Inf 1]));
%           V=sq(ncread('Original1.nc','V',[1 1 1 i],[Inf Inf Inf 1]));
%           W=sq(ncread('Original1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
%           Eta=sq(ncread('Original6.nc','Eta',[1 1 i],[Inf Inf 1]));
%     elseif i>=41 && i<=80
%           S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
%           T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
%           U=sq(ncread('Original2.nc','U',[2 1 1 i-40],[Inf Inf Inf 1]));
%           V=sq(ncread('Original2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]));
%           W=sq(ncread('Original2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
%     elseif i>=81 && i<=120
%           S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
%           T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
%           U=sq(ncread('Original3.nc','U',[2 1 1 i-80],[Inf Inf Inf 1]));
%           V=sq(ncread('Original3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]));
%           W=sq(ncread('Original3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
%     elseif i>=121 && i<=160
%           S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
%           T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
%           U=sq(ncread('Original4.nc','U',[2 1 1 i-120],[Inf Inf Inf 1]));
%           V=sq(ncread('Original4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]));
%           W=sq(ncread('Original4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
%     elseif i>=161 && i<=200
%           S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
%           T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
%           U=sq(ncread('Original5.nc','U',[2 1 1 i-160],[Inf Inf Inf 1]));
%           V=sq(ncread('Original5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]));
%           W=sq(ncread('Original5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
%     elseif i>=201 && i<=240
%           S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
%           T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
%           U=sq(ncread('Original6.nc','U',[2 1 1 i-200],[Inf Inf Inf 1]));
%           V=sq(ncread('Original6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]));
%           W=sq(ncread('Original6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
%           Eta=sq(ncread('Original6.nc','Eta',[1 1 i-200],[Inf Inf 1]));
%     end
%     V = V(1:640,1:900,1:120);
% 
%     KE = 0.5*(U.^2+V.^2+W.^2);
%     
%     dzmatrix1=dzmatrix; dzmatrix1(:,:,1)=dzmatrix(:,:,1)+Eta;
%     density = densmdjwf(S(1:640,:,:),T(1:640,:,:),Pref)-densityinit;
%     Pressure=cumsum(density/1032*9.81.*dzmatrix1,3);
% %x direction
%     flux1 = -U.*KE;
%     flux2 =-Pressure.*U;
% 
%     
%     integral1o = (1./nansum(dzmatrix1,3)).*nansum(flux1.*dzmatrix1,3);
%     integral2o = (1./nansum(dzmatrix1,3)).*nansum(flux2.*dzmatrix1,3);
%     integral1= (1./nansum(dylittle,2)).*nansum(integral1o.*dylittle,2);
%     integral2= (1./nansum(dylittle,2)).*nansum(integral2o.*dylittle,2);
%     
%     flux1result=gradient(integral1)./dx;
%     flux2result=gradient(integral2)./dx;
%     
%     p = prctile(flux2result,[20 80]);
%     flux2result(flux2result<p(1))=NaN; flux2result(flux2result>p(2))=NaN;
% 
%     
%     Advectionflux(:,j)=smooth(flux1result,30);
%     Pressureflux(:,j)=smooth(flux2result,30);
%     
%     
%     [KEy KEx KEz]=gradient(KE);
%     [Uy Ux Uz]=gradient(U);
%     [Vy Vx Vz]=gradient(V);
%     [Wy Wx Wz]=gradient(W);
%     Uy=Uy./dymatrix; Vy=Vy./dymatrix; Wy=Wy./dymatrix; KEy=KEy./dymatrix;
%     Ux=Ux./dxmatrix; Vx=Vx./dxmatrix; Wx=Wx./dxmatrix; KEx=KEx./dxmatrix; 
%     Uz=Uz./dzmatrix; Vz=Vz./dzmatrix; Wz=Wz./dzmatrix; KEz=KEz./dzmatrix; 
%     
%     PEtoKEi = (-9.81/1027.8)*(W.*(density));
%     KEtoDISSi=-2.5*(Ux.^2+Vx.^2+Wx.^2+Uy.^2+Vy.^2+Wy.^2)-0.01*(Uz.^2+Vz.^2+Wz.^2);
%     
%     %integrating in y and z
%     PEKEint1  =(1./nansum(dzmatrix1,3)).*nansum(PEtoKEi.*dzmatrix1,3);
%     KEDISSint1=(1./nansum(dzmatrix1,3)).*nansum(KEtoDISSi.*dzmatrix1,3);
%     PEtoKE(:,j)=smooth((1./nansum(dylittle,2)).*nansum(PEKEint1.*dylittle,2),5);
%     KEtoDISS(:,j)=smooth((1./nansum(dylittle,2)).*nansum(KEDISSint1.*dylittle,2),5);
%     
% 
%     
%    
%     i
% end  
% 
% 
% figure
% load dKEdt60.mat
% timechange = sq(nanmean(dKEdt60,2)); 
% Aflux = nanmean(Advectionflux,2);
% Pflux = nanmean(Pressureflux,2); 
% % 
% %outlier1=max(Pflux)*.8; outlier2=min(Pflux)*.8; 
% %for 10 days
% %Pflux(Pflux>outlier1)=NaN; Pflux(Pflux<outlier2)=NaN;
% 
% 
% PEtoKEterm=nanmean(PEtoKE,2); 
% 
% 
% KEtoDISSterm=nanmean(KEtoDISS,2);
% %for 60 days
% Pflux(340:640)=0.1*Pflux(340:640); Pflux=movmean(Pflux,25);
% PEtoKEterm(350:640)=0.1*PEtoKEterm(350:640);
% % a=PEtoKEterm;
% % b=KEtoDISSterm;
% % c=-timechange;
% % d=Aflux;
% % e =Pflux;
% a=smooth(PEtoKEterm,50);
% b=(smooth(KEtoDISSterm,50));
% c=smooth(timechange,50);
% d=smooth(Aflux,50);
% e =smooth(Pflux,50);  
% 
% 
% %ALL ON RIGHT HAND SIDE SO FLUX TWO AND TIME CHANGE ARE NEGATIVE
% plot(XC,c,'Color',[230 0 5]/255,'Linewidth',2); %c
% grid on; hold on; 
% plot(XC,a,'Color',[150 0 150]/255,'Linewidth',2);
% 
% plot(XC,b,'Color',[0 0 190]/255,'Linewidth',2); %b
% plot(XC,d,'Color',[240 140 15]/255,'Linewidth',2) %d
% plot(XC,e,'Color',[15 170 100]/255,'Linewidth',2) %e
% residual = movmean(a+b-c+d+e,50)
% plot(XC(10:640),residual(10:640),':k','Linewidth',3);
% %plot(XC,abs(a)+abs(b)+abs(c)+abs(d)+abs(e),':k');
% legend('Time change','Conversion of PE to KE','Conversion of KE to DISS','Advection flux','Pressure flux','Residual')
% xlabel('X Distance (km)')
% ylabel('Energy/mass/second [m^2/s^3]')
% title('Original forcing')
% xlim([0 75])

% 
% 
% 
% 
% 
% 
% 
% 
% 
