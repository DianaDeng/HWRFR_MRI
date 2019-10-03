function [C_levels,size_X] = getCmatrix(X,level,dim)
%This function is to obatin the C matrix (wavelet coefficeint matrix).


%INPUT:
% 
% 
%1D: dim=1, the dimension of X is nobs*p1
%2D: dim=2, the dimension of X is nobs*p1*p2
%3D: dim=2, the dimension of X is nobs*p1*p2*p3
%nobs: the number of observations

%OUTPUT:

%C_levels: a cell array, each element is wavelet coefficeint matrix after
%          apply the Haar wavelet transform to X at a certain level
%size_X: the size of each observation

len1=length(level);
C_levels=cell(len1,1);
for j=1:len1
    %%%%%%%%%%%%%%%%%%%%%%Haar wavelet decomposition begin
    switch(dim)
        case 3
            [nobs,p1,p2,p3]=size(X);
            size_X=[p1,p2,p3];
            C=zeros(nobs, p1*p2*p3);
            for i=1:nobs
                d=wavedec3(squeeze(X(i,:,:,:)),level(j),'haar');
                C(i,:)=wavecoef_3d(d,level(j),size_X,0);
            end     
        case 2
            [nobs,p1,p2]=size(X);
            size_X=[p1,p2];
            C=zeros(nobs, p1*p2);
            for i=1:nobs
                [C(i,:),~]=wavedec2(X(i,:),level(j),'haar');
            end   
        case 1
            [nobs,p1]=size(X);
            size_X=[1,p1];
            C=zeros(nobs, p1);
            for i=1:nobs
                [C(i,:),~]=wavedec(X(i,:),level(j),'haar');
            end    
    end
    %%%%%%%%%%%%%%%%%%%%%%Haar wavelet decomposition end
    C_levels{j}=C;
end

end

