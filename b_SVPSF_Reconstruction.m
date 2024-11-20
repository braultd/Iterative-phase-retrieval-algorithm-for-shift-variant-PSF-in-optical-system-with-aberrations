% Author : Dylan Brault
% Developped at Université Jean Monnet Saint-Etienne, CNRS, Institut d'Optique Graduate School, Laboratoire Hubert Curien UMR 5516, 42023, Saint-Etienne, France
% Contact : corinne.fournier@univ-st-etienne.fr

% File to reconstruct a hologram with a SVPSF hypothesis
% The SVPSF has been calibrated on regular grid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;clc;
% Adding auxialary functions to path 
addpath(genpath('./Utils'))

% Load the hologram
load('./Data/data.mat');

% Experimental parameters
pix.nb_x=1000;
pix.nb_y=1000;
pix.dx=82.5e-9;
pix.dy=82.5e-9;
lambda=637.6e-9;
n_0=1.47;
ON=1.2;

% Pixel size of the padded images
pix_pad=pix;
pix_pad.nb_x=2*pix.nb_x;
pix_pad.nb_y=2*pix.nb_y;

% Defining functions of padding and cropping
cropimg=@(x) x(pix.nb_y/2+1:pix.nb_y/2+pix.nb_y,pix.nb_x/2+1:pix.nb_x/2+pix.nb_x);
padimg=@(x) padarray(x,[pix.nb_y/2 pix.nb_x/2],1);

% Load PSFs on regular grid of coordinates X_sub, Y_sub (Each column is a
% PSF)
disp('Loading the calibrated SV-PSF...')
load('./Data/SV_calibrated_PSFs.mat');

% Coordinated of each pixels of the padded image
[X_field,Y_field]=meshgrid(-pix.nb_x:pix.nb_x-1,-pix.nb_y:pix.nb_y-1);

% Low rank approximation of the PSF
disp('Computing the low-rank approximation of the SV-PSF...')
Rank=10; % Rank of the approximation
[U,S,V]=SVPSF_LowRank(K,Rank);
[m,w]=SVPSF_ConvolutionKernel_WeightsComputation(U,S,V,X_sub,Y_sub,X_field,Y_field);
clear U;clear V;clear S; % Clearing the SVD variable to save memory

% Number of iteration of Fienup algorithm
n_iter=40;

% Intialization of the wavefront in the hologram plane
disp('Initializing the reconstructed diffracted wavefront...')
U_diff=padimg(sqrt(data));

% Shift(variant propagation and backpropagtion functions
propagation_= @(x) SVPSF_Propagation(m,w,mtfON,x);
backpropagation_=@(x)SVPSF_BackPropagation(m,w,mtfON,x);

for n=1:n_iter
    disp(strcat('Processing: ',' ',num2str(floor(100*n/n_iter)),' % ...'))
    
    % Backpropagation of the wavefront into the sample plane
    t=backpropagation_(U_diff);

    % Imposing constraints in the sample plane
    mod_t=abs(t);
    arg_t=angle(t);
    arg_t(arg_t<0)=0; % The phase of the sample is positive
    mod_t(:)=1; % The objects are transparent
    t=mod_t.*exp(1i*arg_t);

    % Propagation of the wavefront into the hologram plane
    U_diff=propagation_(t);

    % Imposing data values in the hologram plane
    mod_U_diff=padimg(sqrt(data));
    arg_U_diff=angle(U_diff);
    U_diff=mod_U_diff.*exp(1i*arg_U_diff);

end
disp('Recontruction process completed')

% Cropping the extended reconstruction
t=cropimg(t);

% Display the recontructed transmittance
figure(1);
subplot(1,2,1);imshow(abs(t),[]);colormap(pink);colorbar;title('Modulus of the reconstructed transmittance')
subplot(1,2,2);imshow(angle(t),[]);colormap(pink);colorbar;title('Phase of the reconstructed transmittance')