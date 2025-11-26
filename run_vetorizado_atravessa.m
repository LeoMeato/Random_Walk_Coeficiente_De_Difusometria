function [deslocamento_quadrado_medio, coeficiente_difusao] = run_vetorizado_atravessa (matriz, num_particulas, max_passos, passo_medicao, solido)
%function [deslocamento_quadrado_medio, coeficiente_difusao] = run_vetorizado_atravessa_3d (matriz, num_particulas, max_passos, passo_medicao, solido)

  dimensao = 2
  %dimensao = 3
  passo_atual = 0;
  xi = zeros(1, num_particulas);
  yi = zeros(1, num_particulas);
  %zi = zeros(1, num_particulas);
  travessia_x = zeros(1, num_particulas);
  travessia_y = zeros(1, num_particulas);
  %travessia_z = zeros(1, num_particulas);
  vel = zeros(1, num_particulas);
  total_medicoes = floor(max_passos / passo_medicao);
  vel_media = zeros(1, total_medicoes);

  deslocamento_quadrado_medio = zeros(1, total_medicoes); % msd
  coeficiente_difusao = zeros(1, total_medicoes); % msd / 4max_passos

  for ii=1:num_particulas
    pos = gera_pos_i(matriz);
    %pos = gera_pos_i_3d(matriz, num_particulas, solido);
    xi(ii) = pos(1);
    yi(ii) = pos(2);
    %zi(ii) = pos(2);
  endfor

  x = xi;
  y = yi;
  %z = zi;

  while passo_atual <= max_passos
    passo_atual += 1;

    [x, y, travessia_x, travessia_y] = anda_1_passo_atravessa(x, y, travessia_x, travessia_y, matriz, num_particulas, solido);
    %[x, y, z, travessia_x, travessia_y, travessia_z] = anda_1_passo_atravessa(x, y, travessia_x, travessia_y, travessia_z, matriz, num_particulas, solido);

    if mod(passo_atual, passo_medicao) == 0

      x_real = x + travessia_x * size(matriz, 1);
      y_real = y + travessia_y * size(matriz, 1);
      %z_real = z + travessia_z * size(matriz, 1);

      vel = sqrt((x_real - xi).^2 + (y_real - yi).^2) / passo_atual;
      vel_media(floor(passo_atual / passo_medicao)) = sum(vel)/num_particulas;

      deslocamento_quadrado = (x_real - xi).^2 + (y_real - yi).^2;
      %deslocamento_quadrado = (x_real - xi).^2 + (y_real - yi).^2 + (z_real - zi).^2;
      deslocamento_quadrado_medio(floor(passo_atual / passo_medicao)) = sum(deslocamento_quadrado) / num_particulas;
      coeficiente_difusao(floor(passo_atual / passo_medicao)) = (sum(deslocamento_quadrado) / num_particulas) / ((2 * dimensao * passo_atual));

    endif

  endwhile

