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
I1= gpuArray(imread('labelme_aqpunnqmctisquh.jpg'));

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
temp = {temp.name}';
ntemp = length(temp);
dirOutput = [dirOutput;temp];
end

[filterBank, dictionary] = getFilterBankAndDictionary(dirOutput)

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

%% Q1.2 test

imPaths = cell(2,1);
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
temp = {temp.name}';
ntemp = length(temp);
dirOutput = [dirOutput;temp];
end

for i = 1:2
imPaths{i,1} = dirOutput{1:2,1};
end

[filterBank, dictionary] = getFilterBankAndDictionary(imPaths)

%%

computeDictionary()

%% 1.3
imagesc(dictionary')
%%

load('dictionary.mat')
dictionary = dictionary';
I= imread('labelme_aqpunnqmctisquh.jpg');

[wordMap] = getVisualWords(I, filterBank, dictionary);

% batchToVisualWords(4)

%%
figure
imagesc(wordMap)
%%

% num_f = length(filterBank);
% % Change 3D matrix to 4D
% for i = 1:num_f
%    wordMap_m(:,:,:,i) = wordMap(:,:,3*i-2:3*i);
% end
% 
% figure
% % Show Collage
% montage(wordMap_m,'Size',[4 5])

%%
% figure
% % norm = wordMap(:)./sum(wordMap(:));
% h1 = hist(wordMap(:),200);
% h1 = h1/sum(abs(h1));
% % h = histogram(wordMap_m,'Normalization','probability');
% % assert(numel(h) == dictionarySize);

% [h] = getImageFeatures(wordMap, 200);
%% Q2.2
layerNum = 3;
dictionarySize = size(dictionary,1);

[h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)


%% Test of spm

h = size(wordMap,1)
w = size(wordMap,2)
layerNum = 3;
L = layerNum-1;

addh = ceil(h/2^L)*2^L-h
addw = ceil(w/2^L)*2^L-w

extrah = nan(addh,w);
extraw = nan(h+addh,addw);

wordMap1 = cat(1,wordMap,extrah);
wordMap1 = cat(2,wordMap1,extraw);

newh = (h + addh)/2^L;
neww = (w + addw)/2^L;

hrep = repmat(newh,2^L,1);
wrep = repmat(neww,2^L,1);

C = mat2cell(wordMap1,hrep,wrep);

%%

[h] = getImageFeaturesSPM(3, wordMap, 100)

%%
A = [1 2 3 4 5 6 7 8 9 10]';
B = [.9 1.9 2.9 3.9 4.9 5.9 6.9 7.9 8.9 9.9;4 3 2 1 2 3 4 5 6 7; 8 5 6 4 7 3 2 1 4 5]';

histInter = distanceToSet(A, B)

%%

buildRecognitionSystem()

%%

load('dictionary.mat');
	load('/home/siquike/Documents/Classes/Computer Vision/homework1/dat/traintest.mat');

	% TODO create train_features
dictionary = dictionary';
l = length(train_imagenames);
dictionarySize = size(dictionary,1);
layerNum = 3;
histograms = nan(dictionarySize*(4^layerNum-1)/3,l);
for i = 1:l
    train_imagenames{i} = strrep(train_imagenames{i},'.jpg','.mat');
    wordMap = load(train_imagenames{i});
    wordMap = wordMap.wordMap;
    histograms(:,i) = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
end

%%

guessedImage = guessImage('labelme_cbahlipqcrjpbuc.jpg') 