function [y, group] = wgroupreduce(x,operate,grouping,dim)
%wgroupop group reduce. �Ծ����ĳ��ά�Ȱ��շ�����Ϣ���з���ѹ��
%  INPUT
%    x: �������
%    operate: �����������������Ϊ2ά�������Ϊ1ά���������������Ὣx��ָ��ά��
%             ��������һά��������ת�ɶ�ά������˲������������Զ�ά����Ϊ���룬
%             ��������������ж����������С�
%    grouping: �����ǩ��Ϊ����ʱ�������x��ָ��ά�Ⱦ���ͬ����Ԫ����Ŀ��ÿһ��
%              Ԫ����һ�������ǩ������������xָ��ά�Ⱦ�����ͬ��ǩ��Ԫ�ط�Ϊһ��
%              ���в�����Ϊ����ʱ����ʾ����˳�򽫼���Ԫ�ػ���Ϊһ�顣Ϊ��ʱ����ʾ
%              �����飬Ҳ��������Ԫ�ػ���Ϊһ�顣
%    dim: ָ��Ҫ���в�����ά�ȡ�
%  OUTPUT
%    y: ������󡣺�xά�ȴ�С��ͬ����dimά������ѹ����
%    group: ѹ����ķ�����Ϣ�����groupingΪ��������group����grouping����˼�ǽ�
%           �����dimάÿgroup��Ϊһ�������ѹ�������groupingΪ��������group����
%           ѹ������˳��ÿ��Ԫ�ض�Ӧ�ķ����ǩ��
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

[z,d1,d2] = wdimprompt(x,dim); % ��x��dimά��������һά������ά��˳�򲻱�
sz = size(z);
z = z(:,:); % չ��Ϊ2Ϊ�����м���ԭ��x��dimά�ȡ�
totalrow = size(z,1);

if isempty(grouping) % ��������飬�൱�ڰѸ�ά������Ԫ�ط�Ϊһ��
    y = operate(z);
    group = totalrow;
elseif isscalar(grouping)
    if grouping > totalrow
        warning('grouping greater than size of the dim dimension.');
        grouping = totalrow;
    end
    y = nan(ceil(totalrow/grouping),size(z,2));
    n = 1;
    for i = 1 : grouping : totalrow
        lowind = wQM(i+grouping-1<totalrow,i+grouping-1,totalrow);
        y(n,:) = operate(z(i:lowind,:));
        n = n + 1;
    end
    group = grouping;
else
    assert(length(grouping)==totalrow, 'id must have the same length');
    uid = unique(grouping);
    y = nan(length(uid),size(z,2));
    for i = 1 : length(uid)
        y(i,:) = operate(z(grouping==uid(i),:));
    end
    group = uid;
end
% �ָ���ԭ����ά��
sz(1) = size(y,1);
y = reshape(y,sz);
y = permute(y,d2);
