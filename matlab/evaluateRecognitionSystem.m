function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('/home/siquike/Documents/Classes/Computer Vision/homework1/dat/traintest.mat');

	% TODO Implement your code here
    
ltest = length(test_imagenames);

for i = 1:ltest
    guessedImage{i} = guessImage(test_imagenames{i});
    test_labels

end


end