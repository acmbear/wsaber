function [y, group] = wgroupreduce(x,operate,grouping,dim)
%wgroupop group reduce. 对矩阵的某个维度按照分组信息进行分组压缩
%  INPUT
%    x: 输入矩阵
%    operate: 操作函数句柄。输入为2维矩阵，输出为1维行向量。本函数会将x的指定维度
%             提升至第一维，并将其转成二维矩阵，因此操作函数必须以二维矩阵为输入，
%             其操作必须面向行而不是面向列。
%    grouping: 分组标签。为向量时，必须和x的指定维度具有同样的元素数目，每一个
%              元素是一个分组标签。本函数将把x指定维度具有相同标签的元素分为一组
%              进行操作。为标量时，表示按照顺序将几个元素划分为一组。为空时，表示
%              不分组，也即将所有元素划分为一组。
%    dim: 指定要进行操作的维度。
%  OUTPUT
%    y: 输出矩阵。和x维度大小相同，在dim维上有所压缩。
%    group: 压缩后的分组信息。如果grouping为标量，则group等于grouping，意思是将
%           输入的dim维每group个为一组进行了压缩；如果grouping为向量，则group等于
%           压缩后按照顺序每个元素对应的分组标签。
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

[z,d1,d2] = wdimprompt(x,dim); % 将x的dim维提升至第一维，其他维度顺序不变
sz = size(z);
z = z(:,:); % 展开为2为矩阵，行即是原来x的dim维度。
totalrow = size(z,1);

if isempty(grouping) % 如果不分组，相当于把该维度所有元素分为一组
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
% 恢复成原来的维度
sz(1) = size(y,1);
y = reshape(y,sz);
y = permute(y,d2);
