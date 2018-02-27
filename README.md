# Structure-Blind Signal Recovery

Matlab reproducible experiments from the [full version](https://arxiv.org/abs/1607.05712) of the following paper:

Dmitrii Ostrovskii, Zaid Harchaoui, Anatoli Judistky, Arkadi Nemirovski. [Structure-Blind Signal Recovery](https://papers.nips.cc/paper/6063-structure-blind-signal-recovery.pdf). NIPS 2016.

We use [AdaFilter](https://github.com/ostrodmit/AdaFilter) codes for the efficient implementation of adaptive signal denoising, including them as a submodule.

# Usage

Download or clone the repository, and add the following paths in **MATLAB**: 
```
l2rec/AdaFilter/code
l2rec/AdaFilter/Brodatz
l2rec/nips16
l2rec/extra
```
To reproduce the Monte-Carlo experiments from the main text, go to ``l2rec/nips16``, and run in **MATLAB**: 
```
>> exp_spikes(N,n,k,1);
>> exp_spikes2d(N,m,k,1);
>> exp_singleidx(N,m,k,1);
``` 
