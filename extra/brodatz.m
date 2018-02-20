%% Brodatz
n = 320;
pic='D73';
sce = ['../Brodatz/' pic '.gif'];
[x,y,sigm] = generate_data2(sce,n,1); % Brodatz file
recl = lasso_recovery(y,sigm);
clear params
params.snr=1;
params.rho=4;
params.lep=1; % we need bandwidth adaptation, the picture has sharp borders
params.sigm=sigm;
params.par=1; % let's go parallel
tic; recf = filter_recovery(y,params); toc
%%
% Plot results
params.sce='Brodatz';
save_pics=['../nips/brodatz/' pic '/'];
mode='img';
plot_recovery_results2(params,mode,save_pics,x,y,recf,recl);