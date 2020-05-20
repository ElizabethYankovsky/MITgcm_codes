clear all
close all
%
%
load temperatureTW.mat
load salinityTW.mat

load z.mat
load x.mat

xgrid=x;  %positive values
zgrid=z'; %negative values
%xgrid=mean([xgrid(1:end-1);xgrid(2:end)]);%positive values
t= squeeze(t)';
s= squeeze(s)';


g=9.81;
rhoref=1035;
f=1.43e-04;

for y = 1:120;
    for x = 1:639;
        
        pxy = -zgrid(y)*9.81*1035/10000; %pressure in dbar
        rho1=densmdjwf(s(y,x),t(y,x),pxy);
        rho2=densmdjwf(s(y,x+1),t(y,x+1),pxy);
        
        rho(y,x)=(rho1+rho2)/2;
        deltarho(y,x)=rho2-rho1;%rho2-rho1 %is negative
        
        delx(y,x)=xgrid(x+1)-xgrid(x); %positive?
        DVgDz(y,x)=-g/(rhoref*f) * (rho2-rho1)/delx(y,x); 
    end
end


Vg=zeros(120,639);
Vg(120,:) = 0;
a=diff(z);
for y = 1:119;
    Vg(120-y,1:639) = Vg(120-y+1,:)-a(120-y)*DVgDz(120-y,:);
end

figure(1)
imagesc(t); colorbar; set(gca,'Fontsize',14)
title('Temperature on grid','Fontsize',14)
figure(2)
imagesc(s); colorbar; set(gca,'Fontsize',14)
title('Salinity on grid')
figure(3)
imagesc(rho); colorbar; set(gca,'Fontsize',14)
title('Density on grid','Fontsize',14)
figure(4)
imagesc(deltarho); colorbar; set(gca,'Fontsize',14)
title('Drho/Dx','Fontsize',14)
figure(5)
imagesc(DVgDz); colorbar; set(gca,'Fontsize',14);
title('DVg/Dz values, Vg is geostrophic current','Fontsize',14)
figure(6)
imagesc(Vg); colorbar; set(gca,'Fontsize',14)
title('Vg','Fontsize',14)