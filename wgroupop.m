function y = wgroupop(x,operate,grouping,dim)
%wgroupop group operation. 对矩阵的某个维度按照分组信息进行分组操作
%  INPUT
%    x: 输入矩阵
%    operate: 操作函数句柄。本函数会将x的指定维度提升至第一维，并将其转成二维矩阵，
%             因此操作函数必须以二维矩阵为输入，其操作必须面向行而不是面向列，
%             操作后的矩阵必须和原矩阵大小相同。
%    grouping: 分组标签。为向量时，必须和x的指定维度具有同样的元素数目，每一个
%              元素是一个分组标签。本函数将把x指定维度具有相同标签的元素分为一组
%              进行操作。为标量时，表示按照顺序将几个元素划分为一组。为空时，表示
%              不分组，也即将所有元素划分为一组。
%    dim: 指定要进行操作的维度。
%  OUTPUT
%    y: 输出矩阵。和x大小相同。
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

[y,d1,d2] = wdimprompt(x,dim); % 将x的dim维提升至第一维，其他维度顺序不变
sy = size(y);
y = y(:,:); % 将y展开为2为矩阵，行即是原来x的dim维度。
totalrow = size(y,1);

if isempty(grouping) % 如果不分组，相当于把该维度所有元素分为一组
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
% 恢复成原来的维度
y = reshape(y,sy);
y = permute(y,d2);
