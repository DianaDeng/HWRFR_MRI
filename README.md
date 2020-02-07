# HWRFR_MRI

The data was from OASIS-2.
For every subject, I downloaded the baseline data--MR1 (1st visit) and simply chose the 1st scan. Then I opened the terminal in the associated directory and entered command line:
"fslchfiletype NIFTI filename.hdr" so that I can get a list of ".nii.gz" files. 

In the folder named "Preprocessing", "ipynb" file merges clinical data from ADNI but we don't use it here; "preprocessing_MRI.R" read in raw image and extract brain; then decompress the ".nii.gz" files manually; finally use "preprocess.m" downsample the data.

Folder "original data" contains downsampled data of extracted brains.

However, as "Fslr" doesn't align the images, which negatively affect the accuracy of classification, we use spm12r to realign them. "Realign" process is usually used before "Co-registration" to align all the scans of one subject. Here although we have different subjects, my goal is to rigidly transform and rotate all the scans into one template. Therefore, the operation is reasonable here.

Folder "aligned data" contains realigned data with improved brain extraction.
Because of file size limit, this folder can only be accessed through google drive link:
https://drive.google.com/drive/folders/1nDav3RLyUqEM4K8TUk-onoYjqIICzQVL?usp=sharing.

The folder named "main functions" contains all functions.

In the folder named "demo", "demo1.m" provides an example for implementing the functions in the 1D case; "demo2.m" provides an example for implementing the functions in the 3D case.

In the folder named "data", "example_1d" includes the data used in "demo1.m"; "image1.nii" and "image2.nii" are two sample images used in "demo2.m"； "image3.nii" and "image4.nii" are copies of "image1.nii" and "image2.nii", only to create more data to do cross validation. (Which may not be a good idea.)

The "glmnet_matlab" folder is download from the website: https://web.stanford.edu/~hastie/glmnet_matlab/.


Dr. Wang (Xuejing Wang from Umich) provided a majority part of the code. Thanks to Dr. Wang. As for the incomplete part in the code, Annan Deng completed them according to her understanding of the work, which includes all the preprocessing code, ROC code and get_beta function.

If any problem, please contact: Annan Deng via annandeng22@gmail.com.

Reference: 

Wang X , Nan B , Zhu J , et al. Classification of ADNI PET images via regularized 3D functional data analysis[J]. Biostatistics & Epidemiology, 2017.

https://www.oasis-brains.org
