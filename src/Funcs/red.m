function [a1, a2, z2, h] = red(Theta1, Theta2, X)

a1 = X';

z2 = Theta1 * a1;
a2 = sigmoide(z2);

a2 = [ones(1, size(a2)(2)); a2];

z3 = Theta2 * a2;
h = sigmoide(z3);

endfunction
