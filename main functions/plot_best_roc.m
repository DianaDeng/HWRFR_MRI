function fH = plot_best_roc(C,int,eta,Y)

    mid=int+C*eta;
    phat=1./(1+exp(-mid)); % pi hat
    
    fH = icg_plotroc(Y'-1,phat');
end