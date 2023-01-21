% This is a matlab script that generates the input data
% variable x resolution
clear all
close all

prec='real*8';
ieee='b';

% Dimensions of grid
nx=600;
ny=1000;
nz=250;
% Nominal depth of model (meters)
H=25.0;
% Size of domain
Lx=60.0e3;
Ly=100.0e3;

% Resolution (m)
dx=Lx/nx;
dy=Ly/ny;
dz=H/nz;

x=zeros(nx,1); x(1) = dx;
for i=2:nx
x(i)=x(i-1) + dx;
end

y=zeros(ny,1); y(1) = dy;
for i=2:ny
y(i)=y(i-1) + dy;
end

z=zeros(nz,1); z(1) =-dz;
for i=2:nz
    z(i)=z(i-1)-dz;
end

forcingwidth = 1000.0; %nominal 1000 in meters
forcingdepth = 5.0;
time = 0:0.4:74.4; %in hours
ntime= 74.4/0.4+1; nyf=forcingwidth/dy; nzf=250;
blank = rand([ny nz ntime])*0.0;

U_f = 800*(34.0/16.0)*(1+sin(2*pi*time/12.4 - pi/2))/(forcingwidth*forcingdepth);
%U_f(8:ntime)=800*(34.0/16.0)/(forcingwidth*forcingdepth); %SHUTTING OFF THE TIDES! otherwise leave this line out

U_f = repmat(U_f',1,nyf,nzf); 
U_f = permute(U_f,[2 3 1]);
U_f(:,50:nzf,:)=0.0; %below 5m velocity is zero.
U_forcing = blank; U_forcing(180:189,:,:)=U_f; %U velocity at western b.c.

S_f = linspace(12,24,50); %depth varying inflow over 5 meters; S_f varies in depth not in time 
S_f = repmat(S_f',1,nyf,ntime);
S_f = permute(S_f,[2 1 3]);
S_forcing = blank+34.0; S_forcing(180:189,1:50,:)=S_f; %Salinity at western b.c.
S_forcing(:,:,1:30)=34.0; %Shutting off salinity forcing for the first tidal period 12.4 hours
%If you want to make the salinity forcing completely barotropic, no density relative to interior fluid:
%S_forcing(:,:,:)= 34.0;

T_forcing = blank+15.0; %Temperature at western b.c.

%Western boundary forcing
fid=fopen('WU.forcing','w',ieee); fwrite(fid,U_forcing,prec); fclose(fid);
fid=fopen('WS.forcing','w',ieee); fwrite(fid,S_forcing,prec); fclose(fid);
fid=fopen('WT.forcing','w',ieee); fwrite(fid,T_forcing,prec); fclose(fid);

%Wind forcing
wind=0.0*rand([nx,ny,ntime])+0.03; %Pa, original was 0.03
fid=fopen('Wind.forcing','w',ieee); fwrite(fid,wind,prec); fclose(fid);

%Temp Profile
t=0.0*rand([nx,ny,nz])+15.0;
fid=fopen('T.init','w',ieee); fwrite(fid,t,prec); fclose(fid);

%Salinity profile
s=0.0*rand([nx,ny,nz])+34.0;
fid=fopen('S.init','w',ieee); fwrite(fid,s,prec); fclose(fid);

% Topography
d=0.0*rand([nx,ny]);
d(2:99,:) = -5.0; %First 10km in x are 5m deep. Keep wall at left (d=0m).
for i=1:ny
    d(100:119,i) = -linspace(5.0, 10.0, 20); %10 to 12km slope from 5 to 10 m depth. 
end
for i=1:ny
    d(120:369,i) = -linspace(10.0, 25.0, 250); %10 to 50km slope.
end
d(370:600,:) = -25.0; %50 to 60km are 25m deep.

%triangle = rand([100 150])*0-5.0;
%for i=1:100
%    for j=1:150
%        if j>=1.5*i
%            triangle(i,j) = 0.0;
%        end
%    end
%end
%d(1:100,30:179) = triangle; Uncomment to have the wedge jutting out
%d(1, 180:189)=-5.0; %Open the channel at the left boundary.
%d(1:100,190:339)= fliplr(triangle); Uncomment to have the wedge jutting out
d(1:100,:)=0.0;
d(1:100,180:189)=-5.; %nominal 180:189 is the channel

fid=fopen('topog.slope','w',ieee); fwrite(fid,d,prec); fclose(fid);




figure(101)
contourf(x/1000,y/1000,d',500,'LineColor','none'); colorbar
set(gca,'Fontsize',14); xlabel('X position (km)','Fontsize',14)
ylabel('Y Position (km)','Fontsize',14); title('Depth (m)','Fontsize',14)
ylim([0 100]); xlim([0 60]);

figure(1011)
area(x,d(:,185),-25.0); 
set(gca,'Fontsize',14); xlabel('Horizontal position (m)','Fontsize',14)
ylabel('Depth (m)','Fontsize',14); title('Topography','Fontsize',14)
ylim([-25.0 0])

figure(102)
pcolor(x,z,squeeze(t(:,185,:))'); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Temperature (Celsius)')
xlabel('Horizontal position (m)')
ylabel('Depth (m)'); 
hold on; 
h =area(x,d(:,185),-25);
set(h,'Facecolor',[0.8 0.8 0.8]);
caxis([14 16]);
% 
figure(103)
pcolor(x,z,squeeze(s(:,185,:))'); shading flat;
set(gca,'Ydir','Normal')
colorbar; title('Salinity (psu)')
xlabel('Horizontal position (m)')
ylabel('Depth (m)'); 
hold on; 
hh =area(x,d(:,185),-25); 
set(hh,'FaceColor',[0.8 0.8 0.8]);
caxis([33 35]);
% 
figure(104);
plot(time,squeeze(U_forcing(185,1,:)))
xlabel('Time (h)')
ylabel('U velocity of inflow (m/s)')
% 
figure(105);
plot(time,squeeze(S_forcing(185,49,:)))
xlabel('Time (h)')
ylabel('Salinity of inflow (m/s)')


