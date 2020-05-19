function [y, d1, d2] = wdimprompt(x, dim)
%wdimprompt ��ĳһά����������һά������ά��˳�򱣳ֲ���
%  INPUT
%    x: ����
%    dim: Ҫ������ά��
%  OUTPUT
%    y: ά��������ľ���
%    d1: ���������������ǰ��ά��˳��
%    d2: ����ǰ������������ά��˳�򡣿������ں����ָ�������ǰ��ά��
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
