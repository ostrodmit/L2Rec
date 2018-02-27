function [] = exp_spikes2d(N,m,k,ifReproduce)
clearvars -except N m k ifReproduce
exper = 'sin';
if ifReproduce
    MC_sigm_sims(2,0,exper,N,m,k); % no post-denoising
end
MC_sigm_plot_thesis(2,0,exper,N,m,k); % nicer-looking plots as in my PhD thesis