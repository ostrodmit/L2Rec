# Structure-Blind Signal Recovery

Matlab reproducible experiments from the [full version](https://arxiv.org/abs/1607.05712) of the following paper:

Dmitrii Ostrovskii, Zaid Harchaoui, Anatoli Judistky, Arkadi Nemirovski. [Structure-Blind Signal Recovery](https://papers.nips.cc/paper/6063-structure-blind-signal-recovery.pdf). NIPS 2016.

```
@inproceedings{ostrovsky2016structure,
  title={Structure-Blind Signal Recovery},
  author={Ostrovsky, D and Harchaoui, Z and Juditsky, A and Nemirovski, A},
  booktitle={Advances in Neural Information Processing Systems},
  pages={4817--4825},
  year={2016}
}
```

We use [AdaFilter](https://github.com/ostrodmit/AdaFilter) codes for the efficient implementation of adaptive signal denoising, including them as a submodule.

## Installation

Download or clone the repository, and add the following paths in **MATLAB**: 
```
l2rec/AdaFilter/code
l2rec/AdaFilter/Brodatz
l2rec/nips16
l2rec/extra
```

## Experiments from the main text

Change directory to ``l2rec/nips16``. The experiments are launched via the following three **MATLAB** commands: 
- ``exp_spikes(N,n,k,ifReproduce)``;
- ``exp_spikes2d(N,m,k,ifReproduce)``;
- ``exp_singleidx(N,m,s,ifReproduce)``.
The output is generated in folders ``l2rec/nips16/sines_sigm-1d``, ``l2rec/nips16/sines_sigm-2d``, and ``l2rec/nips16/SI_sigm-2d``.

Note that the names of input parameters coincide with those in the paper: 
- ``N`` is the number of trials; 
- ``n`` is the number of samples in the 1D case; 
- ``m`` is the grid size in the 2D case; 
- ``k`` is the number of spikes; 
- ``s`` is the smoothness index. 
Running a script with ``ifReproduce = 1`` will first launch simulations, and then produce plots for the obtained data. 
After that, ``ifReproduce = 0`` can be used to produce the plots without launching the simulations. 

The choice of parameters in the paper corresponds to:
```
>> exp_spikes(100,100,4,1);
>> exp_spikes2d(40,40,4,1);
>> exp_singleIdx(40,40,2,1);
>> exp_singleIdx(40,40,1,1);
>> exp_singleIdx(40,40,0.5,1);
```
However, the simulations run for hours with these parameters, so one can use smaller values of ``N``, ``n``, ``m`` for faster results.

## Experiments from the supplementary material
