function [J grad] = costeRN(params_rn, num_entradas, num_ocultas, num_etiquetas, XconUnos, y, lambda)

Theta1 = reshape(params_rn(1:num_ocultas * (num_entradas + 1)), num_ocultas, (num_entradas + 1));

Theta2 = reshape(params_rn((1 + (num_ocultas * (num_entradas + 1))):end), num_etiquetas, (num_ocultas + 1));

y = transformaEtiquetas(y, num_etiquetas)';

[a1, a2, z2, valoresRed] = red(Theta1, Theta2, XconUnos);

sumInterno = (0.-y) .* log(valoresRed) - (1.-y) .* log(1 .- valoresRed);
m = length(XconUnos(:,1));

Theta12 = Theta1(1:num_ocultas,2:end).^ 2;
Theta22 = Theta2(1:num_etiquetas,2:end) .^ 2;

regularizacion = (lambda / (2*m)) * ((sum(sum(Theta12)) + sum(sum(Theta22))));

J = (1 / m) * sum(sum(sumInterno)) + regularizacion;

# Gradiente
delta3 = valoresRed - y;
grad2 = delta3 * a2';

aux = (Theta2' * delta3);
aux = aux(2:end,:);
delta2 = aux .* derSigmoide(z2);
grad1 = delta2 * a1';

Theta1(:,1) = 0;
Theta2(:,1) = 0;

grad1 = grad1 .* (1/m) .+ (lambda/m) .* Theta1;
grad2 = grad2 .* (1/m) .+ (lambda/m) .* Theta2;

grad = [grad1(:); grad2(:)];

endfunction
