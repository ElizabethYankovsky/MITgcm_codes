clear all
close all
load z.mat; z=z-z(1);

YC = 111.111:111.111:99999.9; 
%Plotting x coordinate
XC=ncread('Original1.nc','X');


%Initial Conditions
% cd Originalinput
% fid1= fopen('T.init','r','b');
% Tinit=fread(fid1,'real*8');
% Tinit = reshape(Tinit,[640 900 120]);
% Tinit = sq(Tinit(:,1,:));
% 
% fid2= fopen('S.init','r','b');
% Sinit=fread(fid2,'real*8');
% Sinit = reshape(Sinit,[640 900 120]);
% Sinit = sq(Sinit(:,1,:));
% cd ..
% densityinit = densmdjwf(Sinit,Tinit,0);
% densityinit = nanmean(nanmean(densityinit(1:135,1:3)));

for i =1:120
    if i>=1 && i<=40
        S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
        %T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
        %U=sq(ncread('Original1.nc','U',[1 1 1 i],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
        S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
        %T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
        %U=sq(ncread('Original2.nc','U',[1 1 1 i-40],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));        
    elseif i>=81 && i<=120
        S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        %T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
        %U=sq(ncread('Original3.nc','U',[1 1 1 i-80],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1]));       
    elseif i>=121 && i<=160
        S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
        %T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
        %U=sq(ncread('Original4.nc','U',[1 1 1 i-120],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=201
        S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
        %T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
        %U=sq(ncread('Original5.nc','U',[1 1 1 i-160],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1]));        
    elseif i>=201 && i<=240
        S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
        %T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
        %U=sq(ncread('Original6.nc','U',[1 1 1 i-200],[Inf Inf Inf 1]));
        Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));       
    end
S = S(:,1,:);
S = sq(S);
topogindex=repmat(120,640,1);
for j = 1:640;
    a = find(isnan(S(j,:)));
    if not(isempty(a))
        b = min(a);
        topogindex(j) = b-1;
    end

end
topogindex(1)=4;

value = repmat(0,[640 900 1]);
for j = 1:640
    value(j,:,1) = Tracer(j,:,topogindex(j));
end
figure(1)
pcolor(XC(:,1),YC,sq(value)'); shading flat; colorbar
title('Tracer concentration at bottom','Fontsize',14); set(gca,'Fontsize',14)
ylabel('y distance, meters','Fontsize',14)
xlabel('x distance, meters','Fontsize',14)
mymovie1(i)=getframe;
clf
figure(2)
pcolor(XC(:,1),YC,sq(Tracer(:,:,2))'); shading flat; colorbar
title('Tracer concentration near surface','Fontsize',14); set(gca,'Fontsize',14)
ylabel('y distance, meters','Fontsize',14)
xlabel('x distance, meters','Fontsize',14)
mymovie2(i)=getframe;
end  
movie2avi(mymovie1,'movie1')
movie2avi(mymovie2,'movie2')
% S = S(:,1,:);
% S = sq(S);
% topogindex=repmat(120,640,1);
% for i = 1:640;
%     a = find(isnan(S(i,:)));
%     if not(isempty(a))
%         b = min(a);
%         topogindex(i) = b-1;
%     end
% 
% end
% topogindex(1)=4;
% 
% value = repmat(0,[640 900 1]);
% for i = 1:640
%     value(i,:,1) = Tracer(i,:,topogindex(i));
% end
% figure(1)
% pcolor(XC(:,1),YC,sq(value)'); shading flat; colorbar
% title('Tracer concentration at bottom','Fontsize',14); set(gca,'Fontsize',14)
% ylabel('y distance, meters','Fontsize',14)
% xlabel('x distance, meters','Fontsize',14)

% figure(2)
% pcolor(XC(:,1),YC,sq(Tracer(:,:,2))'); shading flat; colorbar
% title('Tracer concentration near surface','Fontsize',14); set(gca,'Fontsize',14)
% ylabel('y distance, meters','Fontsize',14)
% xlabel('x distance, meters','Fontsize',14)














