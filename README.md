# Cross-Validation-and-Bootstrap-project

Resampling methods of cross-validation and the bootstrap.
These methods refit a model of interest to samples formed from the training set, in order to obtain additional information about the fitted model.
For the cross-validation method th dea is to randomly divide the data into K equal-sized parts. We leave out part k, fit the model to the other
K − 1 parts and then obtain predictions for the left-out kth part.
From the Boostrap method wha we want mainly is to calculate confidence intervals, standard errors and  run hypothesis testing. 
For that, we resample a single data set to create a multitude of simulated samples.
In the exapmples, I used the package ISRL that contains a collection of data sets.
