function y = wgetfielddefault(s, field, default)

if isfield(s,field)
    y = s.(field);
else
    y = default;
end