function [y, d1, d2] = wdimprompt(x, dim)
%wdimprompt 将某一维度提升至第一维，其他维度顺序保持不变
%  INPUT
%    x: 矩阵
%    dim: 要提升的维度
%  OUTPUT
%    y: 维度提升后的矩阵
%    d1: 提升后相对于提升前的维度顺序
%    d2: 提升前相对于提升后的维度顺序。可以用于后续恢复至提升前的维度
%  EXAMPLE
%    x = randn(3,2,5,7,4);
%    [y, d1, d2] = wdimprompt(x, 3)
%    z = permute(y, d2)
%    RESULT: size(x) = [3,2,5,7,4]
%            size(y) = [5,3,2,7,4]
%            size(z) = [3,2,5,7,4]
%            d1 = [3,1,2,4,5]
%            d2 = [2,3,1,4,5]
%
%  author: wuhao
%  data: 2020-5-18

assert(dim <= ndims(x) && dim > 0, 'dim out of range');

ds = 1 : ndims(x);
d1 = wmoveto(ds,dim,1);
d2 = wmoveto(ds,1,dim);

y = permute(x,d1);
