function histInter = distanceToSet(wordHist, histograms)
% Compute distance between a histogram of visual words with all training image histograms.
% Inputs:
% 	wordHist: visual word histogram - K * (4^(L+1) − 1 / 3) × 1 vector
% 	histograms: matrix containing T features from T training images - K * (4^(L+1) − 1 / 3) × T matrix
% Output:
% 	histInter: histogram intersection similarity between wordHist and each training sample as a 1 × T vector

	% TODO Implement your code here
n = length(wordHist); 
wordHist = repmat(wordHist,size(histograms,2),1);
% swh = size(wordHist)
% sh = size(histograms)
histograms = histograms(:);

% sh = size(histograms)
h = [wordHist histograms];
minimum = min(h,[],2);
% minimum = bsxfun(@min,wordHist,histograms)
% histInter = sum(min(h,[],1));
tosum = reshape(minimum,n,[]);
histInter = bsxfun(@sum,tosum,1);

end