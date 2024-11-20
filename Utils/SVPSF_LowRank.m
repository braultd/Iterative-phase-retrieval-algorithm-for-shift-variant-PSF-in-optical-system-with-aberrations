function [U S V] = SVPSF_LowRank(psfs,rank)
% Author : Dylan Brault
% Developped at Université Jean Monnet Saint-Etienne, CNRS, Institut d'Optique Graduate School, Laboratoire Hubert Curien UMR 5516, 42023, Saint-Etienne, France
% Contact : corinne.fournier@univ-st-etienne.fr

% This function compute the low-rank approximation of the SV-PSF

% Inputs :
% psfs : Calibrated PSFs (each column is a PSF - correspond to matrix K)
% rank : Rank of the low rank approximation


% Outputs :
% USV: Singular Value Decomposition of psfs (Low Rank Approximation of rank
% rank)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[U S V]=svd(psfs,'econ');
V_=V';

U=U(:,1:rank);
S=S(1:rank,1:rank);
V=V_(1:rank,:);

end

