function C = wavecoef_3d(d,level,size_X,s)
% This function extracts the wavelet coeffcient vector from 3D Haar 
% wavelet decomposition

% INPUT:
% level: level of decomposition
% size_X: size of the 3D observation
% d: output decomposition structure obtained from wavedec3
% s=1: use threshold to shrink the wavelet coefficeints; s=0: no threshold


% OUTPUT:
% C: 3D wavelet decomposition coefficient

p1=size_X(1);p2=size_X(2);p3=size_X(3);
la=ceil((p1/(2^level)))*ceil((p2/(2^level)))*ceil((p3/(2^level)));
appr_coeff= reshape(cell2mat(d.dec(1)),1,la);

level_len=level-1:-1:0;

det_coeff=[];
for i=level:-1:1
    la_len=ceil((p1/(2^i)))*ceil((p2/(2^i)))*ceil((p3/(2^i)));
    new=reshape(cell2mat(d.dec(1+7*level_len(i)+1:1+7*level_len(i)+7)),1,7*la_len);
    det_coeff=[det_coeff new];
end

if s==1
    %thr: threshold value
    if median(det_coeff)>0
        thr=median(det_coeff);
    else
        thr=0.05*max(det_coeff);
    end
    det_coeff(det_coeff<=thr)=0;
    C=[appr_coeff  det_coeff];
elseif s==0
    C=[appr_coeff  det_coeff];
end
    
end

