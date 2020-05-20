function [acc, IDMat] = wvectormatch(x,y,xID,yID,matchMode,statNum,featMask)
%vectormatch identify each sample of x within y and calculate the
%identification accuracy.
%
% INPUT
%    x: N*P matrix, ÿ��Ϊһ��������ÿ����һ����������x�е�ÿһ��������������y��
%       ƥ�������ӽ���������
%    y: M*P matrix, ÿ��Ϊһ��������ÿ����һ��������
%    xID: N��Ԫ�ص���������ʾx��������ǩ��Ϊ��ʱ����ʾ���к�ΪID
%    yID: M��Ԫ�ص���������ʾy��������ǩ��Ϊ��ʱ����ʾ���к�ΪID
%    matchMode: 'mse'|['pearson'],ƥ�䷽��
%    statNum: ƥ����ӽ��ĸ�����
%    featMask: ����ѡ��������ѡ����������ƥ��ȵ�������
%  OUTPUT
%    acc: ��һƥ���׼ȷ�ʡ�x��������ID����y�����ƥ�������ID��ͬ�ı�����
%    IDMat: ��һ��Ϊ���ƥ���yID���ڶ���Ϊ�μ�ƥ���yID���������ơ�һ���������statNum����ֵ��
%           ���ܴ��ڶ��ƥ���������ͬ��ƥ��ȣ���ʱIDMat��Ч�лᳬ��statNum��
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
for sn = 1 : size(dissimMat,1) % ��ÿ����ʶ�������
    dissim = unique(dissimMat(sn,:),'sorted'); % ��С��������
    xCursor = 1;
    for i = 1 : length(dissim)
        id = yID(dissimMat(sn,:)==dissim(i)); % ��һ��ѭ��������ϵ�sn��������xid
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
