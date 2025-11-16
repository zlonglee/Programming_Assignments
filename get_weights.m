% Functions for Assignment 5

% Created function (get_weights) that gets the weights and intercepts. It 
% will accept 4 inputs: the eeg_train dataset, no. of training image 
% conditions, the DNN_train dataset, and number of DNN features. It will 
% return the weights and the intercepts

function [W, b] = get_weights(eeg_train, numTrials_used, dnn_train, DNN_features_used)
    
    % Keep the first N number of training image conditions from eeg_train
    % to be used in the first question
    eeg_train_con_total = eeg_train(1:numTrials_used, :, :);

    % Keep the first N number of training image conditions and the N Number
    % of DNN features from DNN_train to be used in the second question
    dnn_train_fea_total = dnn_train(1:numTrials_used, 1:DNN_features_used);
    
    % The rest is just a copy of the original script

    % Get the data dimension sizes
    [~, numChannels, numTime] = size(eeg_train_con_total);
    numFeatures = size(dnn_train_fea_total, 2);
    
    % Store weights and intercepts
    W = zeros(numFeatures, numChannels, numTime); % regression coefficients
    b = zeros(numChannels, numTime);              % intercepts
    
    % Progressbar parameters
    totalModels = numChannels * numTime;
    modelCount = 0;
    
    % Train a linear regression independently for each EEG channel and time
    % poin
    for ch = 1:numChannels
        for t = 1:numTime
            
            % Extract EEG responses for this channel/time over all trials
            y = eeg_train_con_total(:, ch, t);   % [N x 1]
            
            % Fit linear regression: y = DNN*w + b
            mdl = fitlm(dnn_train_fea_total, y);
            
            % Save parameters
            W(:, ch, t) = mdl.Coefficients.Estimate(2:end); % weights
            b(ch, t)    = mdl.Coefficients.Estimate(1);     % intercept
    
            % Update progress bar
            modelCount = modelCount + 1;
            fprintf('\rTraining models: %d / %d (%.1f%%)', ...
                modelCount, totalModels, 100*modelCount/totalModels);
    
        end
    end
end