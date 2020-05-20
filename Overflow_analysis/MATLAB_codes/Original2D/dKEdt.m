clear all
close all

xc=ncread('grid.nc','XC');
XC = sq(xc(:,1))/1000;
dz = ncread('grid.nc','drF');
dzmat = repmat(dz',1280,1);
fraction=sq(ncread('grid.nc','HFacC',[1 1 1],[Inf 1 Inf]));
lengthz = dzmat.*fraction;

i = 34; %34 229
W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
% W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
% V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
% U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
KE = 0.5*(U.^2+V.^2+W.^2);

for i =35:45; %35:45
    j=i-34;
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
    elseif i>=161 && i<=200
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
    elseif i>=201 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
    end
    

    dKEdt1 = (0.5*(U.^2+V.^2+W.^2)-KE)/21600;
    KE = 0.5*(U.^2+V.^2+W.^2);
    %integrating in z and y
    dKEdt2 = (1./nansum(lengthz,2)).*nansum(dKEdt1.*lengthz,2);
 
    
    dKEdt10(:,j)=dKEdt2;
    
i
end

   plot(XC,nanmean(dKEdt10,2)) 
