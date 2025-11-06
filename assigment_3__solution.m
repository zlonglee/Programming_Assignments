%% Assignment 3: counterbalancing and pseudorandomization

% We're creating a condition list for an experiment. In 6 blocks,
% participants will view images of familiar and unfamiliar faces; these
% faces will also have a different emotional expression. It's a 2x3
% factorial design:
    % Factor 1 FAMILIARITY ("familiar" vs. "unfamiliar").
    % Factor 2 EMOTION ("positive" vs. "neutral" vs. "negative").

% We will test 60 participants.

% We want to counterbalance the order of blocks across participants, such
% that:
    % (1) 1/2 of participants start with familiar blocks.
    % (2) 1/3 of participants start with blocks corresponding to each
    % emotion.

% We also want each participant to perform the blocks in a pseudorandom
% order, such that blocks corresponding to the same emotion are presented
% consecutively (e.g., "positive familiar" is immediately followed by
% "positive unfamiliar"), but the order of emotions should be random (e.g.
% "neutral" - "negative" - "positive").


%% Parameters
n_subjects = 60;
n_blocks = 6;
familiarity = {'familiar', 'unfamiliar'};
emotions = {'positive', 'neutral', 'negative'};


%% Determine the familiarity block order for each participant

% Empty familiarity order cell array
familiarity_order = cell(n_subjects, n_blocks);

% Number of time that each familiarity condition will have to be repeated
fam_rep = n_blocks / length(familiarity);

% Loop across subjects
for s = 1:n_subjects

    % Even subjects start with familiar conditions, and the odd subjects
    % start with unfamiliar conditions
    if mod(s, 2) == 0 % even subjects
        familiarity_order(s,:) = repmat(familiarity, [1, fam_rep]);
    else % odd subjects
        familiarity_order(s,:) = repmat(familiarity([2 1]), [1, fam_rep]);
    end

end


%% Determine the emotion block order for each participant

% Empty emotion order cell array
emotion_order = cell(n_subjects, n_blocks);

% Number of time that each emotion condition will have to be repeated
emo_rep = n_blocks / length(emotions);

% Loop across subjects
for s = 1:n_subjects

    % Assign one starting emotion to each third of the subjects
    if mod(s, 3) == 0 % first group
        first_emotion = "positive";
    elseif mod(s, 3) == 1 % second group
        first_emotion = "neutral";
    elseif mod(s, 3) == 2 % third group
        first_emotion = "negative";
    end

    % Randomly assign the second and third emotions
    remaining_emo = setdiff(emotions, first_emotion);
    remaining_emo_shuffled = remaining_emo(randperm(length(remaining_emo)));
    second_emotion = remaining_emo_shuffled(1);
    third_emotion = remaining_emo_shuffled(2);

    % Store the emotion block order
    emotion_order(s,:) = cellstr([repmat(first_emotion, [1, emo_rep]), ...
        repmat(second_emotion, [1, emo_rep]), ...
        repmat(third_emotion, [1, emo_rep])]);

end
