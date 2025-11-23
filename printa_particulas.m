function [a] = printa_particulas (x, y, tam_matriz)
% favor usar somente em matrizes quadradas

matriz = zeros(tam_matriz);

for ii = 1:length(y)
  matriz(y(ii), x(ii)) = matriz(y(ii), x(ii)) + 1;

endfor

matriz

a = 1;
