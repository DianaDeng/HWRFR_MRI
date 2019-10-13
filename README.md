# HWRFR_PET

In the folder named "Preprocessing", "ipynb" file merges clinical data from ADNI but we don't use it here; "preprocessing_MRI.R" read in raw image and extract brain; "preprocess.m" downsample the data.

For every subject, I downloaded the baseline data--MR1 (1st visit) and simply chose the 1st scan. Then I opened the terminal in the associated directory and entered command line:
"fslchfiletype NIFTI filename.hdr" so that I can get a list of ".nii.gz" files. Afterwards, I used "preprocessing_MRI.R" to read in raw image and extract brain. Finally, I used "preprocess.m" to downsample the data.

The folder named "main functions" contains all functions.

In the folder named "demo", "demo1.m" provides an example for implementing the functions in the 1D case; "demo2.m" provides an example for implementing the functions in the 3D case.

In the folder named "data", "example_1d" includes the data used in "demo1.m"; "image1.nii" and "image2.nii" are two sample images used in "demo2.m"； "image3.nii" and "image4.nii" are copies of "image1.nii" and "image2.nii", only to create more data to do cross validation. (Which may not be a good idea.)

The folder named "real_data" contains all the AD/NC images for building model.

The folder named "predict_data" contains all the MCI/NC images for prediction.

The "glmnet_matlab" folder is download from the website: https://web.stanford.edu/~hastie/glmnet_matlab/.


Dr. Wang (Xuejing Wang from Umich) provided a majority part of the code. Thanks to Dr. Wang. As for the incomplete part in the code, Annan Deng completed them according to her understanding of the work, which includes all the preprocessing code, ROC code and get_beta function.

If any problem, please contact: Annan Deng via annandeng22@gmail.com.

Reference: 

Wang X , Nan B , Zhu J , et al. Classification of ADNI PET images via regularized 3D functional data analysis[J]. Biostatistics & Epidemiology, 2017.

https://jupyter.org/install.html
