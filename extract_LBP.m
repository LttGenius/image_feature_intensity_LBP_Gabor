function [ lbp_feature ] = extract_LBP(data, block_size,imsize)
%EXTRACT_LBP 提取图像的LBP特征
%Parameters
%   data：图像数据（灰度图）
%   imsize: 图像固定的size
%   block_size: 图像分块的大小
% IF two input
%   [ lbp_feature ] = extract_LBP(data, block_size)
%   size(lbp_feature) = 
%       [1, 59*size(data,1)/block_size(1)*size(data,2)/block_size(2)]
%
%IF three input
%   [ lbp_feature ] = extract_LBP(data, block_size, imsize)
%   size(lbp_feature) = 
%       [1, 59*imsize(1)/block_size(1)*imsize(2)/block_size(2)]
%
%必须给出至少data参数和block_size参数
    if nargin < 2
        error('Too few input parameters');
    end
    
    if nargin < 3
        X = data;
        imsize = size(X);
    else
        X = imresize(data, imsize);
    end
    
    tmp = imsize./block_size;
    if tmp ~= fix(tmp)
        error('It is not an integer after chunking');
    end
    row = ones(1, tmp(1))*block_size(1);  % 分块行数
    col = ones(1, tmp(2))*block_size(2);  % 分块列数
    n = tmp(1) * tmp(2);
    clear tmp;
    
    mapping = getmapping(8,'u2');  % 设置编码方式
    A = mat2cell(X,row,col);
    H = cell(1, n);
    
    unit_norm = 'nh';  % norm result
    for i = 1:n
        %H{i} = myLBP(A{i}, 8, mapping);
        H{i} = lbp(A{i}, 1, 8, mapping, unit_norm);  % 改用他人项目构建的LBP算法
    end
    lbp_feature=cat(2, H{:,:});  % 将得到的各个59维度向量进行拼接为行特征向量
end

