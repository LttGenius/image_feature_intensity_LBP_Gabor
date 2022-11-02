% ORL 数据集测试

path='C:\Users\LttGenius\Documents\Face\ORL_Faces\'; 
%这里只需要定位到ORL数据集中40个文件夹所在路径，程序会自动读取目录下所有子文件夹里面的所有数据

count=1;
X=cell(1,3);  % 特征结果 分别为intensity LBP Gabor
gt = zeros(1,400);  % 标签结果（只适用于ORL数据集）
intensity_feature_matrix = zeros(400, 4096);
LBP_feature_matrix = zeros(400, 3304);
Gabor_feature_matrix = zeros(400, 6750);
for i=1:40
    tmp=strcat('s',int2str(i));
    P0=strcat(path,tmp);
    P0=strcat(P0,'\');
    for j=1:10
        P=strcat(P0,int2str(j));
        P=strcat(P,'.pgm');
        imag=imread(P); % load
        imag=imresize(imag,[48 48]);
        % get Feature
        int = extract_intensity(imag, [64 64]);
        l = extract_LBP(imag, [9 10],  [72 70]);
        g = extract_Gabor(imag, [4], [0 35 90 135], [25 30], [75 90]);
        intensity_feature_matrix(count,:) = int;
        LBP_feature_matrix(count,:) = l;
        Gabor_feature_matrix(count,:) = g;
        gt(count) = i;
        count=count+1;
    end
end
X{1} = intensity_feature_matrix;
X{2} = LBP_feature_matrix;
X{3} = Gabor_feature_matrix;
save test_my_ORL.mat X gt  % 保存到mat文件
