function y = wqm(cond,firstvalue,secondvalue)
%wQM Question Mark,问号表达式
%  
%  author: wuhao
%  date: 2020-5-18

if cond
    y = firstvalue;
else
    y = secondvalue;
end