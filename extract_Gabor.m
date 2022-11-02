function [ gabor_Feature ] = extract_Gabor( data, lambda, theta, block_size, imsize )
%EXTRACT_GABOR 提取图像的Gabor特征
%Parameters
%   data：图像数据（灰度图）
%   lambda: Gabor特征尺度
%   theta: Gabor特征选择角度
%   imsize: 图像固定的size
%   block_size: 图像分块的大小
%
%IF four input
%   [ gabor_Feature ] = extract_Gabor( data, lambda, theta, block_size)
%   size(gabor_Feature ) = 
%       [1, size(data,1)*size(data,2)]
%   
%IF five input
%   [ gabor_Feature ] = extract_Gabor( data, lambda, theta, block_size, imsize )
%   size(gabor_Feature ) = 
%       [1, imsize(1)*imsize(2)]
%
%至少需要给出data，lambda，theta，block_size这四个参数
    if nagrin < 4
        error('Too few input parameters');
    end
    
    if nargin < 4
        X = data;
        imsize = size(X);
    else
        X = imresize(data,imsize);
    end

    gaborArray = gabor(lambda, theta);  
    n_g = size(gaborArray, 2);
    
    %% block
    tmp = imsize./block_size;
    if tmp ~= fix(tmp)
        error('It is not an integer after chunking');
    end
    row = ones(1, tmp(1))*block_size(1);  % 分块行数
    col = ones(1, tmp(2))*block_size(2);  % 分块列数
    n = tmp(1) * tmp(2);
    clear tmp;
    A = mat2cell(X,row,col);
    tmp = block_size(1)*block_size(2);
    
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
    gabor_Feature = reshape(gabor_Feature_m,1,n*tmp); 
    
    %% Norm Data
    gabor_Feature = NormalizeData(gabor_Feature, 2);
end

