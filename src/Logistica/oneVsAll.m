function [all_theta] = oneVsAll(X, y, num_etiquetas, lambda, iters, usingFminunc)
	options = optimset("GradObj", "on", "MaxIter", iters);

	initial_theta = zeros(length(X(1,:)), 1);
if usingFminunc
	for c = 1:num_etiquetas
		all_theta(:,c) = fminunc(@(t)(costeLogistica(t, X, (y == c), lambda)), initial_theta, options);
	endfor
else
	for c = 1:num_etiquetas
		all_theta(:,c) = fmincg(@(t)(costeLogistica(t, X, (y == c), lambda)), initial_theta, options);
	endfor
endif

endfunction
