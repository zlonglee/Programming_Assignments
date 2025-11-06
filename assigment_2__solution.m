%% Assignment 2: working with EEG data

%% 1
% Download eeg_data_assignment_2.mat from Blackboard, and load its contents
% in your workspace.

% Load the EEG data
load('eeg_data_assignment_2.mat');


%% 2
% What is the mean EEG voltage at 0.1 seconds for occipital channels (i.e.,
% channels whose name contains the letter "O")? And for frontal channels
% (i.e., channels whose name contains the letter "F")?

% Get the indices of occipital and frontal channels
o_chans = find(contains(ch_names, "O"));
f_chans = find(contains(ch_names, "F"));

% Get the index of time point 0.1 seconds
timeIndex01 = find(times == 0.1);

% Compute the mean EEG voltage for occipital and frontal channels at 0.1
% seconds
meanVoltageOccipital = mean(eeg(:, o_chans, timeIndex01), "all");
meanVoltageFrontal = mean(eeg(:, f_chans, timeIndex01), "all");

% Print the mean EEG voltage
fprintf('Mean EEG voltage at 0.1 seconds for occipital channels: %.2f\n', meanVoltageOccipital); % 0.42
fprintf('Mean EEG voltage at 0.1 seconds for frontal channels: %.2f\n', meanVoltageFrontal); % -0.05


%% 3
% On the same plot, visualize the timecourse of the EEG voltage of all 63
% EEG channels, averaged across the 200 image conditions.
% For this, use Matlab's figure, hold on, and plot functions.
% The time dimension should be on the x-axis, and the EEG voltage on the
% y-axis.
% What are the similarities and differences between timecourses of the
% different channels? What do you think is the reason for these
% similarities and differences?

% Average the EEG responses across image conditions
meanEEG = squeeze(mean(eeg, 1));

% Plot the EEG response timecourse for each channel
figure; % Create a new figure
hold on; % Hold on to plot multiple lines
plot(times, meanEEG'); % Plot the mean EEG voltage across all channels
xlabel('Time (s)'); % Label for x-axis
ylabel('Mean EEG Voltage (µV)'); % Label for y-axis
title('Timecourse of EEG Voltage Across All Channels'); % Title for the plot
legend(ch_names); % Add a legend with channel names
hold off; % Release the hold on the current figure


%% 4
% On the same plot, visualize the timecourse of the (i) mean EEG voltage
% across all image conditions and occipital channels, as well as of the
% (ii) mean EEG voltage across all image conditions and frontal channels.
% What are the similarities and differences between the two timecourses?
% What do you think is the reason for these similarities and differences?

% Average the EEG responses across image conditions
meanEEG = squeeze(mean(eeg, 1));

% Get the indices of occipital and frontal channels
o_chans = find(contains(ch_names, "O"));
f_chans = find(contains(ch_names, "F"));

% Average the EEG responses across occipital or frontal channels
meanEEGOccipital = mean(meanEEG(o_chans, :), 1);
meanEEGFrontal = mean(meanEEG(f_chans, :), 1);

% Plot the EEG response timecourses
figure; % Create a new figure
hold on;
plot(times, meanEEGOccipital); % Plot occipital channels
plot(times, meanEEGFrontal); % Plot frontal channels
legend('Occipital Channels', 'Frontal Channels'); % Update legend
xlabel('Time (s)'); % Label for x-axis
ylabel('Mean EEG Voltage (µV)'); % Label for y-axis
title('Timecourse of EEG Voltage For Occipital and Frontal channels'); % Title for the plot
hold off; % Release the hold on the current figure


%% 5
% On the same plot, visualize the timecourse of the (i) mean EEG voltage
% across all occipital channels for the first image condition, as well as 
% of the (ii) mean EEG voltage across all occipital channels for the second
% image condition. What are the similarities and differences between the
% two curves? What do you think is the reason for these similarities and
% differences?

% Get the indices of occipital channels
o_chans = find(contains(ch_names, "O"));

% Average the EEG responses across occipital channels
meanEEGOccipital = squeeze(mean(eeg(:,o_chans, :), 2));

% Plot the EEG response timecourses
figure; % Create a new figure
hold on;
plot(times, meanEEGOccipital(1, :)); % Plot responses for the first image condition
plot(times, meanEEGOccipital(2, :));  % Plot responses for the second image condition
legend('First image condition', 'Second image condition'); % Update legend
xlabel('Time (s)'); % Label for x-axis
ylabel('Mean EEG Voltage (µV)'); % Label for y-axis
title('Timecourse of EEG Voltage for the first two image conditions'); % Title for the plot
hold off; % Release the hold on the current figure
