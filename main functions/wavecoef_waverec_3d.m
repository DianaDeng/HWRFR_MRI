function beta= wavecoef_waverec_3d( eta,level,size_X,d)
%   This function returns beta from eta for 3D Haar wavelet decomposition
%   by preparing the cell structure that is used in waverec3


% INPUT:
% eta: wavelet coefficeint vector
% level: level of decomposition
% size_X: size of the 3D observation
% d: output decomposition structure obtained from wavedec3

% OUTPUT:
% beta: 3D coefficient function



p1=size_X(1);p2=size_X(2);p3=size_X(3);

la=ceil(p1/(2^level))*ceil(p2/(2^level))*ceil(p3/(2^level));
mat_a=reshape(eta(1:la),ceil(p1/(2^level)),ceil(p2/(2^level)),ceil(p3/(2^level)));
a_cell=mat2cell(mat_a,ceil(p1/(2^level)),ceil(p2/(2^level)),ceil(p3/(2^level)));


ld=zeros(level,1);
d_cell=[];
for j=level:-1:1
    ld(j)=7*(ceil(p1/(2^j)))*(ceil(p2/(2^j)))*(ceil(p3/(2^j)));
end
for j=level:-1:1
    %a1=ceil(p1/(2^j));a2=ceil(p1/(2^j));a3=ceil(p1/(2^j));
    a1=ceil(p1/(2^j));a2=ceil(p2/(2^j));a3=ceil(p3/(2^j));
    x_eta=eta((end-sum(ld(1:j))+1):(end-sum(ld(1:(j-1)))));
    new=vector_sep(x_eta,7,a1,a2,a3);
    d_cell=[d_cell;new];
end

 newcell=[a_cell;d_cell];
 d.dec=newcell;
 beta=waverec3(d);
end


