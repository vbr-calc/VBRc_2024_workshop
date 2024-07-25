# 2024 VBRc Virtual Workshop Materials 

This repository contains example code and exercises for the 2024 VBRc workshop 
(July 15-18 2024). 

### Workshop Recordings 

The talks and tutorials were recorded and are available for viewing at the following links:

* Day 1 - [Welcome to the VBRc Virtual Workshop](https://vimeo.com/990185409/8e5a9e8a08) (5 minutes)
* Day 1 - [Introducing the VBRc](https://vimeo.com/990199290/e84ba373b5) (18 minutes)
* Day 1 - [Tutorial: Getting Started with the VBRc](https://vimeo.com/990221721/83db0ebc66) (77 minutes)
* Day 1 - Tutorial: Introcuction to Anelasticity with the VBRc (link not avialabe yet)
* Day 2 - [Joseph Byrnes - Connecting the Upper Mantle to Volcanoes in the Western United States](https://vimeo.com/990121861/0a9c7026da) (52 minutes)
* Day 2 - [Tutorial: Interpreting Seismic Obsrevations with the VBRc](https://vimeo.com/990148743/950d92bbc4) (52 minutes)
* Day 3 - [Josh Russell -  Unlocking Pacific upper mantle state using the VBRc: What are the roles of mantle grain size and melt?](https://vimeo.com/989709054/551cf48903) (50 minutes)
* Day 3 - Lightning Talks (link not available yet)
* Day 3 - Harriet Lau & Chris Havlin - Introducing Apparent Viscosity (link not available yet)
* Day 3 - [Harriet Lau - Inference of the Timescale-Dependent Apparent Viscosity Structure in the Upper Mantle Beneath Greenland](https://vimeo.com/989645387/91554d3f42) (28 minutes)
* Day 4 - Chris Havlin - Open source, the VBRc and YOU! (link not available yet)
* Day 4 - Tutorial: Setting up your VBRc development environment and submitting pull requests (link not available yet)

### Workshop Documents 

Workshop documents are availabe in the [public google drive](https://drive.google.com/drive/u/0/folders/121CV5RznanFgpG4B4-4lIJ2ttlpZhNs9)
including:

* [Workshop schedule](https://docs.google.com/document/d/1s9IZf7_B8hd9vwrgVe7HB32SytMeXd55HOiSatlX3A0) 
* [Presentation slides](https://drive.google.com/drive/u/0/folders/17NlclKgLbsuViF9TQv7RiP8KHg1HVpVk)

Archived versions of the presentations are also available at https://doi.org/10.5281/zenodo.12823718 

## Repository Description

This repository contains starter code used during tutorials in the 2024 VBRc Virtual Workshop. 
It is organized by the day of the workshop: 

### Day 1 (`day_1/`) - Basic Usage of the VBRc

This directory contains scripts that introduce how the run the VBRc. The first 
four scripts are designed to be very simple entry points into running calculations:

* `ex_01_basic_usage.m` - setting up and running a calculation 
* `ex_02_adjusting_parameters.m` - understanding how method parameters are set and modified 
* `ex_03_deformation_mech_map.m` - using the VBRc to build a deformation mechanism map for steady state creep
* `ex_04_asthenosphere_properties.m` - calculating some mechanical properties at asthenospheric conditions 

The final script, `ex_05_anelastic_methods_melt.m`, introduces the anelastic methods available in the VBRc 
and compares dependence on melt fraction between anelastic methods.

### Day 2 (`day_2/`) - Interpreting Seismic Observations with the VBRc

This directory contains scripts and functions related to using the VBRc for interpreting seismic observations. 

* `ex_01_bayes_inference_0d.m` : builds a 2D VBRc look up table and runs a gridded bayesian inference. 
* `ex_03_bayes_0d_mcmc_Tonly.m` : a single-parameter (Temperature) markov-chain monte carlo (mcmc) 
inversion with Metropolis-Hastings (MH) sampling.

The final two scripts use a parametrized 1-d temerpature model to introduce depth-dependent simulation. 
* `ex_04_plot_model.m` - calculates and plots the 1d model 
* `ex_05_bayes_1d_mcmc.m` - `ex_01_bayes_inference_0d.m` modified to use the parametrized 1d model.

Note that each of these scripts have corresponding subdirectories in `day_2` that include a number of helper functions.

### Day 3 (`day_3/`) - Mechanical properties across very broad timescales

This directory contains an example of using the new theoretical andrade model in the VBRc (`ex_1_generic_andrade.m`) and 
an example of calculating the complex viscosity (`ex_2_complex_viscosity.m`).

### Requirements 

The code here requires the VBRc (https://vbr-calc.github.io/vbr/).




