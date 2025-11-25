function [deslocamento_quadrado_medio, coeficiente_difusao] = run_iterativo (matriz, num_particulas, max_passos, passo_medicao)

  passo_atual = 0;
  xi = zeros(1, num_particulas);
  yi = zeros(1, num_particulas);
  vel = zeros(1, num_particulas);
  total_medicoes = floor(max_passos / passo_medicao);
  vel_media = zeros(1, total_medicoes);

  deslocamento_quadrado_medio = zeros(1, total_medicoes); % msd
  coeficiente_difusao = zeros(1, total_medicoes); % msd / 4max_passos

  for ii=1:num_particulas
    pos = gera_pos_i(matriz);
    xi(ii) = pos(1);
    yi(ii) = pos(2);
  endfor

  x = xi;
  y = yi;

  while passo_atual <= max_passos
    passo_atual += 1;

    for ii=1:num_particulas
      dir = randi([0, 1]);
      sentido = randi([0, 1]);
      if sentido == 0
        sentido = -1;
      endif
      if dir == 0 && x(ii) + sentido >= 1 && x(ii) + sentido <= size(matriz)(1)
        if matriz(x(ii) + sentido, y(ii)) == 0
          x(ii) += sentido;
        endif
      elseif dir == 1 && y(ii) + sentido >= 1 && y(ii) + sentido <= size(matriz)(1)
        if matriz(x(ii), y(ii) + sentido) == 0
          y(ii) += sentido;
        endif
      endif
      if mod(passo_atual, passo_medicao) == 0
        d = sqrt((xi(ii) - x(ii))^2 + (yi(ii) - y(ii))^2);
        vel(ii) = d/passo_atual;
      endif
    endfor

    if mod(passo_atual, passo_medicao) == 0
      vel_media(floor(passo_atual / passo_medicao)) = sum(vel)/num_particulas;

      deslocamento_quadrado = (x - xi).^2 + (y - yi).^2;
      deslocamento_quadrado_medio(floor(passo_atual / passo_medicao)) = sum(deslocamento_quadrado) / num_particulas;
      coeficiente_difusao(floor(passo_atual / passo_medicao)) = sum(deslocamento_quadrado) / num_particulas / (4 * passo_atual);

    endif

  endwhile

  % calcula coeficiente de difusão -> usa último desloc quad médio
  % coeficiente_difusao = deslocamento_quadrado_medio(end) / (4 * passo_atual);

