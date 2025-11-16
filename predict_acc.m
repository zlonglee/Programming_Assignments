% Functions for Assignment 5

% Create function (predict_acc) that computes the prediction accuracy 
% using Pearson's correlation. It will accept 2 inputs: the eeg_test and
% the predicted eeg signals. It will return the correlation for each 
% channel at each time point 

function R = predict_acc(eeg_test, eeg_test_pred)

% Compute the prediction accuracy using Pearson's correlation

[~, Nchannels, Ntime] = size(eeg_test);

% Preallocate correlation matrix
R = zeros(Nchannels, Ntime);

for ch = 1:Nchannels
    for t = 1:Ntime
        % Get test responses across images
        real_vec = squeeze(eeg_test(:, ch, t));
        pred_vec = squeeze(eeg_test_pred(:, ch, t));

        % Compute Pearson correlation
        R(ch, t) = corr(real_vec, pred_vec, 'Type', 'Pearson');
    end
end
