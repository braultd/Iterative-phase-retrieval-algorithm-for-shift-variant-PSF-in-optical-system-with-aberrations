# Iterative phase retrieval algorithm for shift variant PSF in optical system with aberrations
## Dylan Brault(1), Corinne Fournier(1), Tatiana Latychevskaia(2,3)
1. Université Jean Monnet Saint-Etienne, CNRS, Institut d'Optique Graduate School, Laboratoire Hubert Curien UMR 5516, 42023, Saint-Etienne, France
2. Physics Department, University of Zurich, Winterthurerstrasse 190, 8057 Zurich, Switzerland.
3. Paul Scherrer Institute, Forschungsstrasse 111, 5232 Villigen, Switzerland.

Corresponding author: corinne.fournier@univ-st-etienne.fr

The ``Data`` folder can be downloaded at the following adress: https://drive.google.com/file/d/1zrVA5jfapa9p2hSyF9bAOHa3wxlPJ6bP/view?usp=drive_link

#
In this folder you will find all the functions and a data example to perform SIPSF and SVPSF reconstructions with Fienup ER algorithm.

+ To run an SIPSF reconstruction, use ``SIPSF_Reconstruction.m`` file
+ To run an SVPSF reconstruction, use ``SVPSF_Reconstruction.m`` file

``Data`` folder contains data files to perform the reconstructions provided in Fig.1 (with fewer PSF (P=16, Q=10))
- ``data.mat``: Contains simulated data for SVPSF hologram formation model and the MTF corresponding to filtering by numerical aperture
- ``PSF_FOV_center.mat``: Contains the calibrated PSF at the center of the field of view
- ``SV_calibrated_PSFs.mat``: Contains the calibration of the SV-PSF on the coarse grid and position X_sub and Y_sub of the calibrations

``Utils`` folder contains auxiliary files to compute reconstruction using both methods:
- ``propagation`` computes the computes the propagation of x using the propagation kernel propagation_kernel (with convolution)
- ``backpropagation`` computes the computes the backpropagation of x using the propagation kernel propagation_kernel (with convolution)
- ``SVPSF_Propagation`` computes the computes the propagation of x using an SV-PSF hypothesis 
- ``SVPSF_BackPropagation`` computes the computes the propagation of x using an SV-PSF hypothesis 
- ``SVPSF_ConvolutionKernel`` computes weights and modes decomposition of an SVPSF
- ``SVPSF_LowRank`` computes the low-rank approximation for SVPSF computation
