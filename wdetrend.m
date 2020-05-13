function D = wdetrend(X,k,method,mode)
% X: input matrix
% k: trend order
% method: 'poly' | 'dct'
% mode: 0 | 1
%   0: detrend all trends include mean
%   1: detrend all trends except mean

if nargin == 2
    method = 'dct';
    mode = 0;
elseif nargin == 3
    mode = 0;
end
[m,~] = size(X);

if strcmpi(method,'poly')
    for i = 0:k
        d = (1:m).^i;
        regs(:,i+1) = d(:);
    end
elseif strcmpi(method,'dct')
    n = (0:(m-1))';
    regs(:,1) = ones(m,1)/sqrt(m);
    for i=2:k
        regs(:,i) = sqrt(2/m)*cos(pi*(2*n+1)*(i-1)/(2*m));
    end
else
    error('Incorrect Usage.');
end

switch mode
    case 0
        D = X - regs*(pinv(full(regs))*X);
    case 1
        D = X - regs(:,2:end)*(pinv(regs(:,2:end))*X);
end
