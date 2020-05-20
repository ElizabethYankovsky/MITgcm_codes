clear all
close all

load dx.mat
load dz.mat
load XC.mat

dzmat = repmat(dz',640,1);
dxmat = repmat(dx,1,120);
fraction=sq(ncread('grid.nc','HFacC',[1 1 1],[Inf 1 Inf]));
lengthz = dzmat.*fraction;
depth = nansum(lengthz(1:640,1:120),2);
depths = nansum(lengthz(1:640,1:119),2);
%Initial Conditions
cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit = reshape(Tinit,[640 900 120]);
%Tinit = sq(Tinit(:,1,:));

fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit = reshape(Sinit,[640 900 120]);
cd ..
densityinit = densmdjwf(Sinit(1:640,:,:),Tinit(1:640,:,:),zeros(640,900,120));
%densityinit = nanmean(nanmean(densityinit(1:135,1:3)));

ZC = ncread('grid.nc','Z');
Z = repmat(ZC,1,640,900);
Z = permute(-Z,[2 3 1]);
Z = Z(1:640,:,:);

for i =230:240%:240;
    j=i-229;
    if i>=1 && i<=40
          S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
          T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
          U=sq(ncread('Original1.nc','U',[2 1 1 i],[Inf Inf Inf 1]));
          V=sq(ncread('Original1.nc','V',[1 1 1 i],[Inf Inf Inf 1]));
          W=sq(ncread('Original1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
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
    end
    Umean = (nanmean(U(1:640,:,:),2));
    Vmean = (nanmean(V(1:640,:,:),2));
    Wmean = (nanmean(W(1:640,:,:),2));
    density = densmdjwf(S(1:640,:,:),T(1:640,:,:),zeros(640,900,120));
    %computing u',v',w' and dU/d(x,y) dV/d(x,y) dW/d(x,y) for later
    %alongshore averaging. In the loop we calculate quantitues at each y
    %point, averaging applied outside for generality to nonlinear
    %situations.
     
    uprime(1:640,:,:) = U(1:640,:,:)-repmat(Umean,1,900,1);
    vprime(1:640,:,:) = V(1:640,1:900,:)-repmat(Vmean,1,900,1);
    wprime(1:640,:,:) = W(1:640,:,:)-repmat(Wmean,1,900,1);
    densityprime(1:640,:,:)=density(1:640,:,:)-repmat(nanmean(density(1:640,:,:),2),1,900,1);
    
     dxlarge = repmat(dx(1:639),1,899,119);
     dzlarge = permute(repmat(dz(1:119),1,639,899),[2 3 1]);
     dVdx= diff(V(1:640,1:899,1:119),1,1)./dxlarge; 
     dVdz= diff(V(1:639,1:899,1:120),1,3)./dzlarge; 
     dVdy= diff(V(1:639,1:900,1:119),1,2)/111.11;
     
     dUdx= diff(U(1:640,1:899,1:119),1,1)./dxlarge;
     dUdz= diff(U(1:639,1:899,1:120),1,3)./dzlarge; 
     dUdy= diff(U(1:639,1:900,1:119),1,2)/111.11;
     
     dWdx= diff(W(1:640,1:899,1:119),1,1)./dxlarge;
     dWdz= diff(W(1:639,1:899,1:120),1,3)./dzlarge;
     dWdy= diff(W(1:639,1:900,1:119),1,2)/111.11;

     velocityprime = sq(nanmean(uprime.^2+vprime.^2+wprime.^2,2));
     MKE(j,:) = (.5./depth).*nansum((sq(Umean).^2+sq(Vmean).^2+sq(Wmean).^2).*lengthz,2);
     EKE(j,:) = (.5./depth).*nansum(velocityprime.*lengthz,2);

     PEtot=sq(nanmean(9.81*Z.*density,2));
     %PE=(1./(1027.8*depth)).*nansum(PEtot.*lengthz,2);
    
     PEdiff =PEtot-sq(densityinit(:,1,:)).*sq(Z(:,1,:)).*9.81;
     PEd(j,:) = (1./(1027.8*depth)).*nansum(PEdiff.*lengthz,2);
     CPE_KE(j,:)=(-9.81./(1027.8*depth)).*nansum(sq(nanmean(W.*(density-densityinit),2)).*lengthz,2);
     CPE_MKE(j,:)=(-9.81./(1027.8*depth)).*nansum(sq(Wmean.*nanmean(density-densityinit,2)).*lengthz,2);
     CPE_EKE(j,:)=(-9.81./(1027.8*depth)).*nansum(sq(nanmean(wprime.*densityprime,2)).*lengthz,2);
%     
    term1=nanmean(uprime.*vprime,2); term2=nanmean(wprime.*vprime,2); term3=nanmean(uprime.*uprime,2);
    term4=nanmean(wprime.*uprime,2); term5=nanmean(uprime.*wprime,2); term6=nanmean(wprime.*wprime,2);
    CMKE_EKEstep= nanmean(dVdx,2).*term1(1:639,:,1:119)+nanmean(dVdz,2).*term2(1:639,:,1:119)+nanmean(dUdx,2).*term3(1:639,:,1:119)+...
        nanmean(dUdz,2).*term4(1:639,:,1:119)+nanmean(dWdx,2).*term5(1:639,:,1:119)+nanmean(dWdz,2).*term6(1:639,:,1:119);
    CMKE_EKE(j,:)=-(1./depths(1:639)).*nansum(sq(CMKE_EKEstep).*lengthz(1:639,1:119),2);
    CKE_DISSstep=2.5*(dUdx.^2+dVdx.^2+dWdx.^2+dUdy.^2+dVdy.^2+dWdy.^2)+0.01*(dUdz.^2+dVdz.^2+dWdz.^2);
    CKE_DISS(j,:) = (1./depths(1:639)).*nansum(sq(nanmean(CKE_DISSstep,2)).*lengthz(1:639,1:119),2);
    i
KEt(:,j)=nanmean(0.5*(sq(Umean).^2+sq(Vmean).^2+sq(Wmean).^2),2); 
end  

figure(1)
plot(XC,nanmean(PEd),'k'); grid on; hold on;
plot(XC,nanmean(MKE+EKE),'b'); 
plot(XC,nanmean(MKE),'r'); 
plot(XC,nanmean(EKE),'Color',[0 0.7 0]);
legend('PE relative to initial','Total KE','MKE','EKE')
xlabel('X Distance (m)')
ylabel('Energy/mass [m^2/s^2]')
title('Original forcing')
xlim([0 75000])


figure(2)
plot(XC/1000,movmean(nanmean(CPE_KE(:,:)),25),'Color',[.8 .2 .47],'Linewidth',2); grid on; hold on;
plot(XC(1:639)/1000,movmean(nanmean(CKE_DISS(:,:)),25),'Color','k','Linewidth',2)
%plot(XC,nanmean(CPE_KE),'b'); grid on; hold on;
%plot(XC(1:639),nanmean(CKE_DISS),'Color','k')
legend('Conversion of PE to KE','Conversion of KE to DISS')
xlabel('X Distance (km)')
ylabel('Energy/mass/second [m^2/s^3]')
title('Original forcing')
xlim([0 75])

figure(3)
%plot(XC(1:639),nanmean(CMKE_EKE),'Color','b'); grid on; hold on;
%plot(XC,nanmean(CPE_MKE),'r')
%plot(XC,nanmean(CPE_EKE),'Color',[0 0.7 0])
plot(XC(1:639),movmean(nanmean(CMKE_EKE),10),'Color','b'); grid on; hold on;
plot(XC,movmean(nanmean(CPE_MKE),10),'r')
plot(XC,movmean(nanmean(CPE_EKE),10),'Color',[0 0.7 0])
legend('Shear production, MKE to EKE','Conversion of PE to MKE','Conversion of PE to EKE')
xlabel('X Distance (m)')
ylabel('Energy/mass/second [m^2/s^3]')
title('Original forcing')
xlim([0 75000])





















