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
dy = 111.111;

area=zeros(900,120); %FIND V of each grid cell
for j = 1:120
    area(:,j) = dy*dz(j);
end



for i =240
    for j = 1:640
        if i>=201 && i<=240
%             S=sq(ncread('Original6.nc','S',[j 1 1 i-200],[1 Inf Inf 1]));
%             T=sq(ncread('Original6.nc','Temp',[j 1 1 i-200],[1 Inf Inf 1]));
            U=sq(ncread('Original6.nc','U',[j 1 1 i-200],[1 Inf Inf 1]));
            Tracer=sq(ncread('Originaltracer6.nc','tracer',[j 1 1 i-200],[1 Inf Inf 1]));
        j
       
        end


        Transport(j) = nansum(nansum( area(Tracer>=0.01).*U(Tracer>=0.01) ));
        A(j)=nansum(nansum(area(Tracer>=0.01)));
       % Ubar(j) = Transport(j)/(nansum(nansum(area(Tracer>=0.01))));
    

    end
   
    i

end
g = gausswin(120); % <-- this value determines the width of the smoothing window
g = g/sum(g);
Tsmooth = conv(Transport, g, 'same');
Ubar = Tsmooth./A;
alphae=diff(Tsmooth)./(.0021*100000.*dx(1:639)');
%alpahe=conv(alphae,g,'same')
%plot(alphae)

figure(101)
subplot(4,1,1)
plot(XC,Tsmooth,'k','Linewidth',1.5);
ylabel('smoothed T')
subplot(4,1,2)
plot(XC(2:640),diff(Tsmooth),'k','Linewidth',1.5);
ylabel('dT/dx')
subplot(4,1,3)
plot(XC,Ubar,'k','Linewidth',1.5);
ylabel('Ubar')
subplot(4,1,4)
plot(XC(2:640),alphae,'k','Linewidth',1.5);
ylabel('alpha')




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