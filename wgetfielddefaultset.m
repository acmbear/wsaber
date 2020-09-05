function [y, s] = wgetfielddefaultset(s, field, default)

if isfield(s, field)
    y = s.(field);
else
    y = default;
    s.(field) = default;
end