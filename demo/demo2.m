%The example shows how to obtain C matrix from real images (.nii format)

%myFolder = '...\HWRFR';
myFolder = '/Users/dengannan/Desktop/Research/bin nan/Paper Code/HWRFR/data';
% image3 copies iamge1; image4 copies image2
filePattern = fullfile(myFolder, '*.nii');
niiFiles = dir(filePattern);
n=length(niiFiles);
img=zeros(n,160,160,96);
for k = 1:n
  baseFileName = niiFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  vol= spm_vol(fullFileName); % the vol struct
  img(k,:,:,:) = spm_read_vols(vol); %read .nii file
end

Y = [1; 2; 1; 2];
lambda=linspace(0.6,1,3);

% wmaxlev function cannot be applied in 3D case...
level=1;


%Apply 3D Haar wavelet transform (dim=3) to each image and obtain the C
%matrix (C_levels).
[C_levels,size_X] = getCmatrix(img,level,3);

%Then apply functions "hwrfr_cv" and "getbeta" for the 3D case.
result =hwrfr_cv(level,lambda,2,C_levels, Y,2);

result.eta = result.eta_auc;
result.level = result.level_auc;
beta_est= getbeta(result.eta,result.level,3,size_X);

%Note that this is only an example, and in practice, n will be much larger.
