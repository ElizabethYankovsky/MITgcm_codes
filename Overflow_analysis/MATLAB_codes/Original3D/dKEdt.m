clear all
close all

xc=ncread('grid.nc','XC');
XC = sq(xc(:,1))/1000;

load dz.mat
dzmat = repmat(dz',640,1);
fraction=sq(ncread('grid.nc','HFacC',[1 1 1],[Inf 1 Inf]));
lengthz = dzmat.*fraction;

dymatrix=repmat(111.111,640,900,120);

i = 229; %34 229
% U=sq(ncread('Original1.nc','U',[2 1 1 i],[Inf Inf Inf 1]));
% V=sq(ncread('Original1.nc','V',[1 1 1 i],[Inf Inf Inf 1]));
% W=sq(ncread('Original1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
U=sq(ncread('Original6.nc','U',[2 1 1 i-200],[Inf Inf Inf 1]));
V=sq(ncread('Original6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]));
W=sq(ncread('Original6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
V = V(1:640,1:900,1:120);
KE = 0.5*(U.^2+V.^2+W.^2);

for i =230:240;
    j=i-229;
    if i>=1 && i<=40
          U=sq(ncread('Original1.nc','U',[2 1 1 i],[Inf Inf Inf 1]));
          V=sq(ncread('Original1.nc','V',[1 1 1 i],[Inf Inf Inf 1]));
          W=sq(ncread('Original1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
          U=sq(ncread('Original2.nc','U',[2 1 1 i-40],[Inf Inf Inf 1]));
          V=sq(ncread('Original2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]));
          W=sq(ncread('Original2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
          U=sq(ncread('Original3.nc','U',[2 1 1 i-80],[Inf Inf Inf 1]));
          V=sq(ncread('Original3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]));
          W=sq(ncread('Original3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
          U=sq(ncread('Original4.nc','U',[2 1 1 i-120],[Inf Inf Inf 1]));
          V=sq(ncread('Original4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]));
          W=sq(ncread('Original4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=200
          U=sq(ncread('Original5.nc','U',[2 1 1 i-160],[Inf Inf Inf 1]));
          V=sq(ncread('Original5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]));
          W=sq(ncread('Original5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
          U=sq(ncread('Original6.nc','U',[2 1 1 i-200],[Inf Inf Inf 1]));
          V=sq(ncread('Original6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]));
          W=sq(ncread('Original6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
    end
    V = V(1:640,1:900,1:120);
    dKEdt1 = (0.5*(U.^2+V.^2+W.^2)-KE)/21600;
    KE = 0.5*(U.^2+V.^2+W.^2);
    %integrating in z and y
    dKEdt2 = sq((1./nansum(dymatrix,2)).*nansum(dKEdt1.*dymatrix,2));
    dKEdt3 = (1./nansum(lengthz,2)).*nansum(dKEdt2.*lengthz,2);
    
    dKEdt60(:,j)=dKEdt3;

%    KE = 0.5*(U.^2+V.^2+W.^2);
%     %integrating in z and y
%     KE2 = sq((1./nansum(dymatrix,2)).*nansum(KE.*dymatrix,2));
%     KE3 = (1./nansum(lengthz,2)).*nansum(KE2.*lengthz,2);
%     
%     KE60(:,j)=KE3;


    
i
end

% for k = 1:640
%     x = polyfit(1:1:11,KE60(k,:),1);
%     dKEdt60(k)=x(1)/21600;
%     
%     
%     
%    k
% end
%   % plot(XC,nanmean(dKEdt60,2)) 
%     
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
