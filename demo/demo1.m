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
lambda=linspace(0.001,0.015,15);

l = wmaxlev(128,'haar'); %get maximum possible decomposition level
level=linspace(1,l,l);

%Obtain C matrix at specified levels
[C_levels,size_X] = getCmatrix(X,level,1);

%Apply the cross validation to select optimal set of tuning parameters
%result =hwrfr_cv(level,lambda,5,C_levels, Y,1);
result =hwrfr_cv(level,lambda,2,C_levels, Y,2);
%draw ROC plot
plot_best_roc(C_levels{result.level_auc},result.int_auc,result.eta_auc,Y);

%Obtain beta by eta
%beta_est= getbeta(result.eta_auc,result.level_auc,1,size_X);


