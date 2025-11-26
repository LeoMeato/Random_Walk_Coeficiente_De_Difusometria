function [deslocamento_quadrado_medio, coeficiente_difusao] = run_vetorizado (matriz, num_particulas, max_passos, passo_medicao)

  passo_atual = 0;
  xi = zeros(1, num_particulas);
  yi = zeros(1, num_particulas);
  vel = zeros(1, num_particulas);
  total_medicoes = floor(max_passos / passo_medicao);
  vel_media = zeros(1, total_medicoes);

  deslocamento_quadrado_medio = zeros(1, total_medicoes); % msd
  coeficiente_difusao = zeros(1, total_medicoes); % msd / 4max_passos

  % pré-computa as posições livres para evitar sorteios repetidos em matrizes densas
  [livre_y, livre_x] = find(matriz == 0);
  livre_x = livre_x';
  livre_y = livre_y';
  if isempty(livre_x)
    error('A matriz não possui células livres (valor 0) para iniciar as partículas.');
  endif
  indices_livres = randi(numel(livre_x), 1, num_particulas);
  xi = livre_x(indices_livres);
  yi = livre_y(indices_livres);

  x = xi;
  y = yi;

  while passo_atual <= max_passos
    passo_atual += 1;

    [x, y] = anda_1_passo(x, y, matriz, num_particulas, 1);

    if mod(passo_atual, passo_medicao) == 0
      vel = sqrt((x - xi).^2 + (y - yi).^2) / passo_atual;
      vel_media(floor(passo_atual / passo_medicao)) = sum(vel)/num_particulas;

      deslocamento_quadrado = (x - xi).^2 + (y - yi).^2;
      deslocamento_quadrado_medio(floor(passo_atual / passo_medicao)) = sum(deslocamento_quadrado) / num_particulas;
      coeficiente_difusao(floor(passo_atual / passo_medicao)) = (sum(deslocamento_quadrado) / num_particulas) / ((4 * passo_atual));
    endif

  endwhile

  % calcula coeficiente de difusão -> usa último desloc quad médio
  % coeficiente_difusao = deslocamento_quadrado_medio(end) / (4 * passo_atual);



