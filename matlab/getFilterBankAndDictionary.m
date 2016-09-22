function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

filterBank  = createFilterBank();

% TODO Implement your code here

T = length(imPaths);
F = length(filterBank);
alpha = 200;
K = 300;

% filter_Responses = zeros(alpha*T,3*F);
filter_Responses = [];

for i = 1:T
    % Read Image
    I1= gpuArray(imread(imPaths{i}));

    filter_Response = extractFilterResponses(I1, filterBank);
    nrow = size(filter_Response,1);
    ncol = size(filter_Response,2);
    idx = randperm(nrow*ncol,alpha)';
    [xidx,yidx] = ind2sub([nrow ncol],idx);
    zidx = ones(alpha,1);

    % Sample part of image for less computation
%     for j =1:F
%     idx1 = sub2ind(size(filter_Response), xidx, yidx, (3*j-2)*zidx);
%     idx2 = sub2ind(size(filter_Response), xidx, yidx, (3*j-1)*zidx);
%     idx3 = sub2ind(size(filter_Response), xidx, yidx, 3*j*zidx);
% %     filter_Responses(1:alpha,3*j-2:3*j) = [filter_Response(idx1) filter_Response(idx2) filter_Response(idx3)];
%     filter_Responses = [filter_Responses filter_Response(idx1) filter_Response(idx2) filter_Response(idx3)];
%     end
    for j = 1:length(yidx)
        for k =1:length(xidx)
            sample(k,j,:) = filter_Response(xidx(k),yidx(j),:); 
        end
    end
    filter_Responses = [filter_Responses; sample];

% sample = gather(sample);
% sample = reshape(sample,[],3*F);
%     
%     size(sample,1)
%     size(sample,2)
%     
%     size(filter_Responses,1)
%     size(filter_Responses,2)
%     filter_Responses(i*alpha-alpha+1:i*alpha,:) = sample;
end

filter_Responses = gather(filter_Responses);

filter_Responses = reshape(filter_Responses,[],3*F);
% size(filter_Responses);

% Reshaping for kmeans format
% filter_Responses = reshape(filter_Responses,[],3*F);

% % Local Initialization 1
% npx = size(filter_Responses,1);
% npy = size(filter_Responses,2);
% npz = 3*ones(1,20);
% Q1.2 General Initialization

% Implementation of kmeans
[~, dictionary] = kmeans(filter_Responses, K, 'EmptyAction','drop');
dictionary = dictionary';
    
end
