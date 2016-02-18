function [J, grad] = costeLogistica(theta, X, Y, lambda)
	warning("off", "Octave:broadcast");	
	m = length(X(:,1));
	valoresH = (theta' * X')';
	h = sigmoide(valoresH);
	# Sumandos
	a = (0.-Y) .* log(h) .- ((1 .- Y) .* log(1 .- h));
	# Theta cuadrado	
	t = theta .^ 2;

	J = (1/m) * sum(a) + ((lambda / m / 2) * sum(t));
	
	# Sumandos
	a = (h .- Y) .* X;
	# Poner a cero para no incluir el primero	
	theta(1) = 0;

	grad = ((1/m * sum(a)) .- ((lambda/m) .* theta)')';	

	warning("on", "Octave:broadcast");

endfunction
