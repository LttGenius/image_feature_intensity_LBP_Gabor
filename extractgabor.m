function [ gabor_feature_vector ] = extractgabor( GrayImage, lambda, theta, BlockSize, ImageSize )
%EXTRACTGABOR Extract gabor feature from grayscale image. 
%------------------------
%
%Parameters
%------------------------
%   GrayImage£: Grayscale image. 
%   lambda: Characteristic scale of Gabor. 
%   theta: Feature Selection Angle of Gabor. 
%   BlockSize: Size of each block.  
%   ImageSize: Size of each image. If this parameter is given, EXTRACTGABOR
%   will peform imresize(GrayImage, ImageSize). The default value of
%   ImageSize is size(GrayImage).
%
% The size of GrayImage must comply with the following constraint.
% size(GrayImage) = BlockSize * n, where n is a positive integer. 
%
%Reture
%------------------------
%   gabor_Feature_vector
%
%Example
%-------
%   gabor_Feature1 = EXTRACTGABOR( I, [4], [0 35 90 135], [25 30], [75 90])
%   gabor_Feature2 = EXTRACTGABOR( I, [4], [0 35 90 135], [25 30]) % size(I)
%   = [25, 30] *n, where n is a positive integer. 
%
%-----------------------------------------------------------------------
%|  Author: xinyu-pu                            Last update: 1.11.2024|
%-----------------------------------------------------------------------
%   For more information, see <a href=
%   "https://github.com/xinyu-pu/image_feature_intensity_LBP_Gabor">xinyu-pu/image_feature_intensity_LBP_Gabor</a>.


    
    if nargin < 4
        X = GrayImage;
        ImageSize = size(X);
    else
        X = imresize(GrayImage, ImageSize);
    end

    gaborArray = gabor(lambda, theta);  
    n_g = size(gaborArray, 2);
    
    %% block
    tmp = ImageSize./BlockSize;
    if tmp ~= fix(tmp)
        error('ImageSize must be an integer multiple of BlockSize');
    end
    row = ones(1, tmp(1)) * BlockSize(1);  
    col = ones(1, tmp(2)) * BlockSize(2);  
    n = tmp(1) * tmp(2);
    clear tmp;
    A = mat2cell(X,row,col);
    tmp = BlockSize(1)*BlockSize(2);
    
    %% apply the filter to check the image
    gabor_Feature_m = zeros(tmp, n);
    for i = 1:n
        outMag = imgaborfilt(A{i}, gaborArray);
        res = 0;
        for j = 1:n_g
            res = res + outMag(:,:,j);
        end
        res = res / n_g;
        gabor_Feature_i = reshape(res,tmp,1);
        gabor_Feature_m(:, i) = gabor_Feature_i;
    end
    gabor_feature_vector = reshape(gabor_Feature_m, n*tmp, 1); 
end

