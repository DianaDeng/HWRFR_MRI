function [TPR ,FPR ]=getfptp(theta,theta_hat)
thea = theta-1;    
thea_hat = theta_hat-1; 
A = sum(~thea.*~thea_hat);  % A: TN
B = sum(~thea.*thea_hat);   % B: FP
C = sum(thea.*~thea_hat);   % C: FN
D = sum(thea.*thea_hat);    % D: TP
FPR = B/(B+A);         % FPR=FP/(FP+TN)
TPR = D/(D+C);          % TPR=TP/(TP+FN)
%Sensitivity =TPR;
%Specificity= 1-FPR;
end