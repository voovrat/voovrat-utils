function B=block_mean(x,block_size)

N = length(x);
M = ceil(N/block_size);

B=zeros(M,1);

for i=1:M

  first = (i-1)*block_size + 1;
  last = min( first + block_size-1, N);
  B(i) = mean(x(first:last));
end
