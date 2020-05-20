clear all
close all
%
%
%
load XC.mat %variable name XC, x coordinate
YC = 111.111:111.111:99999.9;


S=sq(ncread('Original1.nc','S',[1 450 1 1],[Inf 1 Inf 1]));
topogindex=repmat(120,640,1);
for i = 1:640;
    a = find(isnan(S(i,:)));
    if not(isempty(a))
        b = min(a);
        topogindex(i) = b-1;
    end

end
topogindex(1)=4;
%topogindex=repmat(2,640,1);



valuetop = zeros(240,640);
valuebot = valuetop;
for i =1:240
    if i>=1 && i<=40
        Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 450 1 i],[Inf 1 Inf 1]));
    elseif i>=41 && i<=80
        Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 450 1 i-40],[Inf 1 Inf 1]));        
    elseif i>=81 && i<=120
        Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 450 1 i-80],[Inf 1 Inf 1]));       
    elseif i>=121 && i<=160
        Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 450 1 i-120],[Inf 1 Inf 1]));
    elseif i>=161 && i<=201
        Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 450 1 i-160],[Inf 1 Inf 1]));        
    elseif i>=201 && i<=240
        Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 450 1 i-200],[Inf 1 Inf 1]));       
    end
    for j =1:640
        valuebot(i,j)=Tracer(j,topogindex(j));
        valuetop(i,j)=Tracer(j,2);
    end
    i
end  
time=(1:1:240)/4;
figure(1)
pcolor(XC,time,(valuebot)); shading flat; colorbar
title('Bottom tracer evolution at y=50km'); 
ylabel('Time, days')
xlabel('X Position (m)')
colormap('bluewhitered')
set(gca,'Fontsize',12)
figure(2)
pcolor(XC,time,(valuetop)); shading flat; colorbar
title('Surface tracer evolution at y=50km '); 
ylabel('Time, days')
xlabel('X Position (m)')
colormap('bluewhitered')
set(gca,'Fontsize',12)





















