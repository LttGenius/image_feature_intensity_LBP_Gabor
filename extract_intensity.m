function [ intensity ] = extract_intensity(data,imsize)
%EXTRACT_INTENSITY 提取图像的强度特征
%Parameters
%   data：图像数据（灰度图）
%   imsize: 图像固定的size
%
%IF only one input 
%   I=extract_intensity(data)
%   size(I)=(1, size(data,1)*size(data,2))
%
%IF two input
%   I=extract_intensity(data_sets, imsize)
%   size(I)=(1,  imsize(1)*imsize(2))
%   此时会把所有图像size改变为imsize
%
%load(data.mat)
%size(data)=[100 100]
%imsize=[64 64];
%I=extract_intensity(data_sets, imsize)
%size(I)=[1 4096]
    if nargin < 2
        X = data;
        n=size(data,1)*size(data,2);
    else
        X = imresize(data, imsize);
        n=imsize(1)*imsize(2);
    end
    intensity=reshape(X,1,n);  % 按列拼接展开为行向量
    
    %% Norm Data
    intensity=im2double(intensity);
    intensity = NormalizeData(intensity, 2);
end