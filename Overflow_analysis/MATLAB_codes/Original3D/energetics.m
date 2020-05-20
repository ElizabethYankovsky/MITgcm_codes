clear all
close all

load dx.mat
load dz.mat

dzmat = repmat(dz',640,1);
dxmat = repmat(dx,1,120);
fraction=sq(ncread('grid.nc','HFacC',[1 1 1],[Inf 1 Inf]));
area = dxmat.*dzmat.*fraction;
area200 = sum(nansum(area(1:200,1:120)));
area200s = sum(nansum(area(1:200,1:119)));
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
densityinit = densmdjwf(Sinit(1:200,:,:),Tinit(1:200,:,:),zeros(200,900,120));
%densityinit = nanmean(nanmean(densityinit(1:135,1:3)));

ZC = ncread('grid.nc','Z');
Z = repmat(ZC,1,640,900);
Z = permute(-Z,[2 3 1]);
Z = Z(1:200,:,:);

for i =1%:240;
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
    Umean = (nanmean(U(1:200,:,:),2));
    Vmean = (nanmean(V(1:200,:,:),2));
    Wmean = (nanmean(W(1:200,:,:),2));
    %computing u',v',w' and dU/d(x,y) dV/d(x,y) dW/d(x,y) for later
    %alongshore averaging. In the loop we calculate quantitues at each y
    %point, averaging applied outside for generality to nonlinear
    %situations.
     for j = 1:900
        uprime(1:200,j,:) = U(1:200,j,:)-Umean;
        vprime(1:200,j,:) = V(1:200,j,:)-Vmean;
        wprime(1:200,j,:) = W(1:200,j,:)-Wmean;   
    end
     dxlarge = repmat(dx(1:200),1,899,119);
     dzlarge = permute(repmat(dz(1:119),1,200,899),[2 3 1]);
     dVdx= diff(V(1:201,1:899,1:119),1,1)./dxlarge; 
     dVdz= diff(V(1:200,1:899,1:120),1,3)./dzlarge; 
     dVdy= diff(V(1:200,1:900,1:119),1,2)/111.11;
     
     dUdx= diff(U(1:201,1:899,1:119),1,1)./dxlarge;
     dUdz= diff(U(1:200,1:899,1:120),1,3)./dzlarge; 
     dUdy= diff(U(1:200,1:900,1:119),1,2)/111.11;
     
     dWdx= diff(W(1:201,1:899,1:119),1,1)./dxlarge;
     dWdz= diff(W(1:200,1:899,1:120),1,3)./dzlarge;
     dWdy= diff(W(1:200,1:900,1:119),1,2)/111.11;

    velocityprime = sq(nanmean(uprime.^2+vprime.^2+wprime.^2,2));
    MKE(i) = (.5/area200)*sum(nansum((sq(Umean).^2+sq(Vmean).^2+sq(Wmean).^2).*area(1:200,:)));
    EKE(i) = (.5/area200)*sum(nansum(velocityprime.*area(1:200,:)));
    density = densmdjwf(S(1:200,:,:),T(1:200,:,:),zeros(200,900,120));
   PEtot=sq(nanmean(9.81*Z.*density,2));
   PE(i)=(1/(1027.8*area200))*sum(nansum(PEtot.*area(1:200,:)));
    
   PEdiff =PEtot-densityinit(1:200,:).*sq(Z(:,1,:)).*9.81;
   PEd(i) = (1/(1027.8*area200))*nansum(nansum(PEdiff.*area(1:200,:)));
%     CPE_KE(i)=(-9.81/(1027.8*area200))*nansum(nansum(sq(nanmean(W(1:200,:,:).*(density-densityinit),2)).*area(1:200,:)));
%     CKE_DISSstep=2.5*(dUdx.^2+dVdx.^2+dWdx.^2+dUdy.^2+dVdy.^2+dWdy.^2)+0.01*(dUdz.^2+dVdz.^2+dWdz.^2);
%     CKE_DISS(i) = (1/area200s)*sum(nansum(sq(nanmean(CKE_DISSstep,2)).*area(1:200,1:119)));
%     i

end  








