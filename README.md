<!--
 * @Author: xinyu-pu pushyu404@163.com
 * @Date: 2024-1-12
 * @LastEditors: LttGenius 330470351@qq.com
 * @LastEditTime: 2024-1-12
 * @Description: 
 * 
 * Copyright (c) by xinyu-pu pushyu404@163.com, All Rights Reserved. 
-->
# Image Feature extraction

## intensity
<pre class="matlab-code">
    [ intensity_feature_vector ] = extractintensity( GrayImage, ImageSize )
</pre>
-   GrayImage: Grayscale image. 
-   lambda: Characteristic scale of Gabor. 
-   theta: Feature Selection Angle of Gabor. 
-   BlockSize: Size of each block.  
-   ImageSize: Size of each image. If this parameter is given, EXTRACTGABOR will peform imresize(GrayImage, ImageSize). The default value of ImageSize is size(GrayImage). The size of GrayImage must comply with the following constraint. ```size(GrayImage) = BlockSize * n```, where n is a positive integer.
  
```extractintensity``` simply extracts intensity from grayscale image. 

If construct code as
<pre class="matlab-code">
    ImageSize = [70 50];
    [ intensity_feature_vector ] = extractintensity( GrayImage, ImageSize )
</pre>
```extractintensity``` will resize ```GrayImage``` to $70\times 50$ pixels. Then the intensity feature is extracted from the resuzed image. 

In contrast, if construct code as
<pre class="matlab-code">
    ImageSize = [70 50];
    [ intensity_feature_vector ] = extractintensity( GrayImage )
</pre>
```extractintensity``` will directly extract intensity feature from the image. 

## LBP
<pre class="matlab-code">
    [ lbp_feature_vector ] = extractlbp( GrayImage, BlockSize, ImageSize, varargin )
</pre>
-   GrayImage: Grayscale image. 
-   BlockSize: Size of each block.  
-   ImageSize: Size of each image. If this parameter is given, EXTRACTLBP
-   will peform imresize(GrayImage, ImageSize). The default value of
-   ImageSize is size(GrayImage).
-   R: Circle of radius. 
-   N: Number of sampling points. 
-   MAPPING: See the getmapping function for different mappings and use 0 for no mapping. 
-   MODE: Possible values for MODE are  
-            'h' or 'hist'  to get a histogram of LBP codes, 'nh' to get a normalized histogram. Otherwise an LBP code image is returned.
-   
-  Inside the EXTRACTLBP it will split GrayImage into multiple block with
-  size of each block is BlockSize. Block is denoted as I as follows. 
-  Then a LBP is performed on I. 
-   
-   J = LBP(I,R,N,MAPPING,MODE) returns either a local binary pattern
-   coded image or the local binary pattern histogram of an intensity
-   image I. The LBP codes are computed using N sampling points on a
-   circle of radius R and using mapping table defined by MAPPING.
-   See the getmapping function for different mappings and use 0 for
-   no mapping. Possible values for MODE are
-       'h' or 'hist'  to get a histogram of LBP codes
-       'nh'           to get a normalized histogram
-   Otherwise an LBP code image is returned.
-
-   J = LBP(I) returns the original (basic) LBP histogram of image I
-
-   J = LBP(I,SP,MAPPING,MODE) computes the LBP codes using n sampling
-   points defined in (n * 2) matrix SP. The sampling points should be
-   defined around the origin (coordinates (0,0)).
-
- Finally, LBP features for all blocks are spliced into vectors. 
-
- The size of GrayImage must comply with the following constraint.
- size(GrayImage) = BlockSize * n, where n is a positive integer. 
  
```extractlbp``` extracts LBP from grayscale image by slicing original image into multiple blocks. 

## Gabor
<pre class="matlab-code">
    [ gabor_feature_vector ] = extractgabor( GrayImage, lambda, theta, BlockSize, ImageSize )
</pre>
-   GrayImage: Grayscale image. 
-   lambda: Characteristic scale of Gabor. 
-   theta: Feature Selection Angle of Gabor. 
-   BlockSize: Size of each block.  
-   ImageSize: Size of each image. If this parameter is given, EXTRACTGABOR
-   will peform imresize(GrayImage, ImageSize). The default value of
-   ImageSize is size(GrayImage).
-
- The size of GrayImage must comply with the following constraint.
- size(GrayImage) = BlockSize * n, where n is a positive integer. 

```extractgabor``` extracts Gabor from grayscale image by slicing original image into multiple blocks. 

## Add noise
<pre class="matlab-code">
    [ NoiseImage ] = addnoise( GrayImage, varargin )
</pre>
-   J = ADDNOISE(I, TypeNoise1, VarNoise1, TypeNoise2, VarNoise2, ...) Add noises of given TYPE to the intensity
-   image I. TypeNoise is a string or char vector that can have one of these.
-       'gaussian'       Gaussian white noise with constant
-                        mean and variance
-
-       'localvar'       Zero-mean Gaussian white noise 
-                        with an intensity-dependent variance
-
-       'poisson'        Poisson noise
-
-       'salt & pepper'  "On and Off" pixels
-
-       'speckle'        Multiplicative noise
-
-       'outlier'        "On and off" pixels in columns
-
-   VarNoise is the corresponding parameter. 

```NoiseImage = ADDNOISE( I, 'gaussian', 0, 0.01, 'salt & pepper', 0.5)```

# Citation
The above algorithms are proposed in the following literature. 
```
@article{lbp,
  title={Multiresolution gray-scale and rotation invariant texture classification with local binary patterns},
  author={Ojala, Timo and Pietikainen, Matti and Maenpaa, Topi},
  journal={IEEE Transactions on pattern analysis and machine intelligence},
  volume={24},
  number={7},
  pages={971--987},
  year={2002},
  publisher={IEEE}
}
```
```
@article{Gabor,
  title={Distortion invariant object recognition in the dynamic link architecture},
  author={Lades, Martin and Vorbruggen, Jan C and Buhmann, Joachim and Lange, J{\"o}rg and Von Der Malsburg, Christoph and Wurtz, Rolf P and Konen, Wolfgang},
  journal={IEEE Transactions on computers},
  volume={42},
  number={3},
  pages={300--311},
  year={1993},
  publisher={IEEE}
}
```

# ATTENTION
This package is free for academic usage. You can run it at your own risk. 

For other purposes, please contact Xinyu Pu (pushyu404@163.com). 

This package was developed by Xinyu Pu.

For any problem concerning the code, please feel free to contact Xinyu Pu (pushyu404@163.com)
