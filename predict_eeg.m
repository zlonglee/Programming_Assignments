% Functions for Assignment 5

% Created function (predict_eeg) that use the trained models to predict 
% the EEG responses for the test images. It will accept 4 inputs: the
% dnn_test, weights, intercept and the number of DNN features used. 
% It will return the predicted eeg signal.

function eeg_test_pred = predict_eeg(dnn_test, W, b, numDNN)

% The rest is just a copy of the original script

% Compute the predicted EEG signal for each test image
    dnn_test_used = dnn_test(:, 1:numDNN); % Keep the correct number of DNN features from dnn_test
    [numTest, ~] = size(dnn_test_used);
    [~, numChannels, numTime] = size(W);
    
    eeg_test_pred = zeros(numTest, numChannels, numTime); % predictions
    
    for ch = 1:numChannels
        for t = 1:numTime
            eeg_test_pred(:, ch, t) = dnn_test_used * W(:, ch, t) + b(ch, t);
        end
    end
end