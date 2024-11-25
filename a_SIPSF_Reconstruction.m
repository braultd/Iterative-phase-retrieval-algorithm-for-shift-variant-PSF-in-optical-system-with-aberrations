% Author : Dylan Brault
% Developped at Laboratoire Hubert Curien
% Contact : corinne.fournier@univ-st-etienne.fr

% File to reconstruct a hologram with a SIPSF hypothesis
% The PSF has been calibrated at the center of the field of view

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

% Load the shift-invariant PSF h_SI estimated at the center of the field of
% view
disp('Loading the shift-invariant PSF...')
load('./Data/PSF_FOV_center.mat')

% Number of iterations of the IPR algorithm
n_iter=200;

% Intialization of the wavefront in the hologram plane
disp('Initializing the reconstructed diffracted wavefront...')
U_diff=padimg(sqrt(data));

for n=1:n_iter
    disp(strcat('Processing: ',' ',num2str(floor(100*n/n_iter)),' % ...'))

    % Backpropagation of the wavefront into the sample plane
    t=backpropagation(h_SI,U_diff);


    % Imposing constraints in the sample plane
    mod_t=abs(t);
    arg_t=angle(t);
    arg_t(arg_t<0)=0; % The phase of the sample is positive
    mod_t(:)=1; % The objects are transparent
    t=mod_t.*exp(1i*arg_t);

    % Propagation of the wavefront into the hologram plane
    U_diff=propagation(h_SI,t);
    
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