function b = sym_mul_scalar(a,k)

[summands_a,koefs_a] = sym_parse_string(a);

b = sym_simplify( sym_to_string(summands_a, k*summands_a]));
