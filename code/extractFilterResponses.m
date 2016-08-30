function [filter_Response] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses

totalResponses = length(filterBank)*3;

%Convert input Image to Lab
doubleI = double(I);
[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
pixelCount = size(doubleI,1)*size(doubleI,2);

%filterResponses:    a W*H x N*3 matrix of filter responses
Ifilt = cell(length(filterBank), 1);
filter_Response = zeros(pixelCount, totalResponses);



%for each filter and channel, apply the filter, and vectorize

% === fill in your implementation here  ===
Ilab(:,:,1) = L;
Ilab(:,:,2) = a;
Ilab(:,:,3) = b;

parfor i = 1:length(filterBank)
    Ifil = convolution(Ilab,filterBank{i,1},0,0);
    % image(Ifil)
    temp{i,1} = [reshape(Ifil(:,:,1),[],totalResponses);
            reshape(Ifil(:,:,2),[],totalResponses);
            reshape(Ifil(:,:,3),[],totalResponses)];
%     filterResponses(i:size(Ifilt),:) = temp;
%     counter = i + size(temp,1);
%     filterResponses(size(Ifil),:) = Ifil;
%     filterResponses = IfilL;
end

for i = 1:length(Ifilt)
    Ifilt{i,1} = gather(temp{i,1}(:,:));
end 

filter_Response = cell2mat(Ifilt);

% filterResponses = gather(filterResponses);
% for i = 1:length(Ifilt)
%     filterResponses = [filterResponses; 
%                             Ifilt{i,1}]; 
% end

% image(L*a*b)

% L
% a
% b
% I1 = imfilter(sun,filterBank{1,1});

% A = convmtx(h,n)
end
