%% Q1.0

% The higher resolution the filter, the more smoothness is applied

% Gaussian Filters: These filters provide the light vs color properties as
% features
% Log Scale Filters: These filters provide edges vs smooth surfaces
% dx Scales: These filters provide vertical edges
% dy Scales: These filters provide horizontal edges
%% Q1.1

filterBank = createFilterBank(); 
I1= gpuArray(imread('sun_aerinlrdodkqnypz.jpg'));
I1 = im2double(I1);
% image(I1)
[filteres] = extractFilterResponses(I1, filterBank);
% image(filteres)