% Test on ORL dataset. 
clc
clear
%% path
path='ORL_Faces\'; 
num_view = 3;
nCls = 40;
num_sample = 400;

%% extract feature
count = 1;

% data and ground truth
X = cell( num_view, 1 );  
gt = zeros( num_sample, 1 );  

% each view
intensity_feature_matrix = zeros(4096, num_sample);
LBP_feature_matrix = zeros(3304, num_sample);
Gabor_feature_matrix = zeros(6750, num_sample);

for i=1:40
    data_path = strcat(path, 's',int2str(i), '\');
    for j=1:10
        P=strcat(data_path,  int2str(j), '.pgm');

        % load image
        imag=imread(P); 
%         imag=imresize(imag,[48 48]);
        
        %% get Feature
        % intensity
        intensity_feature_matrix(:, count) = extractintensity(imag, [64 64]);
        
        % lbp
        mapping = getmapping(8,'u2');  % get mapping
        unit_norm = 'h';  % no normalise
        LBP_feature_matrix(:, count) = extractlbp(imag, [9 10],  [72 70], 1, 8, mapping, unit_norm);
        
        % gabor
        Gabor_feature_matrix(:, count) = extractgabor(imag, [4], [0 35 90 135], [25 30], [75 90]);
        
        % gt
        gt(count) = i;
        
        count = count+1;
    end
end
X{1} = intensity_feature_matrix;
X{2} = LBP_feature_matrix;
X{3} = Gabor_feature_matrix;
save test_ORL.mat X gt  % 保存到mat文件
