clear all
close all
load z.mat
load dz.mat
load dx.mat
load XC.mat
z = z-z(1);


dy = 111.111;
myD = ncread('grid.nc','Depth');
[hfacC,ddz]=hfac(dz',-myD,0.05,0);
volume=zeros(640,900,120); %FIND V of each grid cell
for i =1:640
    for j = 1:120
        volume(i,:,j) = dy*dx(i)*ddz(i,:,j);
    end
end
volume1=volume(1:170,:,:); volume2=volume(171:340,:,:); volume3=volume(341:600,:,:);


%FINDING TIME CHANGE

Si=sq(ncread('Original1.nc','S',[1 1 1 1],[Inf Inf Inf 1]));
Ti=sq(ncread('Original1.nc','Temp',[1 1 1 1],[Inf Inf Inf 1]));
Sf=sq(ncread('Original6.nc','S',[1 1 1 40],[Inf Inf Inf 1]));
Tf=sq(ncread('Original6.nc','Temp',[1 1 1 40],[Inf Inf Inf 1]));
rho_o=1027.7;
Cp=3974;
deltaheat1=nansum(nansum(volume1.*Tf(1:170,:,:)-volume1.*Ti(1:170,:,:)))*rho_o*Cp;
deltaheat2=nansum(nansum(volume2.*Tf(171:340,:,:)-volume2.*Ti(171:340,:,:)))*rho_o*Cp;
deltaheat3=nansum(nansum(volume3.*Tf(341:600,:,:)-volume3.*Ti(341:600,:,:)))*rho_o*Cp;
deltasalt1=nansum(nansum(volume1.*Sf(1:170,:,:)-volume1.*Si(1:170,:,:)))*rho_o;
deltasalt2=nansum(nansum(volume2.*Sf(171:340,:,:)-volume2.*Si(171:340,:,:)))*rho_o;
deltasalt3=nansum(nansum(volume3.*Sf(341:600,:,:)-volume3.*Si(341:600,:,:)))*rho_o;

%FINDING SOURCE

cd Originalinput
fid1= fopen('Qnet.forcing','r','b');
Q=fread(fid1,'real*8');
Q= reshape(Q,[640 900]);
Q = squeeze(Q(:,1));
fid2= fopen('SF.forcing','r','b');
SF=fread(fid2,'real*8');
SF = reshape(SF,[640 900]);
SF = squeeze(SF(:,1));
cd ..
forcingarea=dx*dy*900; %m^2 INTEGRATED OVER Y, NOT OVER X
time = 60*24*3600;%s
forcingS = -SF.*forcingarea*time;
forcingH = -Q.*forcingarea*time; %kg/(m^2*s)
source1H=sum(forcingH(1:170)); 
source1S=sum(forcingS(1:170));

%FINDING FLUX

%Defining 3 yz faces through which fluxes are calculated
 area1=dy*sq(ddz(169,:,:));
 area2=dy*sq(ddz(339,:,:));
 area3=dy*sq(ddz(599,:,:));
 %REDEFINING initial values for flux through faces
 S1i=sq(nanmean(ncread('Original1.nc','S',[169 1 1 1],[2 Inf Inf 1])));
 S2i=sq(nanmean(ncread('Original1.nc','S',[339 1 1 1],[2 Inf Inf 1])));
 S3i=sq(nanmean(ncread('Original1.nc','S',[599 1 1 1],[2 Inf Inf 1])));
 T1i=sq(nanmean(ncread('Original1.nc','Temp',[169 1 1 1],[2 Inf Inf 1])));
 T2i=sq(nanmean(ncread('Original1.nc','Temp',[339 1 1 1],[2 Inf Inf 1])));
 T3i=sq(nanmean(ncread('Original1.nc','Temp',[599 1 1 1],[2 Inf Inf 1])));

for i =1:240 %240 for full time series of 60 days
    %Reading in temperature, salinity velocity at each of the three faces
    if i>=1 && i<=40
        S1=sq(nanmean(ncread('Original1.nc','S',[169 1 1 i],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original1.nc','S',[339 1 1 i],[2 Inf Inf 1])));
        S3=sq(nanmean(ncread('Original1.nc','S',[599 1 1 i],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original1.nc','Temp',[169 1 1 i],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original1.nc','Temp',[339 1 1 i],[2 Inf Inf 1])));
        T3=sq(nanmean(ncread('Original1.nc','Temp',[599 1 1 i],[2 Inf Inf 1])));
        U1=sq(ncread('Original1.nc','U',[170 1 1 i],[1 Inf Inf 1]));
        U2=sq(ncread('Original1.nc','U',[340 1 1 i],[1 Inf Inf 1]));
        U3=sq(ncread('Original1.nc','U',[600 1 1 i],[1 Inf Inf 1]));
    elseif i>=41 && i<=80
        S1=sq(nanmean(ncread('Original2.nc','S',[169 1 1 i-40],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original2.nc','S',[339 1 1 i-40],[2 Inf Inf 1])));
        S3=sq(nanmean(ncread('Original2.nc','S',[599 1 1 i-40],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original2.nc','Temp',[169 1 1 i-40],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original2.nc','Temp',[339 1 1 i-40],[2 Inf Inf 1])));
        T3=sq(nanmean(ncread('Original2.nc','Temp',[599 1 1 i-40],[2 Inf Inf 1])));
        U1=sq(ncread('Original2.nc','U',[170 1 1 i-40],[1 Inf Inf 1]));
        U2=sq(ncread('Original2.nc','U',[340 1 1 i-40],[1 Inf Inf 1]));
        U3=sq(ncread('Original2.nc','U',[600 1 1 i-40],[1 Inf Inf 1]));      
    elseif i>=81 && i<=120
        S1=sq(nanmean(ncread('Original3.nc','S',[169 1 1 i-80],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original3.nc','S',[339 1 1 i-80],[2 Inf Inf 1])));
        S3=sq(nanmean(ncread('Original3.nc','S',[599 1 1 i-80],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original3.nc','Temp',[169 1 1 i-80],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original3.nc','Temp',[339 1 1 i-80],[2 Inf Inf 1])));
        T3=sq(nanmean(ncread('Original3.nc','Temp',[599 1 1 i-80],[2 Inf Inf 1])));
        U1=sq(ncread('Original3.nc','U',[170 1 1 i-80],[1 Inf Inf 1]));
        U2=sq(ncread('Original3.nc','U',[340 1 1 i-80],[1 Inf Inf 1]));
        U3=sq(ncread('Original3.nc','U',[600 1 1 i-80],[1 Inf Inf 1]));    
    elseif i>=121 && i<=160
        S1=sq(nanmean(ncread('Original4.nc','S',[169 1 1 i-120],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original4.nc','S',[339 1 1 i-120],[2 Inf Inf 1])));
        S3=sq(nanmean(ncread('Original4.nc','S',[599 1 1 i-120],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original4.nc','Temp',[169 1 1 i-120],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original4.nc','Temp',[339 1 1 i-120],[2 Inf Inf 1])));
        T3=sq(nanmean(ncread('Original4.nc','Temp',[599 1 1 i-120],[2 Inf Inf 1])));
        U1=sq(ncread('Original4.nc','U',[170 1 1 i-120],[1 Inf Inf 1]));
        U2=sq(ncread('Original4.nc','U',[340 1 1 i-120],[1 Inf Inf 1]));
        U3=sq(ncread('Original4.nc','U',[600 1 1 i-120],[1 Inf Inf 1]));
    elseif i>=161 && i<=200
        S1=sq(nanmean(ncread('Original5.nc','S',[169 1 1 i-160],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original5.nc','S',[339 1 1 i-160],[2 Inf Inf 1])));
        S3=sq(nanmean(ncread('Original5.nc','S',[599 1 1 i-160],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original5.nc','Temp',[169 1 1 i-160],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original5.nc','Temp',[339 1 1 i-160],[2 Inf Inf 1])));
        T3=sq(nanmean(ncread('Original5.nc','Temp',[599 1 1 i-160],[2 Inf Inf 1])));
        U1=sq(ncread('Original5.nc','U',[170 1 1 i-160],[1 Inf Inf 1]));
        U2=sq(ncread('Original5.nc','U',[340 1 1 i-160],[1 Inf Inf 1]));
        U3=sq(ncread('Original5.nc','U',[600 1 1 i-160],[1 Inf Inf 1]));  
    elseif i>=201 && i<=240
        S1=sq(nanmean(ncread('Original6.nc','S',[169 1 1 i-200],[2 Inf Inf 1])));
        S2=sq(nanmean(ncread('Original6.nc','S',[339 1 1 i-200],[2 Inf Inf 1])));
        S3=sq(nanmean(ncread('Original6.nc','S',[599 1 1 i-200],[2 Inf Inf 1])));
        T1=sq(nanmean(ncread('Original6.nc','Temp',[169 1 1 i-200],[2 Inf Inf 1])));
        T2=sq(nanmean(ncread('Original6.nc','Temp',[339 1 1 i-200],[2 Inf Inf 1])));
        T3=sq(nanmean(ncread('Original6.nc','Temp',[599 1 1 i-200],[2 Inf Inf 1])));
        U1=sq(ncread('Original6.nc','U',[170 1 1 i-200],[1 Inf Inf 1]));
        U2=sq(ncread('Original6.nc','U',[340 1 1 i-200],[1 Inf Inf 1]));
        U3=sq(ncread('Original6.nc','U',[600 1 1 i-200],[1 Inf Inf 1]));   
    end
   
   
    %Calculating mass flux into each region [kg] at each time step
    %at the end of the code, sum(mass1) to get total for all time
    heatflux1(i) =nansum(nansum(-(T1).*U1.*area1))*21600*rho_o*Cp;
    heatflux2(i) =(nansum(nansum((T1).*U1.*area1))-nansum(nansum((T2).*U2.*area2)))*21600*rho_o*Cp;
    heatflux3(i) =(nansum(nansum((T2).*U2.*area2))-nansum(nansum((T3).*U3.*area3)))*21600*rho_o*Cp;
    
    saltflux1(i) =nansum(nansum(-(S1).*U1.*area1))*21600*rho_o;
    saltflux2(i) =(nansum(nansum((S1).*U1.*area1))-nansum(nansum((S2).*U2.*area2)))*21600*rho_o;
    saltflux3(i) =(nansum(nansum((S2).*U2.*area2))-nansum(nansum((S3).*U3.*area3)))*21600*rho_o;

end

%Total fluxes:
heat1 = nansum(heatflux1);
heat2 = nansum(heatflux2);
heat3 = nansum(heatflux3);

salt1 = nansum(saltflux1);
salt2 = nansum(saltflux2);
salt3 = nansum(saltflux3);

%Total balances:
balance1h = heat1+source1H-sum(deltaheat1);
balance1s = salt1+source1S-sum(deltasalt1);

balance2h= heat2-sum(deltaheat2);
balance2s= salt2-sum(deltasalt2);

balance3h= heat3-sum(deltaheat3);
balance3s= salt3-sum(deltasalt3);













