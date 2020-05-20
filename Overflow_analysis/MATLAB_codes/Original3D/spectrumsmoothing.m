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
end

load signal240.mat; load signal120.mat; load signal20.mat; load signal72.mat
load signalU240.mat; load signalU120.mat; load signalU20.mat;load signalU72.mat
load signalW240.mat; load signalW120.mat; load signalW20.mat; load signalW72.mat
load signalV240.mat; load signalV120.mat; load signalV20.mat; load signalV72.mat

load signal80.mat; load signalU80.mat; load signalV80.mat; load signalW80.mat; 
load signal40.mat; load signalU40.mat; load signalV40.mat; load signalW40.mat;

figure
pcolor(xcarray,111.111:111.111:99999.9,signal240); shading flat; colormap('bluewhitered');
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
bins = linspace(minimum,maximum,1500);

for l = 1:length(bins)-1;
   energy(l) = nanmean(imgfp(var1>=bins(l) & var1<bins(l+1)));
    
end
figure
loglog(1./bins(1:1499),energy(1:1499),'*','Markersize',2)
set(gca,'XDir','reverse'); grid on;
xlabel('Wavelength m'); ylabel('Energy');
ylim([1e-15 1e0]);
title('Total velocity spectrum');
hold on; 
%1:25 for smaller and 1:5 for bigger, 60 window
energy2 = [energy(1:25) smooth(energy(26:1400),20)'];
loglog(1./bins(1:1400),(energy2(1:1400)),'r','Linewidth',2)

figure
loglog(1./bins(1:1400),(energy2(1:1400)),'r','Linewidth',2)
set(gca,'XDir','reverse'); grid on;
xlabel('Wavelength m'); ylabel('Energy');
ylim([1e-13 1e0]);
title('Total spectrum');
hold on; 
%1:25 for smaller and 1:5 for bigger, 60 window

figure(103)
load day5T.mat; load day10T.mat; 
load day18T.mat; load day20T.mat; load day30T.mat; load day60T.mat;
loglog(1./bins(1:1400),(day5T),'Color',[0 0 .5],'Linewidth',2);
set(gca,'Fontsize',12);
xlabel('Wavelength, m','Fontsize',16); ylabel('Energy','Fontsize',16);
title('W velocity spectrum'); 
set(gca,'XDir','reverse'); grid on;
hold on
loglog(1./bins(1:1400),(day10T),'Color',[0 .5 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day18T),'Color',[1 .65 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day20T),'Color',[1 0 0],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day30T),'Color',[0.5 0 0.5],'Linewidth',2);
loglog(1./bins(1:1400),smooth(day60T),'Color',[0 0.5 .8],'Linewidth',2);
legend({'5 days','10 days','18 days','20 days','30 days','60 days'},'Fontsize',10);
ylim([1e-17 1e0]);


