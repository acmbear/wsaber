function p = wrandchange(N,m)

assert(N>0, 'N must be positive integer.');
assert(m>1, 'm must be greater than 1.');
assert(N>=m, 'N must be equal or greater than m.');

if N > m
    p = 1:N;
    x = randperm(N,m);
    y = x(randpermfull(m));
    p(x) = y;
elseif N == m
    p = randpermfull(N);
end