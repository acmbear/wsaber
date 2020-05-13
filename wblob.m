function m = wblob(m,dim,num,method)

% <m> is a matrix
% <dim> is the dimension to work on
% <num> is the positive number of elements to blob over
% 
% sum (or apply method) over each successive group of size <num> along dimension <dim>.
% we assume that the size of <m> along <dim> is evenly divisible by <num>.
%
% example:
% isequal(blob([1 2 3 4; 1 1 1 1],2,2),[3 7; 2 2])

% get out early
if dim > ndims(m)
  assert(num==1);
  return;
end

% desired size of the result
dsize = size(m);
dsize(dim) = dsize(dim)/num; assert(isint(dsize(dim)));

% do it
m = reshape2D(m,dim);
switch lower(method)
    case 'sum'
        m = reshape2D_undo(squish(sum(reshape(m,num,size(m,1)/num,[]),1),2),dim,dsize);
    case 'mean'
        m = reshape2D_undo(squish(mean(reshape(m,num,size(m,1)/num,[]),1),2),dim,dsize);
    case 'max'
        m = reshape2D_undo(squish(max(reshape(m,num,size(m,1)/num,[]),[],1),2),dim,dsize);
    case 'min'
        m = reshape2D_undo(squish(min(reshape(m,num,size(m,1)/num,[]),[],1),2),dim,dsize);
    otherwise
        m = reshape2D_undo(squish(sum(reshape(m,num,size(m,1)/num,[]),1),2),dim,dsize);
end