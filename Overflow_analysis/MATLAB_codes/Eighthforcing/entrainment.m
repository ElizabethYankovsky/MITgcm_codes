clear all
close all
load z.mat
load dz.mat
load dx.mat
load XC.mat
z = z-z(1);
% ZC=z-z(1);
% YC=111.111:111.111:99999.9;
% XC=ncread('Original1.nc','X');

dz = dz;
dx = dx;
dy = 111.11;

area=dy*dz;



i=240
U=sq(ncread('Double3.nc','U',[1 1 1 i-160],[1280 Inf Inf 1]))';
tracer=sq(ncread('Tracer3.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]))'; 
    for j = 1:1280
        traceri = sq(tracer(:,j));
        Ui = sq(U(:,j));
        Transport(j) = nansum(area(traceri>=0.01).*Ui(traceri>=0.01)) ;
        
        Ubar(j) = Transport(j)/(nansum(area(traceri>=0.01)));
    

    end
   

g = gausswin(240); % <-- this value determines the width of the smoothing window
g = g/sum(g);
Tsmooth = conv(Transport, g, 'same');
alphae=diff(Tsmooth)./(nanmean(Ubar)*111.11*dx(1:1279)');






% plotbins = bins(1:length(bins)-1)+(bins(2)-bins(1))/2;
% % 
% figure(1)
% subplot(2,1,1)
% bar(plotbins,nansum(Ffinal1,1),'hist');
% set(gca,'XTick',bins(1:4:end),'Fontsize',8);
% xlim([bins(1) bins(end)])
% xlabel('Density (kg/m^3)','Fontsize',10);
% ylabel('Integrated in time flux, km^3','Fontsize',8);
% title('Region 1-2','Fontsize',10);
% grid on;
% 
% subplot(2,1,2)
% bar(plotbins,nansum(Ffinal2,1),'hist');
% set(gca,'XTick',bins(1:4:end),'Fontsize',8);
% xlim([bins(1) bins(end)])
% xlabel('Density (kg/m^3)','Fontsize',10);
% ylabel('Integrated in time flux, (km^3)','Fontsize',8); grid on;
% title('Region 2-3','Fontsize',10);