function [p, r05, r01, r001] = wcorrtest(N, r)

t = sqrt(N-2)*r./sqrt(1-r.^2);
p = 2*(1-tcdf(abs(t),N-2));

r05 = t2r(tinv(0.975,N-2),N-2);
r01 = t2r(tinv(0.995,N-2),N-2);
r001 = t2r(tinv(0.9995,N-2),N-2);

function r = t2r(t,nu)
r = t./sqrt(t.^2+nu);