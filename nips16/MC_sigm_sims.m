function [] = MC_sigm_sims(dim,ifPost,exper)
% dim={1,2}
% exper={'sin','SI'}; 'sin' by default or if dim==1
clearvars -except dim ifPost exper
if nargin < 3, exper='sin'; end
rng(2,'twister'); % initialize random number generator
logSNR = linspace(log(0.25), log(32), 8);
SNR = exp(logSNR);
% K = [4 8 16];
K = [4];
if dim==1,
    N=4;
    n = 100;
    methodErr = zeros(7+ifPost,2,length(K),length(SNR),N); % RanSin, CohSin
    Sce = [0,1];
elseif dim==2,
    N=40;
    n = 40;
    methodErr = zeros(7+ifPost,1,length(K),length(SNR),N); % RanSin or SingleIdx
    if strcmp(exper,'sin'), Sce = [0,1]; % RanSin, CohSin
    elseif strcmp(exper,'SI'), Sce = [2]; % SI
    else
        error('Incorrect experiment');
    end
else
    error('dim must be 1 or 2');
end

wb = waitbar(0,'Processing...','WindowStyle','modal');
for trial = 1:N,
    for snr=SNR,
        for k = K,
            for sc = Sce,
                if sc==0,
                    sce=['RanSin-' num2str(k)];
                elseif sc==1,
                    sce=['CohSin-' num2str(k/2)];
                else % sc==2
                    s = 8/k; % smoothness,
                    sce=['SingleIdx-' num2str(s)];
                end
                if dim==1,
                    [x,y,sigm] = generate_data(sce,n,snr);
                else
                    [x,y,sigm] = generate_data2(sce,n,snr);
                end
                Z  = norm(x(:));
                x = x ./ Z; y = y ./ Z; sigm = sigm / Z;
                % Denoise via Recht's oversampled Lasso.
                recl = lasso_recovery(y,sigm);
                %%
                % Denoise via constrained l2-filtering.
                clear params
                params.rho=k;
                params.lep=0; % no bandwidth adaptation
                params.sigm=sigm; % won't be used
                %alpha = 0.1;
                %lambda = 2 * sigm^2 * log(42*n/alpha);
                params.verb=0;
                solver_control = struct('p',2,'constrained',1,...
                    'solver','nes','tol',1e-8,'eps',sigm,...
                    'max_iter',10000,'max_cpu',1000,...
                    'l2_prox',1,'online',1,'verbose',0);
                solver_control.sigm = sigm;
                recf2conk = filter_recovery(y,params,solver_control);
                params.rho=k^2;
                recf2conk2 = filter_recovery(y,params,solver_control);
                solver_control.p=inf;
                solver_control.solver='mp';
                params.rho=k;
                recf8conk = filter_recovery(y,params,solver_control);
                params.rho=k^2;
                recf8conk2 = filter_recovery(y,params,solver_control);
                solver_control.constrained=0;
                solver_control.p=2;
                solver_control.solver='nes';
                solver_control.max_iter=1000;
                solver_control.lambda=2*sigm^2*log(630*(n/2)^dim);
                recf2penpr = filter_recovery(y,params,solver_control);
                % post-denoising 
                if ifPost, 
                    rec_post = music(recf2penpr,'root',k,n/2);
                end
                %
                solver_control.lambda=60*sigm^2*log(630*(n/2)^dim);
                recf2penth = filter_recovery(y,params,solver_control);
                % Save stats
                methodErr(1,sc+1,find(K==k),find(SNR==snr),trial)...
                    = norm(recl(:)-x(:));       % AST
                methodErr(2,sc+1,find(K==k),find(SNR==snr),trial)...
                    = norm(recf8conk(:)-x(:));  % l8conk
                methodErr(3,sc+1,find(K==k),find(SNR==snr),trial)...
                    = norm(recf8conk2(:)-x(:)); % l8conk2
                methodErr(4,sc+1,find(K==k),find(SNR==snr),trial)...
                    = norm(recf2conk(:)-x(:));  % l2conk
                methodErr(5,sc+1,find(K==k),find(SNR==snr),trial)...
                    = norm(recf2conk2(:)-x(:)); % l2conk2
                methodErr(6,sc+1,find(K==k),find(SNR==snr),trial)...
                    = norm(recf2penpr(:)-x(:)); % l2penpr
                methodErr(7,sc+1,find(K==k),find(SNR==snr),trial)...
                    = norm(recf2penth(:)-x(:)); % l2penth
                if ifPost,
                    methodErr(8,sc+1,find(K==k),find(SNR==snr),trial)...
                        = norm(rec_post(:)-x(:)); % post-denoising
                end
            end
        end
    end
    waitbar(trial/N);
end
close(wb);
if dim==1,
    respath = '../sines_sigm/';
else
    if strcmp(exper,'sin'),
        respath = '../sines_sigm-2d/';
    else
        respath = '../SI_sigm-2d/';
    end
end
if ~exist(respath, 'dir')
  mkdir(respath);
end
addpath(respath);
statfile = [respath 'stats-N-' num2str(N) '.mat'];
% if exist(statfile, 'file')==2, delete(statfile); end
save(statfile,'K','SNR','methodErr','-v7.3');
end