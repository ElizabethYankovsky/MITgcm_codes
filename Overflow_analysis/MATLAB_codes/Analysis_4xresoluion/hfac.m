function [hfacC,ddz] = hfac(dz,H,hfacmin,dzmin)
%
% Create hfacC(i,j,k) and dz(i,j,k) from dz(k), H(i,j)
% using MITgcmUV model parameters hfacmin and dzmin
%
% e.g.
%   [hfacC,ddz] = hfac(dz,H,hfacmin,dzmin)
% e.g. To create a "p-mask" from above
%   pmask=zeros(size(hfacC)); pmask( find(hfacC>0) )=1;

[nx,ny]=size(H);
nz=prod(size(dz));
N=[nx ny nz];

zf=[0 -cumsum(dz)];

hfacC=zeros(N);
ddz=zeros(N);
for k=1:nz,
 hFacLim=max([ hfacmin min([1 dzmin/dz(k)]) ]);
 if hFacLim == 1
  disp(sptrinf('Level k=%3i  dz(k)=%8.2f  Full cell',k,dz(k)))
 else
  disp(sprintf('Level k=%3i  dz(k)=%8.2f  Lopping with min[hfacC(:,:,k)*dz(k)]=%8.2f',k,dz(k),hFacLim*dz(k)))
 end
 ddd=(zf(k)-H)/dz(k);
 ddd(find(ddd > 1)) = 1;
%ddd(find(ddd < 0)) = 0;
%ddd(find(ddd < hFacLim/2 & ddd ~= 0)) = 0;
 ddd(find(ddd < hFacLim/2)) = 0; % This should do the job of the above 2 lines
 ddd(find(ddd >= hFacLim/2 & ddd < hFacLim)) = hFacLim;
 hfacC(:,:,k)=ddd;
 ddz(:,:,k)=ddd*dz(k);
end
