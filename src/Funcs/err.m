function J = err(params_rn, num_entradas, num_ocultas, num_etiquetas, XconUnos, y)

Theta1 = reshape(params_rn(1:num_ocultas * (num_entradas + 1)), num_ocultas, (num_entradas + 1));

Theta2 = reshape(params_rn((1 + (num_ocultas * (num_entradas + 1))):end), num_etiquetas, (num_ocultas + 1));

y = transformaEtiquetas(y, num_etiquetas)';

[a1, a2, z2, valoresRed] = red(Theta1, Theta2, XconUnos);

sumInterno = (0.-y) .* log(valoresRed) - (1.-y) .* log(1 .- valoresRed);
m = length(XconUnos(:,1));

Theta12 = Theta1(1:num_ocultas,2:end).^ 2;
Theta22 = Theta2(1:num_etiquetas,2:end) .^ 2;

J = (1 / m) * sum(sum(sumInterno));

endfunction
