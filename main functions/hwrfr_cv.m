function [result] =hwrfr_cv(level,lambda,K,C,Y,type)
%Thi fnction applies K-fold cross validation to select the tuning
%parameters in Haar-wavelet-based regularized functional regresion (hwrfr);

% 1. INPUT:
% level: level of Haar wavelet decomposition
% lambda: lasso parameter
% K: K-fold cross validation
% C: a cell array consists of wavelet coefficient matrice
% Y: response variable (continuous, if type=1; binary (1 and 2), if type=2)
% type=1 (family='gaussian'); type=2 (family='binomial')
% Criteria for cross validation:
% MSE (mean squared error, type=1)
% DEV (deviance, type=2)
% MER (missclassification error rate, type=2)
% AUC (area under the ROC curve, type=2)

%OUTPUT
% int_opt: optimal intercept
% eta_opt: optimal eta (optimal wavelet cofficeints for beta)
% level_opt: optimal level
% lambda_opt: optimal lambda

nobs=length(Y);

len1=length(level);
len2=length(lambda);
mean_MSE=zeros(len1,len2);
mean_DEV=zeros(len1,len2);
mean_MER=zeros(len1,len2);
mean_AUC=zeros(len1,len2);


kappa=floor(nobs/K);
idx=cell(K,1);
if kappa*K<nobs
    s=nobs-kappa*K;
    kappa1=ceil(nobs/K);
    for i=1:s
        idx{i}=(i-1)*kappa1 + 1:i*kappa1;
    end
    for i=s+1:K
        idx{i}=idx{i-1}(end)+1:idx{i-1}(end)+kappa;
    end
else   
    for i=1:K
        idx{i}=(i-1)*kappa + 1:i*kappa;
    end
end

MSE_fold=zeros(K,1); 
DEV_fold=zeros(K,1); 
MER_fold=zeros(K,1);
AUC_fold=zeros(K,1);

switch(type)
    case 1
    family  = 'gaussian';  
        for j=1:len1
            C_one=C{j};
            for k=1:len2
                for i=1:K
                    vldid = idx{i};
                    trnid = setdiff(1:nobs,  vldid);
                    Cvld = C_one(vldid,:);
                    Yvld = Y(vldid);
                    Ytrain = Y(trnid);
                    Ctrain=C_one(trnid,:);
                    [int_est, eta_est]=geteta(lambda(k),Ctrain,Ytrain,family);
                    Yhat=int_est+Cvld*eta_est;
                    MSE_fold=mean((Yhat-Yvld).^2);
                end
                mean_MSE(j,k)=mean(MSE_fold);
            end
        end
        [~,ind] = min(mean_MSE(:));
        [m,n] = ind2sub(size(mean_MSE),ind);
        lambda_opt=lambda(n);
        level_opt=level(m);
        [int_opt,eta_opt]=geteta(lambda_opt,C{level_opt},Y,family);
        
        result.int=int_opt;
        result.lambda=lambda_opt;
        result.level=level_opt;
        result.eta=eta_opt;
        
    case 2
        family  = 'binomial'; 
        for j=1:len1
            C_one=C{j};
            for k=1:len2
                for i=1:K
                    vldid = idx{i};
                    trnid = setdiff(1:nobs,  vldid);%with few data we may get non training set
                    Cvld = C_one(vldid,:);
                    Yvld = Y(vldid);
                    Ytrain = Y(trnid);
                    Ctrain=C_one(trnid,:);
                    l_vld=length(Yvld);
                    [int_est, eta_est]=geteta(lambda(k),Ctrain,Ytrain,family);
                    mid=int_est+Cvld*eta_est;
                    phat=1./(1+exp(-mid)); % pi hat
                    
                    %CV-DEV
                    Yhat=zeros(l_vld,1);
                    devv=zeros(l_vld,1);
                    indexes=eye(2);
                    Yvld_t=indexes(Yvld,:);
                    Yvld_t=1-Yvld_t;
                    log_mat=[log(phat), log(1-phat)];
                    for t=1:l_vld
                        devv(t)=-2*(Yvld_t(t,:)*log_mat(t,:)');
                        if phat(t)>0.5
                            Yhat(t)=2;
                        else
                            Yhat(t)=1;
                        end
                    end
                    DEV_fold(i)=sum(devv);
                    
                    %CV-MER
                    MER_fold(i)=mean(abs(Yhat-Yvld));
                    
                    %CV-AUC
                    cutoff=unique(sort(phat));
                    len_cutoff=length(cutoff);
                    tp=zeros(len_cutoff,1);fp=zeros(len_cutoff,1);
                    Yhat_roc=ones(l_vld,len_cutoff);
                    for aa=1:len_cutoff
                        for t=1:l_vld
                            if phat(t)>=cutoff(aa)
                                Yhat_roc(t,aa)=2;
                            end
                        end
                        %[~,tp(aa),fp(aa)]=getfptp(Yvld,Yhat_roc(:,aa));
                        [tp(aa),fp(aa)]=getfptp(Yvld,Yhat_roc(:,aa));
                    end
                    %AUC_fold(i)=areaundercurve(1-fp,tp);
                    AUC_fold(i)=areaundercurve(fp,tp);
                end
                mean_DEV(j,k)=mean(DEV_fold);
                mean_MER(j,k)=mean(MER_fold);
                mean_AUC(j,k)=mean(AUC_fold);
            end
        end
       
        
        [~,ind] = min(mean_DEV(:));
        [m,n] = ind2sub(size(mean_DEV),ind);
        lambda_opt_dev=lambda(n);
        level_opt_dev=level(m);
        [int_opt_dev,eta_opt_dev]=geteta(lambda_opt_dev,C{level_opt_dev},Y,family);

        result.int_dev=int_opt_dev;
        result.lambda_dev=lambda_opt_dev;
        result.level_dev=level_opt_dev;
        result.eta_dev=eta_opt_dev;

        [~,ind] = min(mean_MER(:));
        [m,n] = ind2sub(size(mean_MER),ind);
        lambda_opt_mer=lambda(n);
        level_opt_mer=level(m);
        [int_opt_mer,eta_opt_mer]=geteta(lambda_opt_mer,C{level_opt_mer},Y,family);
        
        result.int_mer=int_opt_mer;
        result.lambda_mer=lambda_opt_mer;
        result.level_mer=level_opt_mer;
        result.eta_mer=eta_opt_mer;
        
        [~,ind] = max(mean_AUC(:));
        [m,n] = ind2sub(size(mean_AUC),ind);
        lambda_opt_auc=lambda(n);
        level_opt_auc=level(m);
        [int_opt_auc,eta_opt_auc]=geteta(lambda_opt_auc,C{level_opt_auc},Y,family);
        
        result.int_auc=int_opt_auc;
        result.lambda_auc=lambda_opt_auc;
        result.level_auc=level_opt_auc;
        result.eta_auc=eta_opt_auc;
end
result.auc_opt = max(mean_AUC(:));
end
