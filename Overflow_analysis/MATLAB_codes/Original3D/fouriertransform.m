clear all
close all
XCindex1 = [100 110 120 130];
zindex  = 2;
for j = 1:4
    XCindex=XCindex1(j);
for i = 1:240;
   
    if i>=1 && i<=40
%         S=sq(ncread('Original1.nc','S',[1 1 1 i],[Inf Inf Inf 1]));
%         T=sq(ncread('Original1.nc','Temp',[1 1 1 i],[Inf Inf Inf 1]));
          U=sq(ncread('Original1.nc','U',[XCindex 1 zindex i],[1 Inf 1 1]));
         % V=sq(ncread('Original1.nc','V',[1 1 1 i],[Inf Inf Inf 1]));
       %   Tracer=sq(ncread('Originaltracer1.nc','tracer',[XCindex 1 zindex i],[1 Inf 1 1]));
         % W=sq(ncread('Original1.nc','W',[1 1 1 i],[Inf Inf Inf 1]));
    elseif i>=41 && i<=80
 %         S=sq(ncread('Original2.nc','S',[1 1 1 i-40],[Inf Inf Inf 1]));
 %         T=sq(ncread('Original2.nc','Temp',[1 1 1 i-40],[Inf Inf Inf 1]));
          U=sq(ncread('Original2.nc','U',[XCindex 1 zindex i-40],[1 Inf 1 1]));
         % V=sq(ncread('Original2.nc','V',[1 1 1 i-40],[Inf Inf Inf 1]));
       %   Tracer=sq(ncread('Originaltracer2.nc','tracer',[XCindex 1 zindex i-40],[1 Inf 1 1]));
         % W=sq(ncread('Original2.nc','W',[1 1 1 i-40],[Inf Inf Inf 1]));
    elseif i>=81 && i<=120
        %  S=sq(ncread('Original3.nc','S',[1 1 1 i-80],[Inf Inf Inf 1]));
        %  T=sq(ncread('Original3.nc','Temp',[1 1 1 i-80],[Inf Inf Inf 1]));
          U=sq(ncread('Original3.nc','U',[XCindex 1 zindex i-80],[1 Inf 1 1]));
         % V=sq(ncread('Original3.nc','V',[1 1 1 i-80],[Inf Inf Inf 1]));
        %  Tracer=sq(ncread('Originaltracer3.nc','tracer',[XCindex 1 zindex i-80],[1 Inf 1 1])); 
         % W=sq(ncread('Original3.nc','W',[1 1 1 i-80],[Inf Inf Inf 1]));
    elseif i>=121 && i<=160
%          S=sq(ncread('Original4.nc','S',[1 1 1 i-120],[Inf Inf Inf 1]));
%          T=sq(ncread('Original4.nc','Temp',[1 1 1 i-120],[Inf Inf Inf 1]));
          U=sq(ncread('Original4.nc','U',[XCindex 1 zindex i-120],[1 Inf 1 1]));
         % V=sq(ncread('Original4.nc','V',[1 1 1 i-120],[Inf Inf Inf 1]));
         % Tracer=sq(ncread('Originaltracer4.nc','tracer',[XCindex 1 zindex i-120],[1 Inf 1 1]));
         % W=sq(ncread('Original4.nc','W',[1 1 1 i-120],[Inf Inf Inf 1]));
    elseif i>=161 && i<=201
%          S=sq(ncread('Original5.nc','S',[1 1 1 i-160],[Inf Inf Inf 1]));
%          T=sq(ncread('Original5.nc','Temp',[1 1 1 i-160],[Inf Inf Inf 1]));
          U=sq(ncread('Original5.nc','U',[XCindex 1 zindex i-160],[1 Inf 1 1]));
         % V=sq(ncread('Original5.nc','V',[1 1 1 i-160],[Inf Inf Inf 1]));
         % Tracer=sq(ncread('Originaltracer5.nc','tracer',[XCindex 1 zindex i-160],[1 Inf 1 1])); 
         % W=sq(ncread('Original5.nc','W',[1 1 1 i-160],[Inf Inf Inf 1]));
    elseif i>=201 && i<=240
%         S=sq(ncread('Original6.nc','S',[1 1 1 i-200],[Inf Inf Inf 1]));
%         T=sq(ncread('Original6.nc','Temp',[1 1 1 i-200],[Inf Inf Inf 1]));
          U=sq(ncread('Original6.nc','U',[XCindex 1 zindex i-200],[1 Inf 1 1]));
     %     V=sq(ncread('Original6.nc','V',[1 1 1 i-200],[Inf Inf Inf 1]));
     %    Tracer=sq(ncread('Originaltracer6.nc','tracer',[XCindex 1 zindex i-200],[1 Inf 1 1]));      
     %     W=sq(ncread('Original6.nc','W',[1 1 1 i-200],[Inf Inf Inf 1]));
    end

meanU =nanmean(U);
signal = U-meanU;
signal=signal(1:900);


%Performing Fourier transform and periodogram calculation IN WAVENUMBER
YC =0:111.111:99999.9;
DFT = fft(signal);
DFT = DFT(1:451); %Taking the first half
PSD = (111.111/900)*abs(real(DFT)).^2;
%%To conserve power:
PSD(2:end-1)=2*PSD(2:end-1);
wavenumber=0:(1/111.111)/900:(1/111.111)/2;

%  figure(i)
%  plot(YC,signal);
%  xlabel('Y Position'); ylabel('Signal m/s'); title('U perturbation')
%  figure(i+1)
%  plot(wavenumber,10*log10(PSD));
%  xlabel('Wavenumber (1/m)'); ylabel('Power/wavenumber (dB*m)');
%  title('Periodogram power spectral density estimate')
[a,b]=max(10*log10(PSD));
variable(i)=b;
dominantwavelength(j,i)=1/wavenumber(b)/1000;
    if b<=2
%       [c,d]=max(10*log10(PSD(3:end)));
%       d=d+2
%       dominantwavelength(i)=1/wavenumber(d)/1000;
        dominantwavelength(j,i)=NaN;
    end
i
end
end


