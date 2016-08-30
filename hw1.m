%% Q1.0

% The higher resolution the filter, the more smoothness is applied

% Gaussian Filters: These filters provide the light vs color properties as
% featurespon
% Log Scale Filters: These filters provide edges vs smooth surfaces
% dx Scales: These filters provide vertical edges
% dy Scales: These filters provide horizontal edges
%% Q1.1

filterBank = createFilterBank(); 
% I1= imread('sun_aerinlrdodkqnypz.jpg');
I1= gpuArray(imread('sun_aerinlrdodkqnypz.jpg'));

filter_Response = extractFilterResponses(I1, filterBank);

image(filter_Response)