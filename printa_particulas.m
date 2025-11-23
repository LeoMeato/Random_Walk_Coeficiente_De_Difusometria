function [a] = printa_particulas (x, y)

matriz = zeros(length(y));
for ii = 1:length(y)
  matriz(y(ii), x(ii)) = matriz(y(ii), x(ii)) + 1;

endfor

matriz

a = 1;
