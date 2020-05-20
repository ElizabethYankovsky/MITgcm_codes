% This is a matlab script that generates the input data
% variable x resolution
clear all
close all

prec='real*8';
ieee='b';

% Dimensions of grid
nx=640; 
ny=900;
nz=120; 
% Nominal depth of model (meters)
H=2500.0;
% Size of domain
Lx=75000;
Ly=99999.9;

% Horizontal resolution (m)
%Variable resolution
res1=2*Lx/(3*nx);
L1=Lx/2;
L2=Lx - L1;
n2=nx - (L1/res1);
res2=L2/n2;
A=res2 - res1;
iswitch1=L1/(res1);
width=40;
dx=zeros(nx,1);
for i=1:nx
    dx(i) = res1*1.43982 + 0.06*A*( tanh( (i-iswitch1)/width) + 1);
%dx(i) = Lx/nx;
end

%Vertical resolution (m)
res1z=2*H/(3*nz);
H1 =H/2;
H2 =H - H1;
n2z =nz - (H1/res1z);
res2z=H2/n2z;
Az = res2z-res1z;
% in gendata_Kara1 iswitchz =H1/(res1z);
iswitchz =H1/(res1z);
widthz=10;
dz = zeros(nz,1);
for i=1:nz
    dz(i) =res1z*.95+0.5408*Az*(tanh((i-iswitchz)/widthz)+1);
    %in gendata_Kara1 dz(i) =res1z/4+1.2*Az*(tanh((i-iswitchz)/widthz)+1);

end


x=zeros(nx,1);
x(1) = dx(1);
for i=2:nx
x(i)=x(i-1) + dx(i);
end

z=zeros(nz,1);
z(1) =-dz(1);
for i=2:nz
    z(i)=(z(i-1)-dz(i));
end
y =111.111:111.111:99999.9; 

fid=fopen('dx.bin','w',ieee); fwrite(fid,dx,prec); fclose(fid);
%fid=fopen('dz.bin','w',ieee); fwrite(fid,dz,prec); fclose(fid);
dy = Ly/ny;

% Flux
Qo=500*2; %W/m^2
SFo=0.0372*2; %kg*psu/(m^2*s);

% Stratification
gravity=9.81;
talpha=2.0e-4;
sbeta=7.4e-4;
N2=0.0000013; %0 for no stratification
Tz=N2/(gravity*talpha);
Sz=N2/(gravity*sbeta);


%Tanh function for cooling
xswitch = 2.2e4+ Lx/2.0;
qwidth = .5e3;
Q=0.0*rand([nx,ny]);
% for i=1:nx
% Q(i,:) = Q(i,:) + Qo*0.5*(tanh((Lx-x(i)-xswitch)/qwidth) + 1);
% %Q(i,:) = Q(i,:) + Qo*0.5*(tanh((x(i)-xswitch)/qwidth) + 1);
% end
for i = 1:nx;
    for j = 1:ny;
        radius = sqrt(x(i)^2+(y(j)-50000)^2);
        Q(i,j)=Q(i,j)+Qo*0.5*(tanh((Lx-xswitch-radius)/500)+1);
    end
end
fid=fopen('Qnet.forcing','w',ieee); fwrite(fid,Q,prec); fclose(fid);

%Tanh function for salinity forcing
%negative for increasing SSS
xswitch = 2.2e4 + Lx/2.0;
sfwidth = 0.5e3;
SF=0.0*rand([nx,ny]);
% for i=1:nx
% SF(i,:) = -(SF(i,:) + SFo*0.5*(tanh((Lx-x(i)-xswitch)/sfwidth) + 1));
% %Q(i,:) = Q(i,:) + Qo*0.5*(tanh((x(i)-xswitch)/qwidth) + 1);
% end
for i = 1:nx;
    for j = 1:ny;
        radius = sqrt(x(i)^2+(y(j)-50000)^2);
        SF(i,j)=-(SF(i,j)+SFo*0.5*(tanh((Lx-xswitch-radius)/500)+1));
    end
end
fid=fopen('SF.forcing','w',ieee); fwrite(fid,SF,prec); fclose(fid);

% Temperature profile
i = 1:1:nz;
Tref = 1.5516 - 1.5414*(tanh(i/179.2610)+1);
fid =fopen('Tref.init','w',ieee); fwrite(fid,Tref,prec); fclose(fid);
t=0.01*rand([nx,ny,nz]);

for k=1:nz
 t(:,:,k) = t(:,:,k) + Tref(k);
end
fid=fopen('T.init','w',ieee); fwrite(fid,t,prec); fclose(fid);

%Salinity profile
i = 1:1:nz;
Sref=33.9831+0.4654*(tanh(i/17.9459)+1);
fid=fopen('Sref.init','w',ieee); fwrite(fid,Sref,prec); fclose(fid);
s=0.0001*rand([nx,ny,nz]);
for k=1:nz
    s(:,:,k)=s(:,:,k)+Sref(k);
end
fid=fopen('S.init','w',ieee); fwrite(fid,s,prec); fclose(fid);

%Temperature profile for sponge
Trefsponge = repmat(Tref,[ny 1]);
fid =fopen('Trefsponge.init','w',ieee); fwrite(fid,Trefsponge,prec); fclose(fid);
%Salinity profile for sponge
Srefsponge = repmat(Sref,[ny 1]);
fid =fopen('Srefsponge.init','w',ieee); fwrite(fid,Srefsponge,prec); fclose(fid);

%Sponge BC
Uref=0.0*rand([ny,nz]);
Vref=0.0*rand([ny,nz]);
fid =fopen('Uref.init','w',ieee); fwrite(fid,Uref,prec); fclose(fid);
fid =fopen('Vref.init','w',ieee); fwrite(fid,Vref,prec); fclose(fid);

% Sloping channel
% tanh function for slope
slope=0.15
offset=1.5e3 + Lx/2.0;
dmax=-40.0;
h1=dmax;
h2=-H;
hdiff=(h1-h2);
xwidth=hdiff/(2.0*slope);
d=0.0*rand([nx,ny]);
for i=1:nx
for j=1:ny
d(i,j) = hdiff/2*(tanh((Lx-x(i)-offset)/xwidth) + 1) - H;
end
end
d(1,:)=0.0;
fid=fopen('topog.slope','w',ieee); fwrite(fid,d,prec); fclose(fid);

pressure = -9.81*1035*z/10000;
pressure = repmat(pressure,[1 640]);
pressure = reshape(pressure',640,1,120);

ypoint = 890;

figure(101)
plot(x,d(:,1)); 
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); title('Topography','Fontsize',14)

figure(102)
pcolor(x,z-z(1),squeeze(t(:,ypoint,:))'); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Temperature','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); 
hold on; plot(x,d(:,1),'k');

figure(103)
pcolor(x,z-z(1),squeeze(s(:,ypoint,:))'); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Salinity','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); 
hold on; plot(x,d(:,1),'k');

figure(104)
pcolor(x,y,Q'); shading flat;
colorbar; title('Q forcing','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Alongshore position (m)','Fontsize',14); 

figure(105)
pcolor(x,y,SF'); shading flat;
colorbar; title('Salinity forcing','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Alongshore position (m)','Fontsize',14); 



%LOOKING AT PRESSURE
tdens = (squeeze(t(:,1,:)))';
sdens = (squeeze(s(:,1,:)))';
density = densmdjwf(sdens,tdens,1);
figure(106)
pcolor(x,z-z(1),density); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Density','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); 
hold on; plot(x,d(:,1),'k');

mask = zeros(640,900,120);
%mask(1:148,1:900,1)=1;
for i = 1:nx;
    for j =1:ny;
        radius = sqrt(x(i)^2+(y(j)-50000)^2);
        if radius<=17000
            mask(i,j,1)=1;
        end
    end
end
mask(626:640,1:900,1:120)=1;
figure(107)
imagesc(squeeze(mask(:,:,1))');
title('Mask file xy-view','Fontsize',14)
fid=fopen('rbcs_mask.bin','w',ieee); fwrite(fid,mask,prec); fclose(fid);

relax= zeros(640,900,120);
%relax(1:148,1:900,1)=1;
for i = 1:nx;
    for j =1:ny;
        radius = sqrt(x(i)^2+(y(j)-50000)^2);
        if radius<=17000
            relax(i,j,1)=1;
        end
    end
end
figure(108)
imagesc(squeeze(relax(:,:,1))')
title('Relax file xy-view','Fontsize',14)
fid=fopen('rbcs_Tr1_fld.bin','w',ieee); fwrite(fid,relax,prec); fclose(fid);


