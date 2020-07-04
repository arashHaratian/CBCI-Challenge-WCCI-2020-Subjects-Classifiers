%% predicitng labels of Subject 3
%%
clc;
clear;
close all;

%% Load the "parsed_P03T.mat"
T_filename = 'C:\Users\arashharatian\Documents\Work\Examples\Cognitive\WCCI2020\competition dataset WCCI2020\Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow-master\T\parsed_P03T.mat'; %put your "parsed_P03T.mat" file here
load(T_filename);

%% Converting the data to 2D Matrix
data = my2Dmatrix(RawEEGData);
%%
data = double(data)*0.1;

%% Filtering data using car filter
data = mycarfilter(data);

%% Separating  the data into two matrices for class 1 and class 2
[data1, data2] = myclassseparator(data, Labels);

%% Spliting data1 and data2 to train set and test set
split_ratio =0.8;
num1 = floor(size(data1, 3)*split_ratio);
num2 = floor(size(data2, 3)*split_ratio);
train_set1 = data1(:, :, 1:num1);
train_set2 = data2(:, :, 1:num2);
test_set1 = data1(:, :, num1+1:end);
test_set2 = data2(:, :, num2+1:end);

%% Using CSP algorithm for extracting the features
[w] = myCSP(train_set1, train_set2, 2);

%% Extracting features of train set and test set
train_set1_feautres = myfeatures(w, train_set1,'log');
train_set2_feautres = myfeatures(w, train_set2, 'log');
test_set1_feautres = myfeatures(w, test_set1, 'log');
test_set2_feautres = myfeatures(w, test_set2, 'log');

%% Ploting features
% myploting(train_set1_feautres, train_set2_feautres, test_set1_feautres, test_set2_feautres);

%% Concatenating train sets and test sets and making labels for them
train_set = [train_set1_feautres, train_set2_feautres];
train_set_label = [ones(1, size(train_set1_feautres, 2)), 2* ones(1, size(train_set2_feautres, 2))];

test_set = [test_set1_feautres, test_set2_feautres];
test_set_label = [ones(1, size(test_set1_feautres, 2)), 2* ones(1, size(test_set2_feautres, 2))];

% you can save the data here and use it in R codes if you like

%% Training the models
%LDA
LDA_model = fitcdiscr(train_set', train_set_label);
LDA_output = predict(LDA_model, test_set');

LDA_accuracy = sum(test_set_label==LDA_output') / numel(LDA_output) *100;
disp(['Accuracy lda: ',num2str(LDA_accuracy), ' %'])

%% Loading the "parsed_P03E.mat"
E_filename = 'C:\Users\arashharatian\Documents\Work\Examples\Cognitive\WCCI2020\competition dataset WCCI2020\Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow-master\E\parsed_P03E.mat'; %put your "parsed_P03E.mat" file here
load(E_filename);

%% Converting the data to 2D Matrix
evaluation_data = my2Dmatrix(RawEEGData);
%%
evaluation_data = double(evaluation_data)*0.1; 

%% Filtering data using car filter
evaluation_data = mycarfilter(evaluation_data);

%%
evaluation_data = my3Dmatrix(evaluation_data);

%% Extracting Features with the same 'w' that previously used in "parsed_P03T.mat"
evaluation_features = myfeatures(w, evaluation_data, 'log');

%% Predicting Labels
%LDA
evaluation_LDA_prediction = predict(LDA_model, evaluation_features');