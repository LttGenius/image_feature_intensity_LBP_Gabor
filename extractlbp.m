function [ lbp_feature_vector ] = extractlbp( GrayImage, BlockSize, ImageSize, varargin )
%EXTRACTLBP Extract LBP feature from grayscale image. 
%------------------------
%
%Parameters
%------------------------
%   GrayImage: Grayscale image. 
%   BlockSize: Size of each block.  
%   ImageSize: Size of each image. If this parameter is given, EXTRACTLBP
%   will peform imresize(GrayImage, ImageSize). The default value of
%   ImageSize is size(GrayImage).
%   R: Circle of radius. 
%   N: Number of sampling points. 
%   MAPPING: See the getmapping function for different mappings and use 0 for no mapping. 
%   MODE: Possible values for MODE are  'h' or 'hist'  to get a histogram of LBP codes,
%            'nh' to get a normalized histogram. Otherwise an LBP code image is returned.
%   
%  Inside the EXTRACTLBP it will split GrayImage into multiple block with
%  size of each block is BlockSize. Block is denoted as I as follows. 
%  Then a LBP is performed on I. 
%   
%   J = LBP(I,R,N,MAPPING,MODE) returns either a local binary pattern
%   coded image or the local binary pattern histogram of an intensity
%   image I. The LBP codes are computed using N sampling points on a
%   circle of radius R and using mapping table defined by MAPPING.
%   See the getmapping function for different mappings and use 0 for
%   no mapping. Possible values for MODE are
%       'h' or 'hist'  to get a histogram of LBP codes
%       'nh'           to get a normalized histogram
%   Otherwise an LBP code image is returned.
%
%   J = LBP(I) returns the original (basic) LBP histogram of image I
%
%   J = LBP(I,SP,MAPPING,MODE) computes the LBP codes using n sampling
%   points defined in (n * 2) matrix SP. The sampling points should be
%   defined around the origin (coordinates (0,0)).
%
% Finally, LBP features for all blocks are spliced into vectors. 
%
% The size of GrayImage must comply with the following constraint.
% size(GrayImage) = BlockSize * n, where n is a positive integer. 
%
%Reture
%------------------------
%   lbp_feature_vector
%
%Example
%-------
% mapping = getmapping(8,'u2');  % get mapping
% unit_norm = 'h';  % no normalise
% LBP_feature1 = extractlbp(imag, [9 10],  [72 70], 1, 8, mapping, unit_norm);
% LBP_feature2 = extractlbp(imag, [9 10],  [ ], 1, 8, mapping, unit_norm);
%
%-----------------------------------------------------------------------
%|  Author: xinyu-pu                            Last update: 1.11.2024|
%-----------------------------------------------------------------------
%   For more information, see <a href=
%   "https://github.com/xinyu-pu/image_feature_intensity_LBP_Gabor">xinyu-pu/image_feature_intensity_LBP_Gabor</a>.
    
    if nargin < 3 || isempty(ImageSize)
        X = GrayImage;
        ImageSize = size(X);
    elsei
        X = imresize(GrayImage, ImageSize);
    end
    
    tmp = ImageSize./BlockSize;
    if tmp ~= fix(tmp)
        error('It is not an integer after chunking');
    end
    row = ones(1, tmp(1))*BlockSize(1);  
    col = ones(1, tmp(2))*BlockSize(2);  
    n = tmp(1) * tmp(2);
    clear tmp;
    

    A = mat2cell(X,row,col);
    H = cell(1, n);
    for i = 1:n
        H{i} = lbp(A{i}, varargin{:});  
    end
    lbp_feature_vector = cat(2, H{:,:});  
    lbp_feature_vector = lbp_feature_vector';
end

