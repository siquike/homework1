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
I1= gpuArray(imread('sun_aadolwejqiytvyne.jpg'));

filter_Response = extractFilterResponses(I1, filterBank);
filter_Response = gather(filter_Response);
npx = size(filter_Response,1);
npy = size(filter_Response,2);
npz = 3*ones(1,20);
% filter_Response = reshape(filter_Response,187500,60);

for i = 1:length(filterBank)
   filter_Response_m(:,:,:,i) = filter_Response(:,:,3*i-2:3*i);
end

montage(filter_Response_m,'Size',[4 5])

%% Q1.2

% montage(cell_filter_Response,'Parent',cell_filter_Response)
% parfor i= 1:length(filterBank)
%     cellnew{i,1} = filter_Response(:,:,3*i-2:3*i);
% end
% parfor i:length(filterBank)
%     filres = gather(filter_Response());
% end
% image(filter_Response(:,:,7:9))

% K = 3;
% alpha = 20;
% xidx = randperm(size(filter_Response,1),alpha);
% yidx = randperm(size(filter_Response,2),alpha);
% sample = filter_Response(xidx,yidx);


% filter_Response = reshape(filter_Response,187500,60);
% [idx, dictionary] = kmeans(filter_Response, K, 'EmptyAction','drop');

% filter_Response = reshape(filter_Response,187500,60);
% [idx, dictionary] = kmeans(filter_Response, K, 'EmptyAction','drop');
