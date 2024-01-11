function [ NoiseImage ] = addnoise( GrayImage, varargin )
%   ADDNOISE Add multiple noises to grayscale image.
%   ------------------------
%   J = ADDNOISE(I, TypeNoise1, VarNoise1, TypeNoise2, VarNoise2, ...) Add noises of given TYPE to the intensity
%   image I. TypeNoise is a string or char vector that can have one of these.
%       'gaussian'       Gaussian white noise with constant
%                        mean and variance
%
%       'localvar'       Zero-mean Gaussian white noise 
%                        with an intensity-dependent variance
%
%       'poisson'        Poisson noise
%
%       'salt & pepper'  "On and Off" pixels
%
%       'speckle'        Multiplicative noise
%
%       'outlier'        "On and off" pixels in columns
%
%   VarNoise is the corresponding parameter. 
% 
%   Example
%   -------
%   NoiseImage = ADDNOISE( I, 'gaussian', 0, 0.01, 'salt & pepper', 0.5)
%
%-----------------------------------------------------------------------
%|  Author: xinyu-pu                            Last update: 1.11.2024|
%-----------------------------------------------------------------------
%   For more information, see <a href=
%   "https://github.com/xinyu-pu/image_feature_intensity_LBP_Gabor">xinyu-pu/image_feature_intensity_LBP_Gabor</a>.

    % Check the number of input arguments.
    narginchk(3, inf);

    % Check the input-array type.
    validateattributes(GrayImage, {'uint8','uint16','double','int16','single'}, {}, mfilename,...
        'GrayImage', 1);
    
    % Check varargin
    [ TypeNoise, VarNoise, VarIndex, N ] = type_noise_analysis( varargin );

    % Add noise
    for i = 1:N
        var = VarNoise{i};
        switch TypeNoise{i}
            case 'gaussian'
                if VarIndex(i) == 1
                    GrayImage = imnoise(GrayImage, 'gaussian', var(1), var(2));
                else
                    GrayImage = imnoise(GrayImage, 'gaussian');
                end
            case 'salt & pepper'
                if VarIndex(i) == 1
                    GrayImage = imnoise(GrayImage, 'salt & pepper', var);
                else
                    GrayImage = imnoise(GrayImage, 'salt & pepper');
                end
            case 'speckle'
                if VarIndex(i) == 1
                    GrayImage = imnoise(GrayImage, 'speckle', var);
                else
                    GrayImage = imnoise(GrayImage, 'speckle');
                end
            case 'poisson'
                GrayImage = imnoise(GrayImage, 'poisson');
            case 'localvar'
                if VarIndex(i) == 1
                    GrayImage = imnoise(GrayImage, 'localvar', var);
                else
                    GrayImage = imnoise(GrayImage, 'localvar');
                end
            case 'outlier'
                if VarIndex(i) == 1
                    GrayImage = addoutlier( GrayImage, var );
                else
                    GrayImage = addoutlier( GrayImage, 0.5 );
                end
            otherwise
                    error('Unknow type of noise: %s', TypeNoise{ i });
        end
    end
    NoiseImage = GrayImage;
end

function [ TypeNoise, VarNoise, VarIndex, n ] = type_noise_analysis( noises )
% Check noises and split noises. 
%         ALL_TYPE_NOISE = {'gaussian', 'salt & pepper', 'speckle',...
%                 'poisson','localvar','outlier'};
    n = numel( noises );
    % Get TypeNoise, VarNoise, and VarIndex. 
    cnt = 1;
    TypeNoise = cell(6, 1);
    VarNoise = cell(6, 1);
    VarIndex = zeros(6, 1);
    NoiseIndex = 1;
    while cnt <= n
        if ~isnumeric( noises{ cnt } ) 
            TypeNoise{ NoiseIndex } = noises{ cnt };
            if ~isnumeric( noises{ cnt + 1 } ) 
                VarIndex( NoiseIndex ) = 0;
            else
                NumberPara = 1;
                switch noises{ cnt }

                    % gaussian.
                    case 'gaussian'
                        MinimalNParameter = 0;
                        MaximumNParameter = 2;

                    % salt & pepper.
                    case 'salt & pepper'
                        MinimalNParameter = 0;
                        MaximumNParameter = 1;

                    % speckle. 
                    case 'speckle'
                        MinimalNParameter = 0;
                        MaximumNParameter = 1;
                    
                    % localvar.
                    case 'localvar'
                        MinimalNParameter = 0;
                        MaximumNParameter = 2;

                    % outlier.
                    case 'outlier'
                        MinimalNParameter = 0;
                        MaximumNParameter = 1;
       
                    otherwise
                        error('Unknow type of noise: %s', noises{ cnt });
                end
                cnt = cnt + 1;
                tmp = zeros( 1, MaximumNParameter );

                %Get parameters. 
                while isnumeric( noises{cnt} )

                    % Check value. 
                    if NumberPara > MaximumNParameter
                        error('Excessive parameters are given for %s noise: the maxmium number is %d',...
                            TypeNoise{ NoiseIndex }, MaximumNParameter);
                    end
                    tmp{ NumberPara } = noises{ cnt };

                    % Add cnt
                    NumberPara = NumberPara + 1;
                    cnt = cnt + 1;
                end

                % Record Var. 
                VarNoise{ NoiseIndex } = tmp;
                VarIndex( NoiseIndex ) = 1;

                % Check the number of parameter. 
                if NumberPara < MinimalNParameter 
                   error('Too few parameters are given for %s noise: the maxmium number is 2',...
                         TypeNoise{ NoiseIndex }, MinimalNParameter);
                end

                clear MinimalNParameter MaximumNParameter NumberPara tmp
            end
            NoiseIndex = NoiseIndex + 1;
        end
   end
end

function [ OirImage ] = addoutlier( OirImage, var )
% ADDOUTLIER add outlier to image
    if var~=0
        validateattributes(a, {'double', 'single'}, {}, mfilename, ...
              'Parameter of outlier');
        col = randperm(size(OirImage, 2), var);
        for i = 1:var
            OirImage(:,col(i)) = 255;
        end
    end
end