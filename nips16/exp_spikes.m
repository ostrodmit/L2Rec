function [] = exp_spikes(N,n,k,ifReproduce)
clearvars -except N n k ifReproduce
exper = 'sin';
if ifReproduce
    MC_sigm_sims(1,0,exper,N,n,k); % no post-denoising
end
MC_sigm_plot_thesis(1,0,exper,N,n,k); % nicer-looking plots as in my PhD thesis