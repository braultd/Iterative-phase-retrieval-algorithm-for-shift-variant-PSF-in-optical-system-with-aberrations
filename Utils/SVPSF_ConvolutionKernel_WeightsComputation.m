function [ConvolutionKernel,Weights] = SVPSF_ConvolutionKernel_WeightsComputation(U,S,V,X_sub,Y_sub,X_field,Y_field)
% Author : Dylan Brault
% Developped at Université Jean Monnet Saint-Etienne, CNRS, Institut d'Optique Graduate School, Laboratoire Hubert Curien UMR 5516, 42023, Saint-Etienne, France
% Contact : corinne.fournier@univ-st-etienne.fr

% This function compute the mode and weights for SVPSF

% Inputs :
% USV: Singular Value Decomposition of psfs (Low Rank Approximation of rank
% X_sub, Y_sub: Coordinates of position of calibrated PSFs (coarse regular
% grid)
% X_field,Y_field: Coordinates of the pixel grid

% Outputs :
% ConvolutionKernel: Convolution modes for SV convolution
% Weights: Corresponding weights for SV convolution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Weights=[];
ConvolutionKernel=[];

Weights_vec=S*V; % Each column contains weights for one mode on a coarse regular grid
for i=1:size(Weights_vec,1)

    % Reshaping the weights on the regular grid
    Weights_sub=reshape(Weights_vec(i,:),[size(X_sub,1),size(X_sub,2)]);

    % Interpolation of the weights on the pixel grid
    Weights(:,:,i)=interp2(X_sub,Y_sub,Weights_sub,X_field,Y_field,'cubic',0);
    
    % Reshaping the mode on the pixel grid
    ConvolutionKernel(:,:,i)=reshape(U(:,i),[size(X_field,1),size(X_field,2)]); % Each column of U contains a mode
end
end

