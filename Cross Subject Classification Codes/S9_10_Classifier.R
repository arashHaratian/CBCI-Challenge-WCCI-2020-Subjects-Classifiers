# Predicitng labels of Subject 9 and Subject 10

# Loading the requirement packages
library(R.matlab)  #for installing this package use :   install.packages("R.matlab")

# Run the "read_dataset.R" file or load the .RData file 
load("~/Work/Repositories/Cognitive/WCCI CBCIC 2020/Cross Subject Classification Codes/.RData")  #change the directory

# Importing Subject 1 to 8 for training the model
data_set_path <- "~/Work/Examples/Cognitive/WCCI2020/competition dataset WCCI2020/Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow-master/T/" #change this to the directory that have just T files
mydata <- merging_var_epochs_subject(dir = data_set_path, num = 8, type = 't')  #this function take the variance of each cahnnel in every trails and label it
mydata <- as.data.frame(mydata)
mydata <- change_col_names(mydata) 
mydata$Labels <- as.factor(mydata$Labels)

# Splitting mydata
library(caTools)
split_index <-  sample.split(mydata$Labels, SplitRatio = 0.8)
training_set <- subset(mydata, split_index == TRUE)
test_set <- subset(mydata, split_index == FALSE)

# Train the classifier
# Random Forest
library(randomForest)
classifier.RF <- randomForest(data = training_set, x = training_set[-13], y = training_set$Labels, ntree = 200)
y_hat <- predict(classifier.RF, test_set[-13])
#Confusion Matrix
cm <- table(test_set[, 13], y_hat)
cm
acc <- (cm[1,1]+cm[2,2])/length(test_set[,1])
acc

# Importing S9 dataset
S9E_path <- "~/Work/Examples/Cognitive/WCCI2020/competition dataset WCCI2020/Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow-master/E/parsed_P09E.mat" #change this to the directory that have S9 dataset
evaluation_data <- reading_mat_file(S9E_path)
evaluation_data <- var_epochs(data = evaluation_data)
evaluation_data <- as.data.frame(evaluation_data)
evaluation_data <- change_col_names(evaluation_data) 

RF_Prediction_labels.S9 <- predict(classifier.RF, evaluation_data)
RF_Prediction_labels.S9 <- matrix(as.numeric(RF_Prediction_labels.S9), nrow = 8)
RF_Prediction_labels.S9 <- colMeans(RF_Prediction_labels.S9)

# Importing S10 dataset
S10E_path <- "~/Work/Examples/Cognitive/WCCI2020/competition dataset WCCI2020/Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow-master/E/parsed_P10E.mat" #change this to the directory that have S9 dataset
evaluation_data <- reading_mat_file(S10E_path)
evaluation_data <- var_epochs(data = evaluation_data)
evaluation_data <- as.data.frame(evaluation_data)
evaluation_data <- change_col_names(evaluation_data) 


RF_Prediction_labels.S10 <- predict(classifier.RF, evaluation_data)
RF_Prediction_labels.S10 <- matrix(as.numeric(RF_Prediction_labels.S10), nrow = 8)
RF_Prediction_labels.S10 <- colMeans(RF_Prediction_labels.S10)