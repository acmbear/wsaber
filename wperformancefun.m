function perf = wperformancefun(y, ybar, opt)
%wperformancefun ����Ԥ��ֵ����ֵ֮��Ĳ��죬Ϊ����ѧϰ�Ľ���ṩ���ܶ���
%  INPUT
%    y: ��ֵ���󣬶�ά����Ϊsample����Ϊ��ͬ��Ŀ��
%    ybar: Ԥ��ֵ���󣬶�ά����Ϊsample����Ϊ��ͬ��Ŀ��
%    opt: 'mse'|'rmse'|'r2'|'acc', ����ѡ�
%  OUTPUT
%    perf: ����
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