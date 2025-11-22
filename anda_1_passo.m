function [x, y] = anda_1_passo(x_atual, y_atual, matriz, num_particulas, solido)

  passo_x = randi([0,1], 1, num_particulas); % quem vai andar horizontalmente
  passo_y = ones(1, num_particulas) - passo_x; % quem vai andar verticalmente

  passo_negativo_x = logical(randi([0,1], 1, num_particulas)); % quem vai andar para trás
  passo_negativo_y = logical(randi([0,1], 1, num_particulas)); % quem vai andar para cima

  passo_x(passo_negativo_x) = passo_x(passo_negativo_x) * -1;
  passo_y(passo_negativo_y) = passo_y(passo_negativo_y) * -1;

  anda_x = max(1, min(size(matriz, 1), x_atual + passo_x)); % garante que indices estão dentro do intervalo
  anda_y = max(1, min(size(matriz, 1), y_atual + passo_y));

  indices = sub2ind(size(matriz), anda_y, anda_x); % y navega linhas, x navega colunas
  estado_matriz = matriz(indices);
  mov_valido = (estado_matriz != solido);
  x = x_atual;
    y = y_atual;
  x(mov_valido) = anda_x(mov_valido);
  y(mov_valido) = anda_y(mov_valido);



