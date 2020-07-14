function s = wsem(x, dim)

if nargin == 1
    dim = find(size(x) ~= 1, 1);
    if isempty(dim)
        dim = 1;
    end
end

xs = std(x, 0, dim);
s = xs ./ sqrt(size(x,dim));