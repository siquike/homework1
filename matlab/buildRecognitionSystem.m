function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('/home/siquike/Documents/Classes/Computer Vision/homework1/dat/traintest.mat');

	% TODO create train_features
dictionary = dictionary';
l = length(train_imagenames);
% ltest = length(test_imagenames);

dictionarySize = size(dictionary,1);
layerNum = 3;
histograms = nan(dictionarySize*(4^layerNum-1)/3,l);
for i = 1:l
    train_imagenames{i} = strrep(train_imagenames{i},'.jpg','.mat');
    wordMap = load(train_imagenames{i});
    wordMap = wordMap.wordMap;
    histograms(:,i) = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
end

% for i = 1:ltest
%     test_imagenames{i} = strrep(test_imagenames{i},'.jpg','.mat');
%     wordMap = load(test_imagenames{i});
%     wordMap = wordMap.wordMap;
%     wordHist = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
%     histInter(i,:) = distanceToSet(wordHist', histograms);
% end

train_features = histograms;

train_labels = train_labels';

	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end