clear all
close all
load z.mat
load topo.mat
topo=-topo;
load XC.mat

cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit1 = reshape(Tinit,[1280 240]);
Tinit = sq(Tinit1(:,1,:));

fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit1 = reshape(Sinit,[1280 240]);
Sinit = sq(Sinit1(:,1,:));
cd ..
densityinit = densmdjwf(Sinit1,Tinit1,zeros(1280,240));
densityinit = nanmean(nanmean(densityinit(1:270,1:6)));
% V velocity
for i = 1:240;
    if i>=1 && i<=40
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80     
        S = sq(ncread('HR2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
        T = sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
       S = sq(ncread('HR3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
       T = sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
        S = sq(ncread('HR4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
       T = sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200 
       S = sq(ncread('HR5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
       T = sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
       S = sq(ncread('HR6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
       T = sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
    end
    density = densmdjwf(S,T,zeros(1280,240));
densityanomaly2D(i) = nanmean(nanmean(density(1:270,1:6)))-densityinit;
i
end






