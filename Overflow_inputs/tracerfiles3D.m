%
clear all
close all
%

prec='real*8';
ieee='b';

mask = zeros(640,900,120);
mask(1:148,1:900,1)=1;
mask(626:640,1:900,1:120)=1;
figure(1)
imagesc(squeeze(mask(:,1,:))');
fid=fopen('rbcs_mask.bin','w',ieee); fwrite(fid,mask,prec); fclose(fid);

relax= zeros(640,900,120);
relax(1:148,1:900,1)=1;
figure(2)
imagesc(squeeze(relax(:,1,:))')
fid=fopen('rbcs_Tr1_fld.bin','w',ieee); fwrite(fid,relax,prec); fclose(fid);