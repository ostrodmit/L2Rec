%% Brodatz
rng(2,'twister'); % initialize random number generator
n = 320;
Pic={'D73','D75'};
clear params
params.snr=1;
params.rho=4;
params.lep=1; % we need bandwidth adaptation, the picture has sharp borders
params.par=1; % let's go parallel
for i = [1,2]
    pic = Pic{i};
    sce = ['../AdaFilter/brodatz/' pic '.gif'];
    [x,y,sigm] = generate_data2(sce,n,params.snr); % Brodatz file
    params.sigm=sigm;
    recl = lasso_recovery(y,sigm);
    tic; recf = filter_recovery(y,params); toc
    %%
    % Plot results
    params.sce='Brodatz';
    save_pics=['./brodatz/' pic '/'];
    mode='img';
    plot_recovery_results2(params,mode,save_pics,x,y,recf,recl);
end