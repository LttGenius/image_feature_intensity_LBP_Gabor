<!--
 * @Author: LttGenius 330470351@qq.com
 * @Date: 2022-11-03 00:34:39
 * @LastEditors: LttGenius 330470351@qq.com
 * @LastEditTime: 2022-11-03 01:10:57
 * @Description: 
 * 
 * Copyright (c) 2022 by LttGenius 330470351@qq.com, All Rights Reserved. 
-->
# ͼ��������ȡ

## intensity
<pre class="matlab-code">
    [ intensity ] = extract_intensity(data,imsize)
</pre>
- data: �Ҷ�ͼ��
- imsize��ͼ�����²ü���Ĵ�С  
  

data�������������imsize���Բ��ø�����
���������imsize���������ڲ��Ὣͼ��ü�Ϊimsize��С

## LBP
<pre class="matlab-code">
    [ lbp_feature ] = extract_LBP(data, block_size,imsize)
</pre>
- data: �Ҷ�ͼ��
- block_size�����Ҷ�ͼ��ü��ֿ��ÿһ��Ĵ�С
- imsize��ͼ�����²ü���Ĵ�С   
  
data�������������block_size���������������Ҫע��block_size��Ҫ��ͼ���size����ã�size(data)./block_size����Ϊ��������������Ϊ�ֳ��� n * m�����Ŀ�  
  

## Gabor
<pre class="matlab-code">
    [ gabor_Feature ] = extract_Gabor( data, lambda, theta, block_size, imsize )
</pre>
- data: �Ҷ�ͼ��
- lambda��Gabor�˲����ߴ�
- theta��Gabor�˲�����ת�Ƕ�
- block_size�����Ҷ�ͼ��ü��ֿ��ÿһ��Ĵ�С
- imsize��ͼ�����²ü���Ĵ�С    

 data�������������block_size���������������Ҫע��block_size��Ҫ��ͼ���size����ã�size(data)./block_size����Ϊ��������������Ϊ�ֳ��� n * m�����Ŀ�    
   
����֮��lambda��thetaҲ�Ǳ���Ĳ���