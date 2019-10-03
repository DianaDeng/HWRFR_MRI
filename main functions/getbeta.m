function [beta ] = getbeta(eta,level,dim,size_X)
%This function is used to obtain beta from eta 
% testx defined in this function is only used to get "L"


% INPUT:
% eta: wavelet cofficient vector
% level: the level of inverse Haar wavelet transform
%1D: dim=1, size_X=[1,p1]
%2D: dim=2, size_X=[p1,p2]
%3D: dim=2, size_X=[p1,p2,p3]


% OUTPUT:
% beta: orignial coefficient function

switch(dim)
    case 3
        testx=randn(size_X);
        d=wavedec3(testx,level,'haar');
        %beta= wavecoef_waverec_3d(eta,level, size_X,d);
        beta=waverec3(d);
    case 2
        testx=randn(size_X);
        [~,L]=wavedec2(testx,level,'haar');
        beta=waverec2(eta,L,'haar');
    case 1
        testx=randn(size_X);
        [~,L]=wavedec(testx,level,'haar');
        beta=waverec(eta,L,'haar');
end

end

