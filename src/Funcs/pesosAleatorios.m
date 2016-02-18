function W = pesosAleatorios(L_in, L_out)

epsilon = (sqrt(6) / sqrt(L_in + L_out));
W = rand(L_out, L_in + 1) .* (2 * epsilon) .- epsilon;

endfunction
