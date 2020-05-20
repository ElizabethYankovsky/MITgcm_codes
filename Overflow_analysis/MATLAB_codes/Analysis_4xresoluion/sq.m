% sq(A)  is similar to squeeze(A) except that elements =0 are set to NaN
%
function [A] = sq(B);
A=squeeze(B);
A(find(A==0))=A(find(A==0))*NaN;
