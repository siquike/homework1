function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here

filter_Response = extractFilterResponses(img, filterBank);

nrow = size(filter_Response,1);
ncol = size(filter_Response,2);
idx = [1 1];
[xidx,yidx] = ind2sub([nrow ncol],idx);
    zidx = ones(alpha,1);

    % Sample part of image for less computation
    for j =1:F
    idx1 = sub2ind(size(filter_Response), xidx, yidx, (3*j-2)*zidx);
    idx2 = sub2ind(size(filter_Response), xidx, yidx, (3*j-1)*zidx);
    idx3 = sub2ind(size(filter_Response), xidx, yidx, 3*j*zidx);
    filter_Responses = [filter_Responses filter_Response(idx1) filter_Response(idx2) filter_Response(idx3)];
    end

for i = 1:length()
p1(:,:) = filter_Response(1,1,:);
p1 = p1';

% [D, wordmap] = pdist2(p1,dictionary,'Smallest');
[D, wordMap] = pdist2(dictionary,p1,'euclidean','Smallest',60);
end

% D
% 
% I

end
