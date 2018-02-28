%% Sines with random frequencies
close all
rng(3,'twister'); % initialize random number generator
n=128;
k = 4;
snr = 0.5;
sce = ['RanSin-' num2str(k)];
[x,y,sigm] = generate_data2(sce,n,snr);
% %% 
% % Normalize
% Z  = norm(x(:));
% x = x ./ Z; y = y ./ Z; sigm = sigm / Z;
%% 
% Denoise via Recht's oversampled Lasso.
tic; recl = lasso_recovery(y,sigm); toc
%%
% Denoise via filtering, take rho to be several times the number of frequencies.
clear params
params.snr=snr;
params.sigm=sigm; % mandatory
params.rho=k^2; % mandatory
params.lep=0; % no bandwidth adaptation
params.par=1; % let's go parallel
%tic; recf = filter_recovery(y,params); toc
%%
%%%%%%%%%%%%%%%%% NIPS camera-ready : penalized estimator %%%%%%%%%%%%%%%%%
solver_control.constrained=0;
solver_control.p=2;
solver_control.solver='nes';
solver_control.max_iter=1000;
solver_control.lambda=2*sigm^2*log(630*(n/2)^2); % practical value
tic; recf = filter_recovery(y,params,solver_control); toc
%%
% Plot the results
mode = 'mine'; % {'img', 'mesh', 'surf', 'gamma', 'grey', 'mine'}
save_pics='./sines2/';
params.sce=sce;
plot_recovery_results2(params,mode,save_pics,x,y,recf,recl);
ns=floor(n/8);
save_pics='./sines2-mag/';
plot_recovery_results2(params,mode,save_pics,x(1:ns,1:ns),...
    y(1:ns,1:ns),recf(1:ns,1:ns),recl(1:ns,1:ns));