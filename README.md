# PR_HumanActivityRecognitionProblem
The current project uses "WISDM Smartphone and Smartwatch Activity and Biometrics Dataset Data Set" 
https://archive.ics.uci.edu/ml/datasets/WISDM+Smartphone+and+Smartwatch+Activity+and+Biometrics+Dataset+
## Introduction and Objectives
The current project deals with the human activity recognition problem and handles four types of data under three scenarios.

The four types of data are:
* Accelerometer smartwatch data
* Accelerometer smartphone data
* Gyroscope smartwatch data
* Gyroscope smartphone data

The three scenarios are:
* Scenario A is a binary classification problem dealing with Jogging activity recognition.
* Scenario B is a three-class classification problem concerning with hand-oriented activity recognition. The hand-oriented activities are categorized as non-hand-oriented
activities, general hand-oriented activities, and eating hand-oriented activates.
* Scenario C is a 18-class classification problem with regards to properly identify all of
the activities type containing in the dataset.
The datasets were taken from UCI Machine Learning Repository. Considering the effort required to transform the raw time-sequence data, we adopt the dataset with 91 features. The reason of such choice is because the 91 features dataset not only preserve the raw data (i.e. the first 30 features are segmentation of the raw data), but also it contains additional 61 features acquired with common signal processing techniques.
## Techniques
1. EDA
2. Feature Selection with Kruskal-Wallis Method and Feature Ranking
3. Feature Reduction with PCA, LDA and PCA-LDA.
4. Classification with Fisher LDA, MDC, KNN, Bayes, and SVM.
