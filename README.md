# CBCI Challenge WCCI 2020 Subjects Classifiers
This Repository  is for [**CBCI Challenge WCCI 2020**](https://github.com/5anirban9/Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow) submission. The competition was about [**SMR**](https://en.wikipedia.org/wiki/Sensorimotor_rhythm) and **signal classification** problem.
# Table of Contents
* [About dataset](#About-dataset)
* [Requirements](#Requirements)
* [Methods and pipeline for train the model on data](#Methods-and-pipeline-for-train-the-model-on-data)
	* [Within Subjects](#Within_Subjects)
	*  [Cross Subjects](#Cross_Subjects)
* [How to run](#How_to_run)
* [Contributing](#Contributing)
* [License](#License)
# About dataset
[The dataset of the competition "Clinical Brain Computer Interfaces Challenge"](https://github.com/5anirban9/Clinical-Brain-Computer-Interfaces-Challenge-WCCI-2020-Glasgow) is about the EEG data of 10 hemiparetic stroke patients who are impaired either by left or right hand finger mobility. There are two files for each participant. The file name ending with "T" designates the training file, and the file name ending with "E" designates the evaluation/testing file.

# Requirements
To Run the codes you need:
- [matlab](https://www.mathworks.com/products/matlab.html)
- [R](https://www.r-project.org/) : For installing R you can use `sudo apt-get install r-base` for linux (ubuntu) or install R for windows from [this link](https://cran.r-project.org/bin/windows/base/).

# Methods and pipeline for train the model on data

## Within Subjects
For this part of competition we use matlab to filter the data and run [CSP (Common Spatial Patterns)](https://link.springer.com/chapter/10.1007/978-3-642-34381-0_46) to exctract the features of data and make a LDA model to train on features and the prediciting the evaluation file.

Each single subject method describes blow:
### [Subject 1 classifier](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/Subject1_classification.m)
For this subject, first we load the **"Parsed_P01T.mat"** and then use [my2Dmatrix](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/my2Dmatrix.m) function to make a (80*4096 , 12) data. Next we use [mycarfilter](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/mycarfilter.m).  After this we separate the data into 2 dataset correspond to right motor attempt and left motor attempt by [myclassseparator](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/myclassseparator.m "myclassseparator.m") function . Split the features into training sets and test sets for each class and use training sest to dataset to generate **W** parameter and extract the features. ([myCSP.m](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/myCSP.m "myCSP.m") and [myfeatures.m](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/myfeatures.m "myfeatures.m"))
Now we train a LDA model and predict the test set labels to check the accuracy of model.
After all for prediciting **"Parsed_P01E.mat"** we load the dataset and use make a (80*4096 , 12) data, filter with **car filter**, change the dimensions to (4096, 12, 40)
, extract the features with the **W** that we generated previously and finally use the trained LDA model to predict the labels of extracted features.

### [Subject 2 classifier](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/Subject2_classification.m )
For subject 2, first we load the **"Parsed_P02T.mat"** and then use **my2Dmatrix** function to make a (80*4096 , 12) data. Next we use **mycarfilter**.  After this we separate the data into 2 dataset correspond to right motor attempt and left motor attempt by **myclassseparator** function . Split the features into training sets and test sets for each class and use training sest to dataset to generate **W** parameter and extract the features. (**myCSP** and **myfeatures**)
Now we train a LDA model and predict the test set labels to check the accuracy of model.
After all for prediciting **"Parsed_P02E.mat"** we load the dataset and use make a (80*4096 , 12) data, filter with **car filter**, change the dimensions to (4096, 12, 40)
, extract the features with the **W** that we generated previously and finally use the trained LDA model to predict the labels of extracted features.

### [Subject 3 classifier](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/Subject3_classification.m)

First we load the **"Parsed_P03T.mat"** and then use **my2Dmatrix** function to make a (80*4096 , 12) data. Next we use **mycarfilter**.  After this we separate the data into 2 dataset correspond to right motor attempt and left motor attempt by **myclassseparator** function . Split the features into training sets and test sets for each class and use training sest to dataset to generate **W** parameter and extract the features. (**myCSP** and **myfeatures**)
Now we train a LDA model and predict the test set labels to check the accuracy of model.
After all for prediciting **"Parsed_P03E.mat"** we load the dataset and use make a (80*4096 , 12) data, filter with **car filter**, change the dimensions to (4096, 12, 40)
, extract the features with the **W** that we generated previously and finally use the trained LDA model to predict the labels of extracted features.

### [Subject 4 classifier](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/Subject4_classification.m)
For this subject, first we load the **"Parsed_P04T.mat"** and then use **my2Dmatrix** function to make a (80*4096 , 12) data. Next we use **mycarfilter**.  After this we separate the data into 2 dataset correspond to right motor attempt and left motor attempt by **myclassseparator** function . Split the features into training sets and test sets for each class and use training sest to dataset to generate **W** parameter and extract the features. (**myCSP** and **myfeatures**)
Now we train a LDA model and predict the test set labels to check the accuracy of model.
After all for prediciting **"Parsed_P04E.mat"** we load the dataset and use make a (80*4096 , 12) data, filter with **car filter**, change the dimensions to (4096, 12, 40)
, extract the features with the **W** that we generated previously and finally use the trained LDA model to predict the labels of extracted features.

#
## [Subject 5 classifier](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/Subject5_classification.m)
For subject 5, first we load the **"Parsed_P05T.mat"** and then use **my2Dmatrix** function to make a (80*4096 , 12) data. Next we use **mycarfilter**.  After this we separate the data into 2 dataset correspond to right motor attempt and left motor attempt by **myclassseparator** function . Split the features into training sets and test sets for each class and use training sest to dataset to generate **W** parameter and extract the features. (**myCSP** and **myfeatures**)
Now we train a LDA model and predict the test set labels to check the accuracy of model.
After all for prediciting **"Parsed_P05E.mat"** we load the dataset and use make a (80*4096 , 12) data, filter with **car filter**, change the dimensions to (4096, 12, 40)
, extract the features with the **W** that we generated previously and finally use the trained LDA model to predict the labels of extracted features.

### [Subject 6 classifier](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/Subject6_classification.m)
First we load the **"Parsed_P06T.mat"** and then use **my2Dmatrix** function to make a (80*4096 , 12) data. Next we use **mycarfilter**.  After this we separate the data into 2 dataset correspond to right motor attempt and left motor attempt by **myclassseparator** function . Split the features into training sets and test sets for each class and use training sest to dataset to generate **W** parameter and extract the features. (**myCSP** and **myfeatures**)
Now we train a LDA model and predict the test set labels to check the accuracy of model.
After all for prediciting **"Parsed_P06E.mat"** we load the dataset and use make a (80*4096 , 12) data, filter with **car filter**, change the dimensions to (4096, 12, 40)
, extract the features with the **W** that we generated previously and finally use the trained LDA model to predict the labels of extracted features.

### [Subject 7 classifier](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/Subject7_classification.m)
First we load the **"Parsed_P07T.mat"** and use [mybutterfilter](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/mybutterfilter.m) function to filter the data with **butter** and **filtfilt** from 12Hz to 30Hz. Next we use **mycarfilter**.  After this we separate the data into 2 dataset correspond to right motor attempt and left motor attempt by **myclassseparator** function . Split the features into training sets and test sets for each class and use training sest to dataset to generate **W** parameter and extract the features. (**myCSP** and **myfeatures**)
Now we train a LDA model and predict the test set labels to check the accuracy of model.
After all for prediciting **"Parsed_P07E.mat"** we load the dataset and filter the trials with save butterworth filter from 12 to 30 Hz. After that filter the data with **car filter**, change the dimensions to (4096, 12, 40)
, extract the features with the **W** that we generated previously and finally use the trained LDA model to predict the labels of extracted features.

### [Subject 8 classifier](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Within%20Subject%20Classification%20Codes/Subject8_classification.m)
First we load the **"Parsed_P08T.mat"** and use **mybutterfilter** function to filter the data with **butter** and **filtfilt** from 12Hz to 30Hz. Next we use **mycarfilter**.  After this we separate the data into 2 dataset correspond to right motor attempt and left motor attempt by **myclassseparator** function . Split the features into training sets and test sets for each class and use training sest to dataset to generate **W** parameter and extract the features. (**myCSP** and **myfeatures**)
Now we train a LDA model and predict the test set labels to check the accuracy of model.
After all for prediciting **"Parsed_P08E.mat"** we load the dataset and filter the trials with save butterworth filter from 12 to 30 Hz. Next change the dimensions to (4096, 12, 40)
, extract the features with the **W** that we generated previously and finally use the trained LDA model to predict the labels of extracted features.



## Cross Subjects

For this part of competition we use **R programming language**. Frist attach the [**R.matlab**](https://cran.r-project.org/web/packages/R.matlab/index.html) package, and by using [**merging_var_epochs_subjets**](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/a7d1e8830978b7a0e26f9704ba6245e6526ce299/Cross%20Subject%20Classification%20Codes/read_dataset.R#L264) we take variance of each channel in every second (512 data) from the 8 subject dataset that have labels (T files).
Next, split the data to train and test and train a Random Forest model on train and check the accuracy of model. Then for final step we load the data of subject 9 and 10 and take the variacne of each channel in every second and lastly use the trained Random Forest classifier to predict the label of Subject 9 and Subject 10 separately.

# How to run
For running matlab codes, all you need is to clone or download the codes and just change the **T_filename**  and **E_filename** to data directory in your system.

For running R Codes, you must first run the [read_dataset.R](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/master/Cross%20Subject%20Classification%20Codes/read_dataset.R) or you can run [this line](https://github.com/arashHaratian/CBCI-Challenge-WCCI-2020-Subjects-Classifiers/blob/a7d1e8830978b7a0e26f9704ba6245e6526ce299/Cross%20Subject%20Classification%20Codes/S9_10_Classifier.R#L7) (**Do not forget to change the directory**).
> To Running R Code properly, first of all attach the [**R.matlab**](https://cran.r-project.org/web/packages/R.matlab/index.html) package.

Also you can use the **R.studio** to understand the R environment better.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
