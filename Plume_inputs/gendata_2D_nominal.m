% This is a matlab script that generates the input data
% variable x resolution
clear all
close all

prec='real*8';
ieee='b';

% Dimensions of grid
nx=640;
ny=1;
nz=120;
% Nominal depth of model (meters)
H=25.0;
% Size of domain
Lx=60.0e3;

% Horizontal resolution (m)
dx=zeros(nx,1)+Lx/nx;

%Vertical resolution (m)
dz = zeros(nz,1)+H/nz;

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

dy = 100.0;
forcingdepth=5.0;
time = 0:0.4:12.4; %in hours
ntime= 12.4/0.4+1; nyf=1; nzf=120;

U_forcing = 750*(34.0/16.0)*(1+sin(2*pi*time/12.4 ))/(20*dy*forcingdepth);
U_forcing = repmat(U_forcing',1,nyf,nzf); 
U_forcing = permute(U_forcing,[2 3 1]);
U_forcing(:,25:nzf,:)=0.0;

S_forcing = time*0.0+18.0;
S_forcing = repmat(S_forcing',1,nyf,nzf);
S_forcing = permute(S_forcing,[2 3 1]);
S_forcing(:,25:nzf,:)=34.0;

T_forcing = time*0.0+15.0;
T_forcing = repmat(T_forcing',1,nyf,nzf);
T_forcing = permute(T_forcing,[2 3 1]);
%Western boundary forcing
fid=fopen('WU.forcing','w',ieee); fwrite(fid,U_forcing,prec); fclose(fid);
fid=fopen('WS.forcing','w',ieee); fwrite(fid,S_forcing,prec); fclose(fid);
fid=fopen('WT.forcing','w',ieee); fwrite(fid,T_forcing,prec); fclose(fid);

%Wind forcing
wind=0.0*rand([nx,ny,ntime])+0.05;
fid=fopen('Wind.forcing','w',ieee); fwrite(fid,wind,prec); fclose(fid);

%Temp Profile
t=0.0*rand([nx,ny,nz])+15.0;
fid=fopen('T.init','w',ieee); fwrite(fid,t,prec); fclose(fid);

%Salinity profile
s=0.0*rand([nx,ny,nz])+34.0;
fid=fopen('S.init','w',ieee); fwrite(fid,s,prec); fclose(fid);

% Topography
d=0.0*rand([nx,ny]);
d(1:105,:) = -5.0;
d(106:532,:) = -linspace(5.0, 25.0, 427);
d(533:640,:) = -25.0;



fid=fopen('topog.slope','w',ieee); fwrite(fid,d,prec); fclose(fid);




figure(101)
area(x,d(:,1),-25.0); 
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); title('Topography','Fontsize',14)
ylim([-25.0 0])

figure(102)
pcolor(x,z,squeeze(t)'); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Temperature (Celsius)')
xlabel('Horizontal position (m)')
ylabel('Depth (m)'); 
hold on; 
h =area(x,d(:,1),-25);
set(h,'Facecolor',[0.8 0.8 0.8]);
caxis([14 16]);

figure(103)
pcolor(x,z,squeeze(s)'); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Salinity (psu)')
xlabel('Horizontal position (m)')
ylabel('Depth (m)'); 
hold on; 
hh =area(x,d(:,1),-25); 
set(hh,'FaceColor',[0.8 0.8 0.8]);
caxis([33 35]);

figure(104);
plot(time,squeeze(U_forcing(1,1,:)))
xlabel('Time (h)')
ylabel('U velocity of inflow (m/s)')


