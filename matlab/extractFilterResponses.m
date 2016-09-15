function [filter_Response] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses


	% TODO Implement your code here

%% Initialize    

nResponses = 3*size(filterBank,2);

% Initialize cells for filter responses
temp = cell(length(filterBank), 1);
Ifilt = cell(length(filterBank), 1);

%% Convert input Image to Lab
I = double(img);
if(size(I,3) == 1)
    I = repmat(I,1,1,3);
end	
[L,a,b]= RGB2Lab(I(:,:,1),I(:,:,2),I(:,:,3));
Ilab(:,:,1) = L;
Ilab(:,:,2) = a;
Ilab(:,:,3) = b;

% filter_Response = zeros(pixelCount, totalResponses);

%% Apply filters

for i = 1:length(filterBank)
    filter_Response(:,:,3*i-2:3*i) = convolution(Ilab,filterBank{i,1},0,0);
%     temp{i,1} = convolution(Ilab,filterBank{i,1},0,0);
%     temp{i,1} = [reshape(Ifil(:,:,1),[],nResponses);
%             reshape(Ifil(:,:,2),[],nResponses);
%             reshape(Ifil(:,:,3),[],nResponses)];
end

% for i = 1:length(Ifilt)
%     Ifilt{i,1} = gather(temp{i,1}(:,:));
% end 
% 
% filter_Response = cell2mat(Ifilt);
% filter_Response = temp;


end
