%% Assignment 5

%{
Question 1: Effect of training data amount on encoding accuracy:
- Train EEG encoding models using different amounts of training image conditions
[250, 1000, 10000, 16540].
- Test each of the encoding models on the same test data (i.e., the 200 test images
and corresponding fMRI responses).
- Plot the prediction accuracies of each amount of training image conditions over
time, averaged across all EEG channels (i.e., one time course curve per amount of
training data).
- What pattern do you observe, and what do you think are the reasons of this
pattern?
%}

% Load the data
load("data_assignment_5.mat")

% Created function (get_weights) that gets the weights and intercepts in
% another file named get_weights.m. It will accept 4 inputs: the eeg_train 
% dataset, no. of training image conditions, the DNN_tratin dataset, and 
% number of DNN features. It will return the weights and the intercepts

% Created function (predict_eeg) in another file named predict_eeg.m that 
% use the trained models to predict the EEG responses for the test images. 
% It will accept 4 inputs: the dnn_test, weights, intercept and the number 
% of DNN features used. It will return the predicted eeg signal.

% Created function (predict_acc) in another file named predict_acc.m that 
% computes the prediction accuracy using Pearson's correlation. It will 
% accept 2 inputs: the eeg_test and the predicted eeg signals. It will 
% return the correlation for each channel at each time point 

% Create a for loop that loops through the 4 different numbers of training
% conditions [250, 1000, 10000, 16540] and plot their results

% Create the figure to plot all the conditions together
figure;
hold on;

numDNN = 100; % Set the number of DNN features

% Use a for loop to iterate through each condition and plot them
for numCond = [250, 1000, 10000, 16540]
    [W, b] = get_weights(eeg_train, numCond, dnn_train, numDNN); 
    eeg_test_pred = predict_eeg(dnn_test, W, b, numDNN);
    R = predict_acc(eeg_test, eeg_test_pred);
    meanR = mean(R, 1);

    % Plot the mean correlation over time
    plot(meanR);
    
end

hold off

% Label graph
xlabel('Time (seconds)');
Ntime = size(eeg_test, 3);
xticks(1:Ntime);
xticklabels(times);
ylabel('Mean Pearson Correlation');
title('Prediction Accuracy Over Time');
grid on;
set(gca, 'FontSize', 15);
legend(["250 Training Conditions","1,000 Training Condition", ...
    "10,000 Training Condition","16,540 Training Condition"]) % Get legend

%{
Question: What pattern do you observe, and what do you think are the reasons of this
pattern?

Answer: Before 0.05 seconds, the prediction accuracy of the four encoding
models were close to 0. This is likely because visual stimuli were shown at
0.0 seconds in training conditions and time is needed for the eyes to 
process such infomration and transmit it to the relevant brain regions. 
Hence, correlation in brain activities during these training conditions 
would be low during this time period and this is reflected in the 
prediction accuracy. 

Prediction accuracy of the four encoding models had their first peak around
0.09 to 0.13 seconds before declining and peaking again around 0.30 
seconds. They have similar prediction accuracy variations at these timings 
because brain activities during these timepoints throughout the different 
image conditions might be most correlated with image perception. 

The encoding models that used more trainig image conditions generally had 
higher prediction accuracy over time compared to encoding models that used 
fewer training image conditions. This is expected since with more training 
image conditions, the encoding models can better predict the EEG signals of
other trials, leading to higher prediction accuracy. However, the
prediction accuracy of encoding models with 10,000 and 16,540 image 
conditions were relatively similar. This suggests that there is likely a
limit to how accurate the encoding models can predict EEG signals after a
certain number of trainig image conditions have been reached. 
%}

%%

%{
Question 2: Effect of DNN feature amount on encoding accuracy:
- Train EEG encoding models using different amounts of DNN features [25, 50, 75,
100].
- Test each of the encoding models on the same test data (i.e., the 200 test images
and corresponding fMRI responses).
- Plot the prediction accuracies of each amount of DNN features over time, averaged
across all EEG channels (i.e., one time course curve per amount of DNN Features).
- What pattern do you observe, and what do you think are the reasons of this
pattern? 
%}

% Reuse all the functions that were created. The first function already
% accounts for the number of DNN features used (last input). 

% Create a for loop that loops through the 4 different numbers of DNN
% features [25, 50, 75, 100] and plot their results

% Create the figure to plot all the conditions together
figure;
hold on;

numCond = 16540; % Set the number of training image conditions

% Use a for loop to iterate through each condition and plot them
for numDNN = [25, 50, 75, 100]
    [W, b] = get_weights(eeg_train, numCond, dnn_train, numDNN); 
    eeg_test_pred = predict_eeg(dnn_test, W, b, numDNN);
    R = predict_acc(eeg_test, eeg_test_pred);
    meanR = mean(R, 1);

    % Plot the mean correlation over time
    plot(meanR);
    
end

hold off

% Label graph
xlabel('Time (seconds)');
Ntime = size(eeg_test, 3);
xticks(1:Ntime);
xticklabels(times);
ylabel('Mean Pearson Correlation');
title('Prediction Accuracy Over Time');
grid on;
set(gca, 'FontSize', 15);
legend(["25 DNN Features","50 DNN Features", ...
    "75 DNN Features","100 DNN Features"]) % Get legend


%{
Question: What pattern do you observe, and what do you think are the reasons of this
pattern?

Answer: The encoding models that used more DNN features generally have
higher prediction accuracy over time compared to encoding models that used 
fewer DNN features. This is expected as with higher DNN features, the
encoding models has more data to build better models that can better 
predict the EEG signals of the other trials. This leads to higher 
prediction accuracy.
%}
