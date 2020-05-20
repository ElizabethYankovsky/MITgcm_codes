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

px = 680;
pz = 190;
for i = 1:240;
    if i>=1 && i<=40
        W(i)=sq(ncread('HR1.nc','W',[px 1 pz i],[1 1 1 1]));
        V(i)=sq(nanmean(ncread('HR1.nc','V',[px 1 pz i],[1 2 1 1]),2));
        U(i)=sq(ncread('HR1.nc','U',[px 1 pz i],[1 1 1 1]));
    elseif i>=41 && i<=80
        W(i)=sq(ncread('HR2.nc','W',[px 1 pz i-40],[1 1 1 1]));
        V(i)=sq(nanmean(ncread('HR2.nc','V',[px 1 pz i-40],[1 2 1 1]),2));
        U(i)=sq(ncread('HR2.nc','U',[px 1 pz i-40],[1 1 1 1]));
    elseif i>=81 && i<=120
        W(i)=sq(ncread('HR3.nc','W',[px 1 pz i-80],[1 1 1 1]));
        V(i)=sq(nanmean(ncread('HR3.nc','V',[px 1 pz i-80],[1 2 1 1]),2));
        U(i)=sq(ncread('HR3.nc','U',[px 1 pz i-80],[1 1 1 1]));
    elseif i>=121 && i<=160
        W(i)=sq(ncread('HR4.nc','W',[px 1 pz i-120],[1 1 1 1]));
        V(i)=sq(nanmean(ncread('HR4.nc','V',[px 1 pz i-120],[1 2 1 1]),2));
        U(i)=sq(ncread('HR4.nc','U',[px 1 pz i-120],[1 1 1 1]));
    elseif i>=161 && i<=200
        W(i)=sq(ncread('HR5.nc','W',[px 1 pz i-160],[1 1 1 1]));
        V(i)=sq(nanmean(ncread('HR5.nc','V',[px 1 pz i-160],[1 2 1 1]),2));
        U(i)=sq(ncread('HR5.nc','U',[px 1 pz i-160],[1 1 1 1]));
    elseif i>=201 && i<=240
        W(i)=sq(ncread('HR6.nc','W',[px 1 pz i-200],[1 1 1 1]));
        V(i)=sq(nanmean(ncread('HR6.nc','V',[px 1 pz i-200],[1 2 1 1]),2));
        U(i)=sq(ncread('HR6.nc','U',[px 1 pz i-200],[1 1 1 1]));
    end
end
U(isnan(U))=0; W(isnan(W))=0; V(isnan(V))=0;
signal =sqrt(U.^2 + W.^2);
transform= fft(signal);
P1 = abs(transform);
P2 = P1(1:i/2+1);
P2(2:end-1)=2*P2(2:end-1);
f = (0:i/2)*1/(21600*i)
figure(1)
plot((1./f)./(3600*24),P2)
figure(2)
plot(f,P2)
figure(3)
plot(linspace(0,60,240),signal);



