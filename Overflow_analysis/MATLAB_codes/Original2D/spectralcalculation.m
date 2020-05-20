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

xcarray2=xcarray;
zarray2=linspace(0,-2500,101);
XC2 = repmat(linspace(0,74975,3000)',1,100);
z2  = repmat(linspace(0,-2475,100),3000,1);

for i = 20;
   
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
%Ur(:,20:834)=0; Wr(:,20:834)=0;

Wr2 = interp2(XCmat',zmat',W',XC2',z2'); Wr2(isnan(Wr2))=0;
Ur2 = interp2(XCmat',zmat',U',XC2',z2'); Ur2(isnan(Ur2))=0;

for j = 1:834  
    signal1 = squeeze(sqrt(Ur(:,j).^2+Wr(:,j).^2));
    %signal1 = squeeze(Ur(:,j));
    DFTx = fft(signal1');
    DFTx = DFTx(1:1501);
    PSDx1 = (25/3000)*abs(real(DFTx)).^2; %by matlab it's 25/3000
    PSDx1(2:end-1) = 2*PSDx1(2:end-1);
    PSDx(j,:)= PSDx1;

end
for k = 1:3000
    signal2 = squeeze(sqrt(Ur(k,:).^2+Wr(k,:).^2));
    %signal2 = squeeze(Ur(k,:));
    DFTz = fft(signal2);
    DFTz = DFTz(1:418);
    PSDz1 = (3/834)*abs(real(DFTz)).^2; %by matlab it's 3/834
    PSDz1(2:end-1) = 2*PSDz1(2:end-1);
    PSDz(k,:)= PSDz1;
    
end

%Performing Fourier transform on U and x and periodogram calculation IN WAVENUMBER


% figure(101)
% loglog(1./wavenumberx,nanmean(PSDx),'b');
% %Performing Fourier transform on U and z and periodogram calculation IN WAVENUMBER
% hold on
% %loglog(1./wavenumberz,(PSDz(1550,:)),'r');
% loglog(1./wavenumberz,nanmean(PSDz),'r');
% xlabel('Wavelength m'); ylabel('Power/wavenumber (dB*m)');
% title('Average Periodogram power spectral density estimate U')
% set(gca,'XDir','reverse')
% legend('X slice spectrum','Z slice spectrum')
% set(gcf,'units','points','position',[50,50,500,300])
% grid on
% 
% figure(102)
% loglog(1./wavenumberx,PSDx(500,:),'b');
% %Performing Fourier transform on U and z and periodogram calculation IN WAVENUMBER
% hold on
% loglog(1./wavenumberz,(PSDz(1550,:)),'r');
% xlabel('Wavelength m'); ylabel('Spectral density m^3/s^2'); %ylabel('Power/wavenumber (dB*m)');
% title('Slope Periodogram power spectral density estimate U')
% set(gca,'XDir','reverse')
% legend('X slice spectrum','Z slice spectrum')
% set(gcf,'units','points','position',[50,50,500,300])
% grid on
% 
% 
% figure(103)
% loglog(1./wavenumberx,smooth(PSDx(500,:),5),'b');
% %loglog(1./wavenumberx,nanmean(PSDx),'b');
% %Performing Fourier transform on U and z and periodogram calculation IN WAVENUMBER
% hold on
% loglog(1./wavenumberz,smooth(PSDz(1550,:),5),'r');
% %loglog(1./wavenumberz,nanmean(PSDz),'r');
% xlabel('Wavelength m'); ylabel('Spectral density m^3/s^2'); %ylabel('Power/wavenumber (dB*m)');
% title('Smoothed Slope Periodogram power spectral density estimate U')
% set(gca,'XDir','reverse')
% legend('X slice spectrum','Z slice spectrum')
% set(gcf,'units','points','position',[50,50,500,300])
% grid on

% figure(104)
% loglog(1./wavenumberx,nanmean(PSDx(200:800,:)),'b');
% %loglog(1./wavenumberx,nanmean(PSDx),'b');
% title('Periodogram power spectral density estimate U')
% 
% %Performing Fourier transform on U and z and periodogram calculation IN WAVENUMBER
% hold on
% loglog(1./wavenumberz,nanmean(PSDz(1400:1600,:)),'r');
% %loglog(1./wavenumberz,nanmean(PSDz),'r');
% xlabel('Wavelength m'); ylabel('Spectral density m^3/s^2');%ylabel('Power/wavenumber (dB*m)');
% title('Slope Average Periodogram power spectral density estimate U')
% set(gca,'XDir','reverse')
% legend('X slice spectrum','Z slice spectrum')
% set(gcf,'units','points','position',[50,50,500,300])
% grid on

% 
[N M]=size(Ur);
imgf = fftshift(fft2(sqrt(Ur.^2+Wr.^2)));
imgfp = (abs(imgf)).^2*1/(25*3000*3*834); 
wavenumberxx = (1/25)*((-1500:1499)/3000);
meshx = repmat(wavenumberxx',1,834);
wavenumberzz = (1/3)*((-417:416)/834);
meshz = repmat(wavenumberzz,3000,1);

var1 = sqrt(meshx.^2+meshz.^2);
var2 = reshape(var1,1,[]); var2 = 1./var2;
var2(var2==Inf)=75000;
var3 = reshape(imgfp,1,[]);
%SET BINS FOR RADIAL AVERAGING
%bins = linspace(0,5,1280);
%bins = bins.^10;
bins = linspace(0,100000,3000);
for l=1:length(bins)-1;
    value(l) = nansum(var3(var2>=bins(l) & var2<bins(l+1)));
end
figure(108)
pcolor(1./wavenumberxx,1./wavenumberzz,abs((imgfp')))
shading flat
%xlim([0 0.02]); ylim([0 .1663]);
colormap(bluewhitered)
caxis([ 0 0.000001])
figure(105)
loglog(var2,var3,'*','Markersize',0.2); xlabel('Wavelength, m'); ylabel('Spectral density m^3/s^2');
title('2D Periodogram power spectral density estimate sqrt(W^2+U^2)');
set(gca,'XDir','reverse'); grid on;
a = [var2; var3];
b=sortrows(a')';

figure(106)
loglog(b(1,:),b(2,:),'*'); xlabel('Wavelength, m'); ylabel('Spectral density m^3/s^2');
title('2D Periodogram power spectral density estimate sqrt(W^2+U^2)');
set(gca,'XDir','reverse'); grid on;

figure(107)
loglog(bins(1:length(bins)-1),value,'-*','Markersize',1); xlabel('Wavelength, m'); ylabel('Spectral density m^3/s^2');
title('2D Periodogram power spectral density estimate sqrt(W^2+U^2)');
set(gca,'XDir','reverse'); grid on;
set(gcf,'units','points','position',[50,50,500,300])
ylim([1e-12 1e-2])
% 
end


% figure(501)
%      pcolor(XC,z,U'); shading flat; title('U');
%      hold on; grid on;
%      area(XC,topo,-2500,'Facecolor',[.8 .8 .8])  
%      caxis([-0.01 0.01]); colormap(bluewhitered); colorbar;
% figure(502)
%      pcolor(XC,z,W'); shading flat; title('W');
%      hold on; grid on;
%      area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
%      caxis([-0.001 0.001]); colormap(bluewhitered); colorbar;
% figure(503)
%      pcolor(XC,z,sqrt(W'.^2+U'.^2)); shading flat; title('(U^2+W^2)^{0.5}');
%      hold on; grid on;
%      area(XC,topo,-2500,'Facecolor',[.8 .8 .8]) 
%      caxis([0 0.05]); colormap(bluewhitered); colorbar;







