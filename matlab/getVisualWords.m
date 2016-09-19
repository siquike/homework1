function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here

    
%% Visual Words on Filter Response    

% filter_Response = extractFilterResponses(img, filterBank);
% 
% nrow = size(filter_Response,1);
% ncol = size(filter_Response,2);
% idx = 1:nrow*ncol;
% [xidx,yidx] = ind2sub([nrow ncol],idx);
% 
% lfil = (1:3*size(filterBank,1))';
% 
% for i = 1:nrow*ncol
%     temp = permute(filter_Response(xidx(i),yidx(i),:),[2 3 1]);
%     [~, indeces] = pdist2(dictionary,temp,'euclidean','Smallest',60);
%     ldind = sub2ind(size(dictionary), indeces, lfil);
%     wordMap(xidx(i),yidx(i),:) = dictionary(ldind);
% end

%% Visual Words on actual Image

% filter_Response = extractFilterResponses(img, filterBank);
n = size(filterBank,1);

img = double(img);
if(size(img,3) == 1)
    img = repmat(img,1,1,3);
end	
% img = repmat(img,1,1,n);
nrow = size(img,1);
ncol = size(img,2);
idx = 1:nrow*ncol;
[xidx,yidx] = ind2sub([nrow ncol],idx);
lfil = (1:3)';

for j = 1:n
    for i = 1:nrow*ncol
        subdic = dictionary(:,3*j-2:3*j);
        temp = permute(img(xidx(i),yidx(i),:),[2 3 1]);
        [~, indeces] = pdist2(subdic,temp,'euclidean','Smallest',3);
        ldind = sub2ind(size(subdic), indeces, lfil);
        wordMap(xidx(i),yidx(i),3*j-2:3*j) = subdic(ldind);
    end
end


end
