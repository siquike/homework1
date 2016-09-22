function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
height = size(wordMap,1);
w = size(wordMap,2);

L = layerNum-1;

addh = ceil(height/2^L)*2^L-height;
addw = ceil(w/2^L)*2^L-w;

extrah = nan(addh,w);
extraw = nan(height+addh,addw);

wordMap = cat(1,wordMap,extrah);
wordMap = cat(2,wordMap,extraw);

newh = (height + addh)/2^L;
neww = (w + addw)/2^L;

hrep = repmat(newh,2^L,1);
wrep = repmat(neww,2^L,1);

C = mat2cell(wordMap,hrep,wrep);

for j = 1:size(C,2)
    for i = 1:size(C,1)
        hdeep{i,j} = histcounts(C{i,j},1:dictionarySize+1);
%         h1 = [h1 h{i,j}];
    end
end


h1 = hdeep(:)';
hlow = cell2mat(h1);

% build lookup matrix
m1 = ones(L,1);
m2 = 2*ones(L,1);
m3 = 3*ones(L,1);
m4 = 4*ones(L,1);

m12 = [m1 m2];
m12d = repmat(m12,1,1,2);
m12d = reshape(m12d,[],1,1);
m34 = [m3 m4];
m34d = repmat(m34,1,1,2);
m34d = reshape(m34d,[],1,1);
indeces = [m12d; m34d];

% idx1 = (indeces == 1)'.*(1:length(indeces));
% idx2 = (indeces == 2)'.*(1:length(indeces));
% idx3 = (indeces == 3)'.*(1:length(indeces));
% idx4 = (indeces == 4)'.*(1:length(indeces));

idx1 = find(indeces == 1);
idx2 = find(indeces == 2);
idx3 = find(indeces == 3);
idx4 = find(indeces == 4);
idxmat = [idx1; idx2; idx3; idx4];

h2comp = hdeep(:);
histlev1 = sum(h2comp{idxmat(1,:),1},1);
histlev2 = sum(h2comp{idxmat(2,:),1},1);
histlev3 = sum(h2comp{idxmat(3,:),1},1);
histlev4 = sum(h2comp{idxmat(4,:),1},1);
histsecond = [histlev1 histlev2 histlev3 histlev4];

prep = [histlev1; histlev2; histlev3; histlev4];
histthird = sum(prep,1);

hlow = hlow/sum(abs(hlow));
histsecond = histsecond/sum(abs(histsecond));
histthird = histthird/sum(abs(histthird));

h = [0.25*histthird 0.25*histsecond 0.5*hlow];


%%    
% i1 = 1;
% j1 = 1;
%     
% h1 = [];    
%     
% nx = size(wordMap,1);
% ny = size(wordMap,2);
% L = layerNum-1;
% C1 = mat2cell(wordMap,nx/2^L,ny/2^L);
% C2 = mat2cell(wordMap,nx/2^(L-1),ny/2^(L-1));
% C3 = mat2cell(wordMap,nx/2^(L-2),ny/2^(L-2));
% 
% nxC1 = size(C1,1);
% nyC1 = size(C1,2);
% % nxC2 = nxC1*2;
% % nyC2 = nyC1*2;
% % nxC3 = nxC2*2;
% % nyC3 = nyC2*2;
% % idxC = sub2ind(size(C),1:nxC,1:nyC)
% 
% for j = 1:nyC1
%     for i = 1:nxC1
%         hdeep{i,j} = histcounts(C1,1:dictionarySize+1);
%         h1 = [h1 hdeep{i,j}];
%     end
% end
% 
% htemp = [];
% nxC2 = size(hdeep,1)/2;
% nyC2 = size(hdeep,2)/2;
% for j = 1:nyC2
%     for i = 1:nxC2
%         htemp = htemp + hdeep{i:nxC2+i-1,j:nxC2+j-1};
%         h2{i1,j1} = ;
%         i1 = i1 +1; 
%     end
%     j1 = j1 +1;
% end
% 
% nxC3 = size(hdeep,1);
% nyC3 = size(hdeep,2);

%%



%%    
%     L = layerNum-1;
% % C = mat2cell(wordMap,nx/2^L,ny/2^L);    
% 
% if layerNum > 1
%     for i = 1:2
%     h = getImageFeaturesSPM(layerNum-1, wordMap, dictionarySize);
%     end
% end
% 
% nx = size(wordMap,1);
% ny = size(wordMap,2);
% 
% 
% % wordMap = wordMap(nx/2,ny/2);
% for i = 1:nx
%     for j = 1:ny
%         temp = histogram(C{i,j},'Normalization','probability');
%         h = [h temp.data(:)'];
%     end
% end
% 
% % for i = 1:L
% %     C = mat2cell(wordMap,nx/i,ny/i);
% % end

end