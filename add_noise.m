function [ noise_im ] = add_noise( im , arg, show)
%ADD_NOISE 给图像加噪声
%Parameters
%   im (灰度图像)
%   arg (噪声选项，包括gaussian, sp, outlier)
%   show (为1展示图像)
%
%EXAMPLE
%   contaminatedImage = ADD_NOISE( originImage, struct('gaussion',[0, 0.05], 'sp', 0, 'outlier', 20)

    noise_im = im;
    if isfield(arg, 'gaussian')
        noise_im = imnoise(noise_im, 'gaussian',arg.gaussian(1), arg.gaussian(2));
    end
    if isfield(arg, 'sp')
        noise_im = imnoise(noise_im, 'salt & pepper',arg.sp);
    end
    if isfield(arg, 'outlier')
        n = arg.outlier;
        if n~=0
            col = randperm(size(noise_im,2), n);
        end
        for i = 1:n
            noise_im(:,col(i)) = 255;
        end
    end
    if show==1
        imshow(noise_im);
    end
end

