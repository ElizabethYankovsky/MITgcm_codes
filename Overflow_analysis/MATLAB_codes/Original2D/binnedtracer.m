clear all
close all
load z.mat
load topo.mat
topo = -topo;
load XC.mat
bins=[1027.6:.025:1029.3];
%bins = [1027.6:0.1:1029.4];
Hovmollermatrix = zeros(240,length(bins)-1);
xvalues = [100 300 500 600 700 900 1100];
for xi = 1:7
xindex = xvalues(xi);

for i = 1:240;
    
    if i>=1 && i<=40 
        S=sq(ncread('HR1.nc','S',[1 1 1 i],[1280 Inf Inf 1]));
        T=sq(ncread('HR1.nc','Temp',[1 1 1 i],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        S=sq(ncread('HR2.nc','S',[1 1 1 i-40],[1280 Inf Inf 1]));
        T=sq(ncread('HR2.nc','Temp',[1 1 1 i-40],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));        
    elseif i>=81 && i<=120
        S=sq(ncread('HR3.nc','S',[1 1 1 i-80],[1280 Inf Inf 1]));
        T=sq(ncread('HR3.nc','Temp',[1 1 1 i-80],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));       
    elseif i>=121 && i<=160
        S=sq(ncread('HR4.nc','S',[1 1 1 i-120],[1280 Inf Inf 1]));
        T=sq(ncread('HR4.nc','Temp',[1 1 1 i-120],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
        S=sq(ncread('HR5.nc','S',[1 1 1 i-160],[1280 Inf Inf 1]));
        T=sq(ncread('HR5.nc','Temp',[1 1 1 i-160],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));        
    elseif i>=201 && i<=240
        S=sq(ncread('HR6.nc','S',[1 1 1 i-200],[1280 Inf Inf 1]));
        T=sq(ncread('HR6.nc','Temp',[1 1 1 i-200],[1280 Inf Inf 1]));
        Tracer=sq(ncread('HRtracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));       
    end
    
    density = densmdjwf(S,T,zeros(1280,240));
    densityx = density(xindex,:);
    
    for k = 1:length(bins)-1;
        var(k) = nanmean(Tracer(xindex,densityx>=bins(k) & densityx<bins(k+1)));
    end
    Hovmollermatrix(i,:)=var;
     %i
end
length(bins)
xi
figure(xi)
imagesc(linspace(0,60,240),bins,Hovmollermatrix')
xlabel('Days'); ylabel('Density bin');
caxis([0 1]);
colormap('bluewhitered'); colorbar; 
grid on
h = colorbar;
set(get(h,'title'),'string','Average Tracer Value');
end
figure(xi+1)
area(XC,topo,-2500,'Facecolor',[.8 .8 .8])
hold on
plot(repmat(XC(100),240),linspace(-2500,0,240),'r','Linewidth',2)
%plot(repmat(XC(200),240),linspace(-2500,0,240),'r','Linewidth',2)
plot(repmat(XC(300),240),linspace(-2500,0,240),'r','Linewidth',2)
%plot(repmat(XC(400),240),linspace(-2500,0,240),'r','Linewidth',2)
plot(repmat(XC(500),240),linspace(-2500,0,240),'r','Linewidth',2)
plot(repmat(XC(600),240),linspace(-2500,0,240),'r','Linewidth',2)
plot(repmat(XC(700),240),linspace(-2500,0,240),'r','Linewidth',2)
%plot(repmat(XC(800),240),linspace(-2500,0,240),'r','Linewidth',2)
plot(repmat(XC(900),240),linspace(-2500,0,240),'r','Linewidth',2)
%plot(repmat(XC(1000),240),linspace(-2500,0,240),'r','Linewidth',2)
plot(repmat(XC(1100),240),linspace(-2500,0,240),'r','Linewidth',2)
%plot(repmat(XC(1200),240),linspace(-2500,0,240),'r','Linewidth',2)














