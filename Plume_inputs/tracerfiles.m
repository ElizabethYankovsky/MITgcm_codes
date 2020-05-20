%
clear all
close all
%

prec='real*8';
ieee='b';

mask = zeros(640,1,120);
mask(1:148,1,1)=1;
mask(626:640,1,1:120)=1;
figure(1)
imagesc(squeeze(mask)');
fid=fopen('rbcs_mask.bin','w',ieee); fwrite(fid,mask,prec); fclose(fid);

relax= zeros(640,1,120);
relax(1:148,1,1)=1;
figure(2)
imagesc(squeeze(relax)')
fid=fopen('rbcs_Tr1_fld.bin','w',ieee); fwrite(fid,relax,prec); fclose(fid);
