function [ lbp_feature ] = extract_LBP(data, block_size,imsize)
%EXTRACT_LBP ��ȡͼ���LBP����
%Parameters
%   data��ͼ�����ݣ��Ҷ�ͼ��
%   imsize: ͼ��̶���size
%   block_size: ͼ��ֿ�Ĵ�С
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
%�����������data������block_size����
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
    row = ones(1, tmp(1))*block_size(1);  % �ֿ�����
    col = ones(1, tmp(2))*block_size(2);  % �ֿ�����
    n = tmp(1) * tmp(2);
    clear tmp;
    
    mapping = getmapping(8,'u2');  % ���ñ��뷽ʽ
    A = mat2cell(X,row,col);
    H = cell(1, n);
    
    unit_norm = 'nh';  % norm result
    for i = 1:n
        %H{i} = myLBP(A{i}, 8, mapping);
        H{i} = lbp(A{i}, 1, 8, mapping, unit_norm);  % ����������Ŀ������LBP�㷨
    end
    lbp_feature=cat(2, H{:,:});  % ���õ��ĸ���59ά����������ƴ��Ϊ����������
end

