clear all
close all
load z.mat; z=z-z(1);

YC = 111.111:111.111:99999.9; 
%Plotting x coordinate
XC=ncread('Original1.nc','X');


%Initial Conditions
cd Originalinput
fid1= fopen('T.init','r','b');
Tinit=fread(fid1,'real*8');
Tinit = reshape(Tinit,[640 900 120]);
Tinit = sq(Tinit(:,1,:));

fid2= fopen('S.init','r','b');
Sinit=fread(fid2,'real*8');
Sinit = reshape(Sinit,[640 900 120]);
Sinit = sq(Sinit(:,1,:));
cd ..
densityinit = densmdjwf(Sinit,Tinit,0);
densityinit = nanmean(nanmean(densityinit(1:135,1:3)));

for i =240;
    index=i-200;
    if i>=1 && i<=40
         S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
         T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
       %   U=sq(ncread('Original1.nc','U',[1 1 1 i],[Inf Inf Inf 1]));
       %   V=sq(ncread('Original1.nc','V',[1 1 1 i],[Inf Inf Inf 1]));
         Tracer=sq(ncread('Originaltracer1.nc','tracer',[1 1 1 i],[Inf Inf Inf 1]));
       %   W=sq(ncread('Original1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
          S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
          T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
     %     U=sq(ncread('Original2.nc','U',[1 1 1 i-40],[Inf Inf Inf 1]));
      %    V=sq(ncread('Original2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]));
         Tracer=sq(ncread('Originaltracer2.nc','tracer',[1 1 1 i-40],[Inf Inf Inf 1]));
    %      W=sq(ncread('Original2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
          S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
          T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
        %  U=sq(ncread('Original3.nc','U',[1 1 1 i-80],[Inf Inf Inf 1]));
        %  V=sq(ncread('Original3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]));
         Tracer=sq(ncread('Originaltracer3.nc','tracer',[1 1 1 i-80],[Inf Inf Inf 1])); 
       %   W=sq(ncread('Original3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
          S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
          T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
         % U=sq(ncread('Original4.nc','U',[1 1 1 i-120],[Inf Inf Inf 1]));
          %V=sq(ncread('Original4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]));
         Tracer=sq(ncread('Originaltracer4.nc','tracer',[1 1 1 i-120],[Inf Inf Inf 1]));
         % W=sq(ncread('Original4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
         S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
          T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
       %   U=sq(ncread('Original5.nc','U',[1 1 1 i-160],[Inf Inf Inf 1]));
       %   V=sq(ncread('Original5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]));
         Tracer=sq(ncread('Originaltracer5.nc','tracer',[1 1 1 i-160],[Inf Inf Inf 1])); 
       %   W=sq(ncread('Original5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
         S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
         T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
    %      U=sq(ncread('Original6.nc','U',[1 1 1 i-200],[Inf Inf Inf 1]));
     %     V=sq(ncread('Original6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]));
         Tracer=sq(ncread('Originaltracer6.nc','tracer',[1 1 1 i-200],[Inf Inf Inf 1]));      
     %     W=sq(ncread('Original6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
    end
     
    Trtr = Tracer(:,:,2:120);
    Str = (S(:,:,2:120));
    Ttr = (T(:,:,2:120));
%    Utr = (U(1:640,:,2:120));
    densitytr = densmdjwf(Str,Ttr,zeros(640,900,119));
    

     density = densmdjwf(S,T,zeros(640,900,120));
    
     densityanomaly(i) = nanmean(nanmean(nanmean(density(1:135,1:900,1:3))))-densityinit;
    
%     %WEIGHTED VALUES:
%     Sweighted(:,i) = sq(nansum(nansum(Str.*Trtr,3),2)./nansum(nansum(Trtr,3),2));
%     Tweighted(:,i) = sq(nansum(nansum(Ttr.*Trtr,3),2)./nansum(nansum(Trtr,3),2));
%     densweighted(:,i) = sq(nansum(nansum(densitytr.*Trtr,3),2)./nansum(nansum(Trtr,3),2));
%     Uweighted(:,i) = sq(nansum(nansum(Utr.*Trtr,3),2)./nansum(nansum(Trtr,3),2));
%     variable1(index) = max(max(max(W)));
%     variable2(index) = max(max(max(U)));
%     variable3(index) = max(max(max(V)));
    i
end  




