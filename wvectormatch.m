function [acc, IDMat] = wvectormatch(x,y,xID,yID,matchMode,statNum,featMask)
%vectormatch identify each sample of x within y and calculate the
%identification accuracy.
%
% INPUT
%    x: N*P matrix, 每行为一个样本，每列是一个特征。对x中的每一个样本，将会在y中
%       匹配和它最接近的样本。
%    y: M*P matrix, 每行为一个样本，每列是一个特征。
%    xID: N个元素的向量，表示x的样本标签。为空时，表示以行号为ID
%    yID: M个元素的向量，表示y的样本标签。为空时，表示以行号为ID
%    matchMode: 'mse'|['pearson'],匹配方法
%    statNum: 匹配最接近的个数。
%    featMask: 特征选择向量，选择用来计算匹配度的特征。
%  OUTPUT
%    acc: 第一匹配的准确率。x中样本的ID与在y中最佳匹配出来的ID相同的比例。
%    IDMat: 第一列为最佳匹配的yID，第二列为次佳匹配的yID，依次类推。一般情况下有statNum列有值，
%           可能存在多个匹配项具有相同的匹配度，这时IDMat有效列会超过statNum。
%
%  author: wuhao
%  date: 2020-5-12

if ~exist('matchMode','var')
    matchMode = 'pearson';
end
if ~exist('statNum','var')
    statNum = 1;
end
if ~exist('featMask','var') || isempty(featMask)
    featMask = ones(1,size(x,2));
end

if isempty(yID)
    yID = 1:size(y,1);
end
if isempty(xID)
    xID = 1:size(x,1);
end

assert(isvector(yID),'xID should be a vector');
assert(isvector(xID),'yID should be a vector');
assert(size(y,1)==length(yID),'unmatched x and xID');
assert(size(x,1)==length(xID),'unmatched y and yID');

dissimMat = wdissimilarity(x(:,featMask)',y(:,featMask)',matchMode);
idMat = nan(length(xID),length(yID));
for sn = 1 : size(dissimMat,1) % 对每个待识别的样本
    dissim = unique(dissimMat(sn,:),'sorted'); % 由小到大排列
    xCursor = 1;
    for i = 1 : length(dissim)
        id = yID(dissimMat(sn,:)==dissim(i)); % 第一次循环是最符合第sn个样本的xid
        id = unique(id);
        idMat(sn, xCursor:xCursor+length(id)-1) = id;
        xCursor = xCursor+length(id);
        if xCursor > statNum
            break;
        end
    end
end
acc = mean(idMat(:,1)==xID(:));
IDMat = idMat;
