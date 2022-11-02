function [ProcessData]=NormalizeData(X, mode)
%NormalizeData 归一化数据
%Parameters
%   X: 待归一化的数据
%   mode: mode==1,按列归一化； mode==2,按行归一化
    [nFea,nSmp] = size(X);
    if mode == 1
        for i = 1:nSmp
            ProcessData(:,i) = X(:,i) ./ max(1e-12,norm(X(:,i)));
        end
    else
         for i = 1:nFea
            ProcessData(i,:) = X(i,:) ./ max(1e-12,norm(X(i,:)));
        end
    end
end