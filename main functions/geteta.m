function [int,eta]=geteta(lambda,C,Y,family)
%This function applies coordinate descent algorithm to solve for eta; 
%when family = 'gaussian', it solves a linear regresion model; when family =
%'binomial' it solves a logistic regression model
options.weights        =            [];
options.alpha          =             1;
options.nlambda        =           100;
options.lambda_min     =             0;
options.lambda         =         lambda;
options.standardize    =         false;%true
options.thresh         =          1E-4;
%options.dfmax          =             0;
%options.pmax           =             0;
options.exclude        =            [];
options.penalty_factor =            [];
options.maxit          =           100;
options.HessianExact   =         false;
options.type           =       'naive';%'covariance'
fit = glmnet(C,Y,family,options);
int=fit.a0;
eta=fit.beta;
end