function y = wgroupop(x,operate,grouping,dim)
%wgroupop group operation. �Ծ����ĳ��ά�Ȱ��շ�����Ϣ���з������
%  INPUT
%    x: �������
%    operate: ��������������������Ὣx��ָ��ά����������һά��������ת�ɶ�ά����
%             ��˲������������Զ�ά����Ϊ���룬��������������ж����������У�
%             ������ľ�������ԭ�����С��ͬ��
%    grouping: �����ǩ��Ϊ����ʱ�������x��ָ��ά�Ⱦ���ͬ����Ԫ����Ŀ��ÿһ��
%              Ԫ����һ�������ǩ������������xָ��ά�Ⱦ�����ͬ��ǩ��Ԫ�ط�Ϊһ��
%              ���в�����Ϊ����ʱ����ʾ����˳�򽫼���Ԫ�ػ���Ϊһ�顣Ϊ��ʱ����ʾ
%              �����飬Ҳ��������Ԫ�ػ���Ϊһ�顣
%    dim: ָ��Ҫ���в�����ά�ȡ�
%  OUTPUT
%    y: ������󡣺�x��С��ͬ��
%
%  author: wuhao
%  date: 2020-5-18

if nargin < 4
    dim = 1;
end
if nargin < 3
    grouping = [];
end
if nargin < 2
    error('need x and operate.');
end

assert(isa(operate,'function_handle'), 'operate must be a function handle which takes a 2 dimensional matrix as input.');
assert(dim <= ndims(x), 'dim out of range.');

[y,d1,d2] = wdimprompt(x,dim); % ��x��dimά��������һά������ά��˳�򲻱�
sy = size(y);
y = y(:,:); % ��yչ��Ϊ2Ϊ�����м���ԭ��x��dimά�ȡ�
totalrow = size(y,1);

if isempty(grouping) % ��������飬�൱�ڰѸ�ά������Ԫ�ط�Ϊһ��
    y = operate(y);
elseif isscalar(grouping)
    step = grouping;
    totalrow = size(y,1);
    for i = 1 : step : totalrow
        lowind = wQM(i+step-1<totalrow,i+step-1,totalrow);
        index = i : lowind;
        y(index,:) = operate(y(index,:));
    end
else
    assert(length(grouping)==totalrow, 'id must have the same length');
    uid = unique(grouping);
    for i = 1 : length(uid)
        index = grouping == uid(i);
        y(index,:) = operate(y(index,:));
    end
end
% �ָ���ԭ����ά��
y = reshape(y,sy);
y = permute(y,d2);
