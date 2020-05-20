clear all
close all
load z.mat
load topo.mat; topo=-topo;
load XC.mat
%creating old grid matrices and new, regular grid matrices for interp:
XCmat = repmat(XC,1,240);
XCnew = repmat(linspace(0,74975,3000)',1,834);
zmat = repmat(z',1280,1);
znew = repmat(linspace(0,-2499,834),3000,1);
%new arrays of z and x coordinates:
zarray = linspace(0,-2499,834);
xcarray = linspace(0,74975,3000);
%
for i = 52;
    if i>=1 && i<=80
        W=sq(ncread('Double1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('Double1.nc','V',[1 1 1 i],[Inf Inf Inf 1]),2));
        U=sq(ncread('Double1.nc','U',[1 1 1 i],[1280 Inf Inf 1]));
    elseif i>=81 && i<=160
        W=sq(ncread('Double2.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('Double2.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]),2));
        U=sq(ncread('Double2.nc','U',[1 1 1 i-80],[1280 Inf Inf 1]));  
    elseif i>=161 && i<=240
        W=sq(ncread('Double3.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
        V=sq(nanmean(ncread('Double3.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]),2));
        U=sq(ncread('Double3.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]));
    end
end
Wr = interp2(XCmat',zmat',W',XCnew',znew')';
Wr(isnan(Wr))=0;    
Ur = interp2(XCmat',zmat',U',XCnew',znew')';
Ur(isnan(Ur))=0;
Vr = interp2(XCmat',zmat',V',XCnew',znew')';
Vr(isnan(Vr))=0;
a = [xcarray(1664)/1000 xcarray(3000)/1000]; b = [zarray(668) zarray(552)];     
%putting line into grid
linegrid = zeros(3000,834);
tx=linspace(1664,3000,1337);
tz=linspace(668,552,1337);
for index = 1:1337;
    linegrid(tx(index),round(tz(index)))=1;
    linegrid(tx(index),round(tz(index))-1)=1;
    linegrid(tx(index),round(tz(index))+1)=1;
    linegrid(tx(index),round(tz(index))-2)=1;
    linegrid(tx(index),round(tz(index))+2)=1;
    linegrid(tx(index),round(tz(index))-3)=1;
    linegrid(tx(index),round(tz(index))+3)=1;    
end
Ut=sq(Ur.*linegrid); 
Uextract = nanmean(Ut,2); Uextract(isnan(Uextract))=0;
Wt=sq(Wr.*linegrid);
Wextract = nanmean(Wt,2); Wextract(isnan(Wextract))=0;
Vt = sq(Vr.*linegrid);
Vextract = nanmean(Vt,2); Vextract(isnan(Vextract))=0;
wavenumber=0:(1/25)/3000:(1/25)/2; 

signal=sqrt(Uextract.^2+Wextract.^2+Vextract.^2);
DFT=fft(signal);
DFT=DFT(1:1501);
PSD = (25/3000)*abs(real(DFT)).^2;
PSD(2:end-1)=2*PSD(2:end-1);
[pxx,w] = pwelch(Uextract,hanning(1000),250,1000,1/25);%pwelch(Uextract,500,100,500,1/25);

figure(101)
loglog(1./wavenumber,PSD,'b')
xlabel('Wavelength m'); ylabel('Power/wavenumber');
title('Periodogram power spectral density estimate U')
set(gca,'XDir','reverse'); grid on;
hold on;
loglog(1./w,pxx,'r','Linewidth',1)

% figure(102)
load day11.mat; load day13.mat; load day30.mat; load day60.mat;
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

figure(103)
loglog(1./w,day11,'Color',[1 .65 0],'Linewidth',2);
set(gca,'Fontsize',12);
xlabel('Wavelength, m','Fontsize',16); ylabel('Power/wavenumber','Fontsize',16);
title('Welch''s power spectral density estimate'); 
set(gca,'XDir','reverse'); grid on;
hold on
loglog(1./w,day13,'Color',[1 0 0],'Linewidth',2);
loglog(1./w,day30,'Color',[0.5 0 0.5],'Linewidth',2);
loglog(1./w,day60,'Color',[0 0.5 .8],'Linewidth',2);
legend({'11 days','13 days','30 days','60 days'},'Fontsize',10);
ylim([1e-7 1e-1]);

figure(1)
pcolor(xcarray/1000,zarray,Vr'); shading flat
caxis([-0.2 1]); colorbar;
colormap('bluewhitered')
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
line(a,b,'Linewidth',2,'Color','k');
h = colorbar; title(h,'m/s');
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Alongshore Velocity (V)','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);
    


figure(3)
pcolor(xcarray/1000,zarray,Wr'); shading flat
caxis([-0.01 0.01]); colorbar;
colormap('bluewhitered')
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
h = colorbar; title(h,'m/s');
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Vertical Velocity (W)','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);
line(a,b,'Linewidth',2,'Color','k');

figure(4)
pcolor(xcarray/1000,zarray,Ur'); shading flat
caxis([-.06 0.06]); colorbar;
colormap('bluewhitered')
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
h = colorbar; title(h,'m/s');
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Offshore Velocity (U)','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);
line(a,b,'Linewidth',2,'Color','k')

figure(5)
pcolor(xcarray/1000,zarray,linegrid'); shading flat
caxis([0 1]); colorbar;
colormap('bluewhitered')
hold on;
area(XC/1000,topo,-2500,'Facecolor',[.8 .8 .8])
h = colorbar; title(h,'m/s');
set(gca,'Fontsize',14)
xlabel('X Position (km)','Fontsize',16)
ylabel('Depth (m)','Fontsize',16)
title('Linegrid','Fontsize',16);
ylim([-2500 0]); xlim([0 75]);

