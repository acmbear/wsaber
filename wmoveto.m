function y = wmoveto(x, n1, n2)
%wmoveto �ƶ�������һ��λ�õ�Ԫ������һλ�ô�������Ԫ��˳�򱣳ֲ���
%  INPUT
%    x: ����
%    n1: Ҫ�ƶ�Ԫ�ص�λ��
%    n2: �ƶ���Ԫ�ص�λ��
%  OUTPUT
%    y: �������
%  EXAMPLE
%    x = wmoveto([2,7,9,4],3,1)
%    RESULT: x = [9,2,7,4]
%
%  author: wuhao
%  data: 2020-5-18

assert(isvector(x), 'x must be a vector');
assert(n1>0 && n1<=length(x), 'n1 out of range');
assert(n2>0 && n2<=length(x), 'n2 out of range');

if n1 == n2
    y = x;
elseif n1 < n2
    if n2 < length(x)
        y = [x(1:n2),x(n1),x(n2+1:end)];
    else
        y = [x,x(n1)];
    end
    y(n1) = [];
else
    if n2 > 1
        y = [x(1:n2-1),x(n1),x(n2:end)];
    else
        y = [x(n1),x];
    end
    y(n1+1) = [];
end
