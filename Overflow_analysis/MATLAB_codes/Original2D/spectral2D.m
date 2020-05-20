clear all
close all
load topo.mat; topo=-topo;
load XC.mat
load z.mat
XCmat = repmat(XC,1,240);
XCnew = repmat(linspace(0,74975,3000)',1,834);

zmat = repmat(z',1280,1);
znew = repmat(linspace(0,-2499,834),3000,1);
zarray = linspace(0,-2499,834);
xcarray = linspace(0,74975,3000);



for i =2;
   
    if i>=1 && i<=40
        W=sq(ncread('HR1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        U=sq(ncread('HR1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
     %   V=sq(nanmean(ncread('HR1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
    elseif i>=41 && i<=80
        W=sq(ncread('HR2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
        U=sq(ncread('HR2.nc','U',[1 1 1 i-40],[1280 Inf Inf 1]));
      %  V=sq(nanmean(ncread('HR2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]),2));
    elseif i>=81 && i<=120
        W=sq(ncread('HR3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
     %   V=sq(nanmean(ncread('HR3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('HR3.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));
    elseif i>=121 && i<=160
        W=sq(ncread('HR4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
        U=sq(ncread('HR4.nc','U',[1 1 1 i-120],[1280 Inf Inf 1]));
     %   V=sq(nanmean(ncread('HR4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]),2));
    elseif i>=161 && i<=200
        W=sq(ncread('HR5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        U=sq(ncread('HR5.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
      %  V=sq(nanmean(ncread('HR5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
    elseif i>=201 && i<=240
        W=sq(ncread('HR6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
        U=sq(ncread('HR6.nc','U',[1 1 1 i-200],[1280 Inf Inf 1]));
      %  V=sq(nanmean(ncread('HR6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]),2));
    end
Wr = interp2(XCmat',zmat',W',XCnew',znew')';
Wr(isnan(Wr))=0;    
Ur = interp2(XCmat',zmat',U',XCnew',znew')';
Ur(isnan(Ur))=0;
wavenumberx=0:(1/25)/3000:(1/25)/2;
wavenumberz=0:(1/3)/834:(1/3)/2;




% 
[N M]=size(Ur);
imgf = fftshift(fft2(sqrt(Ur.^2+Wr.^2)));
imgfp = (abs(imgf)).^2*1/(25*3000*3*834); 
wavenumberxx = (1/25)*((-1500:1499)/3000);
meshx = flipud(repmat(wavenumberxx',1,834));
wavenumberzz = (1/3)*((-417:416)/834);
meshz = repmat(wavenumberzz,3000,1);

var1 = sqrt(meshx.^2+meshz.^2);
minimum = min(min(var1)); maximum = max(max(var1));
bins = linspace(minimum,maximum,600);

for l = 1:length(bins)-1;
    energy(l) = nanmean(imgfp(var1>=bins(l) & var1<bins(l+1)));
end

end
figure
loglog(1./bins(1:599),energy(1:599),'*','Markersize',2)
set(gca,'XDir','reverse'); grid on;
xlabel('Wavelength m'); ylabel('Energy');
ylim([1e-15 1e0]);
title('Total velocity spectrum');
hold on; 
%1:25 for smaller and 1:5 for bigger, 60 window
energy2 = [energy(1:2) smooth(energy(3:550),10)'];
loglog(1./bins(1:550),(energy2(1:550)),'r','Linewidth',2)



