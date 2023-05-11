<!--
 * @Author: LttGenius 330470351@qq.com
 * @Date: 2022-11-03 00:34:39
 * @LastEditors: LttGenius 330470351@qq.com
 * @LastEditTime: 2022-11-03 01:10:57
 * @Description: 
 * 
 * Copyright (c) 2022 by LttGenius 330470351@qq.com, All Rights Reserved. 
-->
# Image Feature extraction

## intensity
<pre class="matlab-code">
    [ intensity ] = extract_intensity(data,imsize)
</pre>
- data: grayscale image
- imsize：The cropped size of the image

## LBP
<pre class="matlab-code">
    [ lbp_feature ] = extract_LBP(data, block_size,imsize)
</pre>
- data: grayscale image
- block_size：The size of each block
- imsize：The cropped size  of the image  
  
data参数必须给出，block_size必须给出，这里需要注意block_size需要和图像的size搭配好，size(data)./block_size必须为整数，代表意义为分成了 n * m数量的块  
  

## Gabor
<pre class="matlab-code">
    [ gabor_Feature ] = extract_Gabor( data, lambda, theta, block_size, imsize )
</pre>
- data: grayscale image
- lambda：The size of Gabor filter
- theta：The rotation angle of Gabor filter
- block_size：The size of each block
- imsize：The cropped size  of the image  

 data参数必须给出，block_size必须给出，这里需要注意block_size需要和图像的size搭配好，size(data)./block_size必须为整数，代表意义为分成了 n * m数量的块    
   
除此之外lambda和theta也是必须的参数
