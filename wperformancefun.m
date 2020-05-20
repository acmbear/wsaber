function perf = wperformancefun(y, ybar, opt)
%wperformancefun 计算预测值与真值之间的差异，为机器学习的结果提供性能度量
%  INPUT
%    y: 真值矩阵，二维，行为sample，列为不同的目标
%    ybar: 预测值矩阵，二维，行为sample，列为不同的目标
%    opt: 'mse'|'rmse'|'r2'|'acc', 性能选项。
%  OUTPUT
%    perf: 性能
%
%  author: wuhao
%  date: 2020-5-12

if strcmpi(opt,'mse')
    perf = mean((y-ybar).^2);
elseif strcmpi(opt,'rmse')
    perf = squre(mean((y-ybar).^2));
elseif strcmpi(opt,'r2')
    perf = diag(corr(y,ybar)).^2;
    perf = perf';
elseif strcmpi(opt,'acc')
    perf = mean(y==ybar);
else
    error('need performance option, such as ''mse'' and ''acc''.');
end