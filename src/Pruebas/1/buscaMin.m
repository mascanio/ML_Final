#load dataSaveTotal;

tam = size(data);

clear c;
for i=1:tam(1)
	clear b;	
	for j=1:tam(2)
		clear a;
		for k=1:tam(3)
			a(k) = data(i,j,k).errVal;
		endfor
		minPos = find(min(a)==a);
		b(j) = data(i,j,minPos);
	endfor
	for l=1:tam(2)
		c(l) = b(l).errVal;
	endfor
	minPos = find(min(c)==c);
	array(i) = b(minPos);
endfor
clear a;
for i = 1:size(array)(1)
	a(i) = array(i).errVal;
endfor

pos = find(min(a) == a);

printf("El valor óptimo se encuentra para:\n\tnum_ocultas = %d\n\t \
iteraciones = %d\n\tlambda = %.4f\n \
Con errores\n\terrTrain = %.4f\n\terrVal = %.4f\n \
Con porcentajes\n\t%%Aciertotrain = %.4f\n\t%%Aciertoval = %.4f\n", ...
 array(pos).num_ocultas, array(pos).iter, array(pos).lambda, array(pos).errTrain, array(pos).errVal, array(pos).porcentajeEntren, array(pos).porcentajeTest);
