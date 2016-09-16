%% =================================================================
%------------------------------1.1----------------------------------
%  =================================================================

%% Q1.0

% The higher resolution the filter, the more smoothness is applied

% Gaussian Filters: These filters provide the light vs color properties as
% featurespon
% Log Scale Filters: These filters provide edges vs smooth surfaces
% dx Scales: These filters provide vertical edges
% dy Scales: These filters provide horizontal edges
%% Q1.1

% Q1.1 General Initialization


% Create filter bank
filterBank = createFilterBank(); 

% Read Image
I1= gpuArray(imread('sun_aadolwejqiytvyne.jpg'));

filter_Response = extractFilterResponses(I1, filterBank);
filter_Response = gather(filter_Response);

% Local Initialization 1
npx = size(filter_Response,1);
npy = size(filter_Response,2);
npz = 3*ones(1,20);
num_f = length(filterBank);
filter_Response_m = nan(npx,npy,3,num_f);

% Change 3D matrix to 4D
for i = 1:num_f
   filter_Response_m(:,:,:,i) = filter_Response(:,:,3*i-2:3*i);
end

figure(1)
% Show Collage
montage(filter_Response_m,'Size',[4 5])

%% =================================================================
%------------------------------1.2----------------------------------
%  =================================================================
%% Q1.2
fileNames = cell(1,1);
% for i = 1:length(image_names)
% I1= gpuArray(imread(image_names{i}));
% end
dirOutput = {};
fileFolder1 = dir(fullfile('dat','*'));
fileFolder1 = {fileFolder1.name}';
checkvalid = strfind(fileFolder1,'.');
checkvalid = find(cellfun(@isempty,checkvalid));
fileFolder1 = fileFolder1(checkvalid);
for i = 1:length(fileFolder1)
temp = dir(fullfile('dat',fileFolder1{i,1}(1,:),'*.jpg'));
dirOutput{i,1} = {temp.name}';
end

[filterBank, dictionary] = getFilterBankAndDictionary(imPaths)

% for i =1:length(fileFolder1)
%     dirOutput = dir(fullfile(fileFolder1{i,1},'*'));
%     temp = dirOutput.name;
%     fileNames = [fileNames; temp];
% end
% 
% [filterBank, dictionary] = getFilterBankAndDictionary(image_names);

% Q1.2 General Initialization
K = 200;
alpha = 175;
xidx = randperm(size(filter_Response,1),alpha);
yidx = randperm(size(filter_Response,2),alpha);

% Sample part of image for less computation
for i =1:num_f
sample(:,:,3*i-2:3*i) = filter_Response(xidx,yidx,3*i-2:3*i);
end

% Change 3D matrix to 4D
for i = 1:num_f
   sample_m(:,:,:,i) = sample(:,:,3*i-2:3*i);
end

figure(2)
% Show Collage
montage(sample_m,'Size',[4 5])



% Reshaping for kmeans format
sample = reshape(sample,[],3*num_f);

% Implementation of kmeans
[~, dictionary] = kmeans(sample, K, 'EmptyAction','drop');
dictionary = dictionary';

figure(3)
image(dictionary)

%% Q1.3

