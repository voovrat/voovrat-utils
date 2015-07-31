function c=sym_sub(a,b)

[summands_a,koefs_a] = sym_parse_string(a);
[summands_b,koefs_b] = sym_parse_string(b);

c = sym_simplify(sym_to_string([summands_a; summands_b],[koefs_a; -koefs_b]));
