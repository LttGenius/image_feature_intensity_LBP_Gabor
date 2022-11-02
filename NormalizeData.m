function [ProcessData]=NormalizeData(X, mode)
%NormalizeData ��һ������
%Parameters
%   X: ����һ��������
%   mode: mode==1,���й�һ���� mode==2,���й�һ��
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