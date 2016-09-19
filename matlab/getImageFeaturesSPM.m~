function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
L = layerNum-1;
C = mat2cell(wordMap,nx/2^L,ny/2^L);    

if layerNum > 1
    h = getImageFeaturesSPM(layerNum-1, wordMap, dictionarySize);
end

nx = size(wordMap,1);
ny = size(wordMap,2);


% wordMap = wordMap(nx/2,ny/2);
for i = 1:nx
    for j = 1:ny
        h{i,j
        = histogram(C{i,j},'Normalization','probability');
    end
end

% for i = 1:L
%     C = mat2cell(wordMap,nx/i,ny/i);
% end

end