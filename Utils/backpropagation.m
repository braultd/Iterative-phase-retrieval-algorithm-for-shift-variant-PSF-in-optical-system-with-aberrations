function [Ubprop]=backpropagation(propagation_kernel,x)
% Author : Dylan Brault
% Developped at Université Jean Monnet Saint-Etienne, CNRS, Institut d'Optique Graduate School, Laboratoire Hubert Curien UMR 5516, 42023, Saint-Etienne, France
% Contact : corinne.fournier@univ-st-etienne.fr

% This function compute the backpropagation of x using the propagation
% kernel propagation_kernel

% Inputs:
% propagation_kernel: Propagation kernel
% x: Wavfront to be backpropagated


% Outputs:
% Ubprop: Backpropagated wavefront

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Ubprop=ifft2(conj(fft2(propagation_kernel)).*fft2(x));
end
