% This is a matlab script that generates the input data
% variable x resolution
clear all
close all

prec='real*8';
ieee='b';

% Dimensions of grid
%nx=80;
nx=640; %320 previously
ny=1;
nz=120; %60 previously
% Nominal depth of model (meters)
H=2500.0;
% Size of domain
Lx=75.0e3;

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
dz = zeros(nz,1)
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

fid=fopen('dx.bin','w',ieee); fwrite(fid,dx,prec); fclose(fid);
%fid=fopen('dz.bin','w',ieee); fwrite(fid,dz,prec); fclose(fid);
dy = Lx/nx

% Flux
Qo= 500;
SFo=0.0372;

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
for i=1:nx
Q(i,:) = Q(i,:) + Qo*0.5*(tanh((Lx-x(i)-xswitch)/qwidth) + 1);
%Q(i,:) = Q(i,:) + Qo*0.5*(tanh((x(i)-xswitch)/qwidth) + 1);
end
fid=fopen('Qnet.forcing','w',ieee); fwrite(fid,Q,prec); fclose(fid);

%Tanh function for salinity forcing
%negative for increasing SSS
xswitch = 2.2e4 + Lx/2.0;
sfwidth = 0.5e3;
SF=0.0*rand([nx,ny]);
for i=1:nx
SF(i,:) = -(SF(i,:) + SFo*0.5*(tanh((Lx-x(i)-xswitch)/sfwidth) + 1));
%Q(i,:) = Q(i,:) + Qo*0.5*(tanh((x(i)-xswitch)/qwidth) + 1);
end
fid=fopen('SF.forcing','w',ieee); fwrite(fid,SF,prec); fclose(fid);

% Temperature profile
i = 1:1:nz;
Tref = 1.5516 - 1.5414*(tanh(i/179.2610)+1);

%Sponge BC
Uref=Tref*0;
Vref=Tref*0;
fid =fopen('Uref.init','w',ieee); fwrite(fid,Uref,prec); fclose(fid);
fid =fopen('Vref.init','w',ieee); fwrite(fid,Vref,prec); fclose(fid);

%t = 0.25*rand([nx,ny,nz]);
t=0.01*rand([nx,ny,nz]);

for k=1:nz
 t(:,:,k) = t(:,:,k) + Tref(k);
end

%INFLOW temperature
ymatrix = zeros(640,1,49);
xmatrix = zeros(640,1,49);

for i=1:49
    for j=1:640
        ymatrix(j,1,i)=j;
        xmatrix(j,1,i)=i;
    end
end
inflowT=((-0.3*(xmatrix-25).^2-.1*ymatrix))/1000+0.25;
inflowT=inflowT.^5*10^3.15;
t(:,:,12:60)=t(:,:,12:60)+inflowT;
t = flipdim(t,1);
Treftemporary=squeeze(t);
Treftemporary=Treftemporary(640,:);
fid =fopen('Tref.init','w',ieee); fwrite(fid,Treftemporary,prec); fclose(fid);
%[sprintf('Tref =') sprintf(' %8.6g,',Tref)]
fid=fopen('T.init','w',ieee); fwrite(fid,t,prec); fclose(fid);

%Salinity profile
i = 1:1:nz;
Sref=33.9831+0.4654*(tanh(i/17.9459)+1);

s=0.0001*rand([nx,ny,nz]);
for k=1:nz
    s(:,:,k)=s(:,:,k)+Sref(k);
end

%INFLOW salinity
inflowS=((-0.3*(xmatrix-25).^2-.1*ymatrix))/1000+0.25;
inflowS=inflowS.^5*10^2.09;
s(:,:,12:60)=s(:,:,12:60)+inflowS;
s = flipdim(s,1);
Sreftemporary=squeeze(s);
Sreftemporary=Sreftemporary(640,:);
fid=fopen('Sref.init','w',ieee); fwrite(fid,Sreftemporary,prec); fclose(fid);
fid=fopen('S.init','w',ieee); fwrite(fid,s,prec); fclose(fid);

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



figure(101)
plot(x,d(:,1)); 
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); title('Topography','Fontsize',14)

figure(102)
pcolor(x,z,squeeze(t)'); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Temperature (Celsius)','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); 
hold on; 
h =area(x,d(:,1),-2500);
set(h,'Facecolor',[0.8 0.8 0.8]);
caxis([-0.8909 1.0872]);

figure(103)
pcolor(x,z,squeeze(s)'); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Salinity (psu)','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); 
hold on; 
hh =area(x,d(:,1),-2500); 
set(hh,'FaceColor',[0.8 0.8 0.8]);
caxis([34.4744 35.0183]);

figure(104)
pcolor(x,z,repmat(Q',120,1)); shading flat;
colorbar; title('Heat forcing [W/m^2]','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); 
hold on
plot(x,d(:,1),'w','Linewidth',1.5)

figure(105)
pcolor(x,z,repmat(SF',120,1)); shading flat;
colorbar; title('Salinity forcing [psu*kg/(m^2s)]','Fontsize',14)
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); 
hold on
plot(x,d(:,1),'w','Linewidth',1.5)

