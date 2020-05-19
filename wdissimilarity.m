function R = wdissimilarity(X,Y,method)
%wdissimilarity calculate dissimilarities between two matrix with columns
%represent samples.
%  INPUT
%    X: 
%    Y:
%    method: 'mse' | 'pearson'
%  OUTPUT
%    R: output dissimilarity matrix
%
%  author: wuhao
%  date: 2020-5-12

assert(size(X,1)==size(Y,1), 'X and Y must have the same row size.')

switch lower(method)
    case 'pearson'
        R = 1 - corr(X,Y);
    case 'mse'
        R = zeros(size(X,2),size(Y,2));
        for i = 1 : size(X,2)
            R(i,:) = mean((X(:,i) - Y).^2);
        end
    otherwise
        R = 1 - corr(X,Y);
end