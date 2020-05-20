%
%clear all
close all
%
%
%load temperature.mat
%load salinity.mat

%load z.mat
%load x.mat

%p = repmat(-9.81*z*1035,[1 640])/10000; %p is positive and increasing downwards
xgrid=x;  %positive values
zgrid=z'; %negative values
zgrid=mean([zgrid(1:end-1);zgrid(2:end)]);%negative values
t= squeeze(t)';
s= squeeze(s)';


g=9.81;
rhoref=1035;

for x = 1:640;
    for y=1:119;
        %pxy = (p(y,x)+p(y+1,x))/2;
        pxy = -zgrid(y)*9.81*1035/10000; %pressure in dbar
        rho1=densmdjwf(s(y,x),t(y,x),pxy);
        rho2=densmdjwf(s(y+1,x),t(y+1,x),pxy);
        %rho2-rho1 is positive
        delz(y,x)=z(y+1)-z(y); %negative
        N2(y,x)=-g/rhoref * (rho2-rho1)/delz(y,x); %mostly positive
    end
end
figure(1)
imagesc(N2); title('N^2 values on grid [1/s^2]','Fontsize',14); colorbar; grid on
set(gca,'Fontsize',14)
figure(2)
imagesc(t); title('T values on grid'); colorbar; grid on
figure(3)
imagesc(s); title('S values on grid'); colorbar; grid on
