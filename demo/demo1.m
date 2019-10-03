%addpath('...');
addpath('/Users/dengannan/Desktop/Research/bin nan/Paper Code/HWRFR/data');
load example_1d;

X=example_1d.X;
%Y=example_1d.Y;
Y = [2;1;2;1;2;1;2;1;1;2];

%lambda=zeros(8,1);
%a=2;
%for i=1:8
%    lambda(i)=a^(-6+i);
%end
lambda=linspace(0.06,0.15,10);

%l = wmaxlev(128,'haar'); %get maximum possible decomposition level
%level=linspace(1,l,l);
level=1;

%Obtain C matrix at specified levels
[C_levels,size_X] = getCmatrix(X,level,1);

%Apply the cross validation to select optimal set of tuning parameters
%result =hwrfr_cv(level,lambda,5,C_levels, Y,1);
result =hwrfr_cv(level,lambda,2,C_levels, Y,2);

result.eta = result.eta_auc;
result.level = result.level_auc;
%Obtain beta by eta
beta_est= getbeta(result.eta,result.level,1,size_X);

