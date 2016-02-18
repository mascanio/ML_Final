function sim = gaussianKernel(x1, x2, sigma)

sumandos = (x1 .- x2).^2;

sim = exp(-(sum(sumandos) / (2 * (sigma ^2))));

endfunction
