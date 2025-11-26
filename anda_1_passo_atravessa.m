function [x, y, travessia_x, travessia_y] = anda_1_passo_atravessa (x, y, travessia_x, travessia_y, matriz, num_particulas, solido)
%function [x, y, z, travessia_x, travessia_y, travessia_z] = anda_1_passo_atravessa_3d (x, y, z, travessia_x, travessia_y, travessia_z, matriz, num_particulas, solido)

  tam_matriz = size(matriz, 1);

  passos = randi([0,2], 1, num_particulas); % gera de 0 a 2
  passo_x = zeros(1, num_particulas) + [passos==0]; % quem vai no eixo x
  passo_y = zeros(1, num_particulas) + [passos==1]; % quem vai andar no eixo y
  %passo_z = zeros(1, num_particulas) + [passos==2]; % quem vai andar no eixo z

  passo_negativo_x = logical(randi([0,1], 1, num_particulas)); % quem vai andar para
  passo_negativo_y = logical(randi([0,1], 1, num_particulas)); % o negativo do eixo
  %passo_negativo_z = logical(randi([0,1], 1, num_particulas));

  passo_x(passo_negativo_x) = passo_x(passo_negativo_x) * -1;
  passo_y(passo_negativo_y) = passo_y(passo_negativo_y) * -1;
  %passo_z(passo_negativo_z) = passo_z(passo_negativo_y) * -1;

  % se quiser economizar array, susbtitui anda_ por passo_ daqui em diante
  anda_x = x + passo_x % não se importa com intervalo
  anda_y = y + passo_y % pode ser de 0 a tam_matriz + 1
  %anda_z = z + passo_z % pode ser de 0 a tam_matriz + 1

  travessia_x = travessia_x + [anda_x == tam_matriz+1] - [anda_x == 0];
  travessia_y = travessia_y + [anda_y == tam_matriz+1] - [anda_y == 0];
  %travessia_z = travessia_z + [anda_z == tam_matriz+1] - [anda_z == 0];

  anda_x = mod(anda_x - 1, tam_matriz) + 1; % retorna os mesmos valores mas 0 vira
  anda_y = mod(anda_y - 1, tam_matriz) + 1; % tam_matriz e tam_matriz + 1 vira 1
  %anda_z = mod(anda_z - 1, tam_matriz) + 1; % [1, tam_matriz]

  indices = sub2ind(size(matriz), anda_x, anda_y, anda_z); % não é mais plano cartesiano
  estado_matriz = matriz(indices);
  mov_valido = (estado_matriz != solido);

  x(mov_valido) = anda_x(mov_valido);
  y(mov_valido) = anda_y(mov_valido);
  %z(mov_valido) = anda_z(mov_valido);

