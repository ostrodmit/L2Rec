%% Signle-Index demo
% randomly sample a single index signal on [0,1]^2
close all
rng(2,'twister'); % initialize random number generator
s = 3;
sce = ['SingleIdx-' num2str(s)];
n = 150;
snr = 1;
[x,y,sigm] = generate_data2(sce,n,snr);
%% 
% Denoise via Recht's oversampled Lasso.
recl = lasso_recovery(y,sigm);
%%
% Denoise via penalized filtering.
clear params
params.sigm=sigm; % mandatory
params.rho=0; % mandatory but will not be used here, provides eps=0
params.lep=0; % no bandwidth adaptation
params.mode=2;
params.verb = 0;
alpha = 0.1;
lambda = 2 * sigm^2 * log(21*n/alpha);
solver_control = struct('p',2,'constrained',0,'squared',1,...
    'lambda',lambda,'solver','nes','tol',1e-8,...
    'max_iter',100,'max_cpu',1000,'l2_prox',1,'online',1,'verbose',0);
tic; recf = filter_recovery(y,params,solver_control); toc
%%
% Plot results
save_pics=['../nips/single/s-' num2str(s) '/']; % to name files properly
params.snr=snr;
mode='gamma';
plot_recovery_results2(params,mode,save_pics,x,y,recf,recl);