# Code details

## Summary
The scripts and functions made with MATLAB to produce the necessary results for the MLE Estimation Project report in TTT4275 - Estimation, Detection and Classification. The two main scripts are run, and are described below.

## Scripts

### generate_singals_and_estimates.m
This is a automated script that when executed produces 500 estimate samples and estimation error samples for all pre-configured combinations of Signal-to-Noise Ratios and FFT sample sizes. For each estimation run, the script produces a new set of signal samples. The results are saved to non-volatile memory for every run to avoid data loss if unexpected errors arise, and the user is informed of the progress of the current run in addition to the overall progress. For further details, please see the Project report. 

### generate_plots.m
This script generates all plots relevant to the lab report.
