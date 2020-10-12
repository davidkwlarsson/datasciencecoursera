
# Getting and cleaning data Course Project

The script for creating a cleaned up dataset is found in "run_analysis.R"
Running this will:
    - Read the training and test data.
    - Concatenate these into a single dataset.
    - Add labels to the columns in the dataset.
    - Pick out the columns containing means and std.
    - Finally calculate the mean and std for these values for each subject and activity

The results will be put in the text file "Tidy.txt"

In CodeBook.md a summary of the contents of the cleaned up data is shown.