# Structure-Blind Signal Recovery

Matlab reproducible experiments from the [full version](https://arxiv.org/abs/1607.05712) of the following paper:

Dmitrii Ostrovskii, Zaid Harchaoui, Anatoli Judistky, Arkadi Nemirovski. [Structure-Blind Signal Recovery](https://papers.nips.cc/paper/6063-structure-blind-signal-recovery.pdf). NIPS 2016.

We use [AdaFilter](https://github.com/ostrodmit/AdaFilter) codes for the efficient implementation of adaptive signal denoising, including them as a submodule.

# Installation

Download or clone the repository, and add the following paths in **MATLAB**: 
```
l2rec/AdaFilter/code
l2rec/AdaFilter/Brodatz
l2rec/nips16
l2rec/extra
```
# Usage

## Monte-Carlo experiments

Go to ``l2rec/nips16``. The experiments are laucnched via the following three **MATLAB** commands: 
```
exp_spikes(N,n,k,ifReproduce);
exp_spikes2d(N,m,k,ifReproduce);
exp_singleidx(N,m,s,ifReproduce); 
```


