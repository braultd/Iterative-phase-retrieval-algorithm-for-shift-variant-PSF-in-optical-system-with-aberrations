function [Uprop] = SVPSF_BackPropagation(ConvolutionKernel,Weights,mtfON,x)
% Author : Dylan Brault
% Developped at Université Jean Monnet Saint-Etienne, CNRS, Institut d'Optique Graduate School, Laboratoire Hubert Curien UMR 5516, 42023, Saint-Etienne, France
% Contact : corinne.fournier@univ-st-etienne.fr

% This function compute the shift-varying propagation

% Inputs:
% ConvolutionKernel: Convolution kernel obtained by SVD decomposition
% Weights: Weigths map associated to the convolution kernel (obtained by
% SVD decomposition
% mtfON: MTF correspond to filtering by numerical aperture
% x: Wavefront to be propagated (centered on 1)


% Outputs:
% Uprop: Propagated wavefront

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Supression of the DC component of the signal
x=x-1; 

% Initialization of the wavefront
Uprop=zeros(size(x)); 


% Low rank approximation of the convolution
for k=1:size(ConvolutionKernel,3)

    % Computation of the Fourier transform of k-th mode (conjugation for
    % back-propagation
    FTConvKern=conj(fft2(ConvolutionKernel(:,:,k)));
    % Setting the phase at the origin of FTConvKern (thus, the phase origin
    % is on the sample plane.
    FTConvKern(1,1)=abs(FTConvKern(1,1));

    % Computation of the shift-variant convolution (the weights are
    % conjugated for the backpropagation)
    Uprop=Uprop+ifft2(fft2(conj(Weights(:,:,k)).*x).*FTConvKern.*mtfON);
end

% Adding DC component of the signal
Uprop=Uprop+1;

end


