clear all
close all
load z.mat
load topo.mat; topo=-topo;
load XC.mat
%creating old grid matrices and new, regular grid matrices for interp:
XCmat = repmat(XC,1,120);
XCnew = repmat(linspace(0,74975,3000)',1,834);
zmat = repmat(z',640,1);
znew = repmat(linspace(0,-2499,834),3000,1);
%new arrays of z and x coordinates:
zarray = linspace(0,-2499,834);
xcarray = linspace(0,74975,3000);

a = [xcarray(1664)/1000 xcarray(3000)/1000]; b = [zarray(668) zarray(552)];     
%putting line into grid
linegrid = zeros(3000,834);
tx=linspace(1664,3000,1337);
tz=linspace(668,552,1337);
for index = 1:1337;
    linegrid(tx(index),round(tz(index)))=1;
%     linegrid(tx(index),round(tz(index))-1)=1;
%     linegrid(tx(index),round(tz(index))+1)=1;
%     linegrid(tx(index),round(tz(index))-2)=1;
%     linegrid(tx(index),round(tz(index))+2)=1;
%     linegrid(tx(index),round(tz(index))-3)=1;
%     linegrid(tx(index),round(tz(index))+3)=1;    
end

for j = 1:900;
for i = 40;
   
    if i>=1 && i<=40
        W=sq(ncread('Original1.nc','W',[1 j 1 i],[Inf 1 Inf 1]));
        V=sq(nanmean(ncread('Original1.nc','V',[1 j 1 i],[Inf 1 Inf 1]),2));
        U=sq(ncread('Original1.nc','U',[1 j 1 i],[640 1 Inf 1]));
        Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 j 1 i],[Inf 1 Inf 1]));
    elseif i>=41 && i<=80
        W=sq(ncread('Original2.nc','W',[1 j 1 i-40],[Inf 1 Inf 1]));
        V=sq(nanmean(ncread('Original2.nc','V',[1 j 1 i-40],[Inf 1 Inf 1]),2));
        U=sq(ncread('Original2.nc','U',[1 j 1 i-40],[640 1 Inf 1]));
        Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 j 1 i-40],[Inf 1 Inf 1]));      
    elseif i>=81 && i<=120
        W=sq(ncread('Original3.nc','W',[1 j 1 i-80],[Inf 1 Inf 1]));
        V=sq(nanmean(ncread('Original3.nc','V',[1 j 1 i-80],[Inf 1 Inf 1]),2));
        U=sq(ncread('Original3.nc','U',[1 j 1 i-80],[640 1 Inf 1]));
        Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 j 1 i-80],[Inf 1 Inf 1]));  
    elseif i>=121 && i<=160
        W=sq(ncread('Original4.nc','W',[1 j 1 i-120],[Inf 1 Inf 1]));
        V=sq(nanmean(ncread('Original4.nc','V',[1 j 1 i-120],[Inf 1 Inf 1]),2));
        U=sq(ncread('Original4.nc','U',[1 j 1 i-120],[640 1 Inf 1]));
        Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 j 1 i-120],[Inf 1 Inf 1]));
    elseif i>=161 && i<=200
        W=sq(ncread('Original5.nc','W',[1 j 1 i-160],[Inf 1 Inf 1]));
        V=sq(nanmean(ncread('Original5.nc','V',[1 j 1 i-160],[Inf 1 Inf 1]),2));
        U=sq(ncread('Original5.nc','U',[1 j 1 i-160],[640 1 Inf 1]));
        Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 j 1 i-160],[Inf 1 Inf 1]));  
    elseif i>=201 && i<=240
        W=sq(ncread('Original6.nc','W',[1 j 1 i-200],[Inf 1 Inf 1]));
        V=sq(nanmean(ncread('Original6.nc','V',[1 j 1 i-200],[Inf 1 Inf 1]),2));
        U=sq(ncread('Original6.nc','U',[1 j 1 i-200],[640 1 Inf 1]));
        Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 j 1 i-200],[Inf 1 Inf 1])); 
    end
end
Wr = interp2(XCmat',zmat',W',XCnew',znew')';
Wr(isnan(Wr))=0;    
Ur = interp2(XCmat',zmat',U',XCnew',znew')';
Ur(isnan(Ur))=0;
Vr = interp2(XCmat',zmat',V',XCnew',znew')';
Vr(isnan(Vr))=0;

Ut=sq(Ur.*linegrid); 
Uextract = nanmean(Ut,2); Uextract(isnan(Uextract))=0;
Wt=sq(Wr.*linegrid);
Wextract = nanmean(Wt,2); Wextract(isnan(Wextract))=0;
Vt = sq(Vr.*linegrid);
Vextract = nanmean(Vt,2); Vextract(isnan(Vextract))=0;
 
signalU(j,:)=Uextract;
signalV(j,:)=Vextract;
signalW(j,:)=Wextract;
signalT(j,:)=sqrt(Uextract.^2+Wextract.^2+Vextract.^2);
j
end

figure
pcolor(xcarray,111.111:111.111:99999.9,signalT); shading flat; colormap('bluewhitered');
xlabel('X Position (m)'); ylabel('Y Position (m)');
title('Total velocity (m/s) along spectrum slice'); colorbar; box on;

wavenumberx=0:1/25/3000:1/25/2;
wavenumbery=0:1/111.111/900:1/111.111/2;
imgf=fftshift(fft2(signal240));
imgfp=abs(imgf).^2*1/(25*3000*111.111*900);
wavenumberxx=(1/25)*((-1500:1499)/3000);
meshx=flipud(repmat(wavenumberxx',1,900));
wavenumberyy=(1/111.111)*((-450:449)/900);
meshy=repmat(wavenumberyy,3000,1);

var1 = sqrt(meshx.^2+meshy.^2)';
minimum = min(min(var1)); maximum = max(max(var1));
bins = linspace(minimum,maximum,2000);
for l = 1:length(bins)-1;
    energy(l) = nansum(imgfp(var1>=bins(l) & var1<bins(l+1)));
    
end
figure
loglog(1./bins(1:1999),energy(1:1999))
set(gca,'XDir','reverse'); grid on;
xlabel('Wavelength m'); ylabel('Energy');
ylim([1e-20 1e0]);
title('Total velocity spectrum');

% figure(103)
% load day5T.mat; load day10T.mat; 
% load day18T.mat; load day20T.mat; load day30T.mat; load day60T.mat;
% loglog(1./bins(1:470),(day5T),'Color',[0 0 .5],'Linewidth',2);
% set(gca,'Fontsize',12);
% xlabel('Wavelength, m','Fontsize',16); ylabel('Energy','Fontsize',16);
% title('Total velocity spectrum'); 
% set(gca,'XDir','reverse'); grid on;
% hold on
% loglog(1./bins(1:470),(day10T),'Color',[0 .5 0],'Linewidth',2);
% loglog(1./bins(1:470),smooth(day18T),'Color',[1 .65 0],'Linewidth',2);
% loglog(1./bins(1:470),smooth(day20T),'Color',[1 0 0],'Linewidth',2);
% loglog(1./bins(1:470),smooth(day30T),'Color',[0.5 0 0.5],'Linewidth',2);
% loglog(1./bins(1:470),smooth(day60T),'Color',[0 0.5 .8],'Linewidth',2);
% legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Fontsize',10);
% ylim([1e-15 1e0]);
%wavenumber=0:(1/25)/3000:(1/25)/2;
% DFT=fft(signal);
% DFT=DFT(1:1501);
% PSD = (25/3000)*abs(real(DFT)).^2;
% PSD(2:end-1)=2*PSD(2:end-1);
% [pxx,w] = pwelch(Uextract,hanning(1000),250,1000,1/25);%pwelch(Uextract,500,100,500,1/25);
% 
% figure(101)
% loglog(1./wavenumber,PSD,'b')
% xlabel('Wavelength m'); ylabel('Power/wavenumber');
% title('Periodogram power spectral density estimate U')
% set(gca,'XDir','reverse'); grid on;
% hold on;
% loglog(1./w,pxx,'r','Linewidth',1)

% figure(102)
% load day5.mat; load day10.mat; load day18.mat; load day20.mat; load day30.mat; load day60.mat;
% loglog(1./w,day5,'Color',[0 0 .5]);
% set(gca,'Fontsize',12);
% xlabel('Wavelength, m','Fontsize',16); ylabel('Power/wavenumber','Fontsize',16);
% title('Welch''s power spectral density estimate'); 
% set(gca,'XDir','reverse'); grid on;
% hold on
% loglog(1./w,day10,'Color',[0 .5 0]);
% loglog(1./w,day18,'Color',[1 .65 0]);
% loglog(1./w,day20,'Color',[1 0 0]);
% loglog(1./w,day30,'Color',[0.5 0 0.5]);
% loglog(1./w,day60,'Color',[0 0.5 .8]);
% legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Fontsize',10);
% 
% figure(103)
% loglog(1./w,day18,'Color',[1 .65 0],'Linewidth',2);
% set(gca,'Fontsize',12);
% xlabel('Wavelength, m','Fontsize',16); ylabel('Power/wavenumber','Fontsize',16);
% title('Welch''s power spectral density estimate'); 
% set(gca,'XDir','reverse'); grid on;
% hold on
% loglog(1./w,day20,'Color',[1 0 0],'Linewidth',2);
% loglog(1./w,day30,'Color',[0.5 0 0.5],'Linewidth',2);
% loglog(1./w,day60,'Color',[0 0.5 .8],'Linewidth',2);
% legend({'18 days','20 days','30 days','60 days'},'Fontsize',10);
% ylim([1e-7 1e-1])
% % %EQUIVALENT CALCULATION USING PSD:
% % [test1,test2]=psd(Uextract,3000,1/25,hanning(3000));
% % test1(2:end-1)=test1(2:end-1)*2;
% % test1 = test1*25;
% % loglog(1./test2,test1,'g')
% 
% figure(1)
% pcolor(xcarray/1000,zarray,Vr'); shading flat
% caxis([-0.2 1]); colorbar;
% colormap('bluewhitered')
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
% line(a,b,'Linewidth',2,'Color','k');
% h = colorbar; title(h,'m/s');
% set(gca,'Fontsize',14)
% xlabel('X Position (km)','Fontsize',16)
% ylabel('Depth (m)','Fontsize',16)
% title('Alongshore Velocity (V)','Fontsize',16);
% ylim([-2500 0]); xlim([0 75]);
%     
figure(2)
pcolor(XC/1000,z,Tracer'); shading flat
caxis([0 1]); colorbar;
colormap('bluewhitered')
hold on
area(XC/1000,-topo,-2500,'Facecolor',[.8 .8 .8])
line(a,b,'Linewidth',2,'Color','k');
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Tracer Concentration','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);
% 
% figure(3)
% pcolor(xcarray/1000,zarray,Wr'); shading flat
% caxis([-0.01 0.01]); colorbar;
% colormap('bluewhitered')
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
% h = colorbar; title(h,'m/s');
% set(gca,'Fontsize',14)
% xlabel('X Position (km)','Fontsize',16)
% ylabel('Depth (m)','Fontsize',16)
% title('Vertical Velocity (W)','Fontsize',16);
% ylim([-2500 0]); xlim([0 75]);
% line(a,b,'Linewidth',2,'Color','k');
% 
% figure(4)
% pcolor(xcarray/1000,zarray,Ur'); shading flat
% caxis([-.06 0.06]); colorbar;
% colormap('bluewhitered')
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
% h = colorbar; title(h,'m/s');
% set(gca,'Fontsize',14)
% xlabel('X Position (km)','Fontsize',16)
% ylabel('Depth (m)','Fontsize',16)
% title('Offshore Velocity (U)','Fontsize',16);
% ylim([-2500 0]); xlim([0 75]);
% line(a,b,'Linewidth',2,'Color','k')
% 
% figure(5)
% pcolor(xcarray/1000,zarray,linegrid'); shading flat
% caxis([0 1]); colorbar;
% colormap('bluewhitered')
% hold on;
% area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
% h = colorbar; title(h,'m/s');
% set(gca,'Fontsize',14)
% xlabel('X Position (km)','Fontsize',16)
% ylabel('Depth (m)','Fontsize',16)
% title('Linegrid','Fontsize',16);
% ylim([-2500 0]); xlim([0 75]);

