function [] = exp_singleIdx(N,m,Beta,ifReproduce)
clearvars -except N m Beta ifReproduce
exper = 'SI';
dim = 2;
for beta = Beta
    if ifReproduce
        MC_sigm_sims(dim,0,exper,N,m,beta); % no post-denoising
    end
    MC_sigm_plot_thesis(dim,0,exper,N,m,beta); % nicer-looking plots as in my PhD thesis
end