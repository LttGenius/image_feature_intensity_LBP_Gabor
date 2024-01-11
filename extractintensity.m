function [ intensity_feature_vector ] = extractintensity( GrayImage, ImageSize )
%EXTRACTINTENSITY Extract intensity feature from grayscale image. 
%------------------------
%
%Parameters
%------------------------
%   GrayImage£ºGrayscale image. 
%   ImageSize: Size of each image. If this parameter is given,
%   EXTRACTINTENSITY will peform imresize(GrayImage, ImageSize). The default value of
%   ImageSize is size(GrayImage).
%
%Reture
%------------------------
%   intensity_feature_vector
%
%Example
%-------
%   intensity_Feature1 = EXTRACTINTENSITY( I, [64 64])
%   intensity_Feature2 = EXTRACTINTENSITY( I ) 
%
%-----------------------------------------------------------------------
%|  Author: xinyu-pu                            Last update: 1.11.2024|
%-----------------------------------------------------------------------
%   For more information, see <a href=
%   "https://github.com/xinyu-pu/image_feature_intensity_LBP_Gabor">xinyu-pu/image_feature_intensity_LBP_Gabor</a>.


    if nargin < 2
        X = GrayImage;
        n=size(GrayImage,1)*size(GrayImage,2);
    else
        X = imresize(GrayImage, ImageSize);
        n=ImageSize(1)*ImageSize(2);
    end
    intensity=reshape(X,n,1);  
    intensity_feature_vector = im2double(intensity);
end