clear

num_linhas = 10;
num_colunas = 10;
num_particulas = 20;
matriz = gera_mapa(num_linhas);
max_passos = 20;

passo_atual = 0;
x = zeros(1, num_particulas);
y = zeros(1, num_particulas);
vel = zeros(1, num_particulas);

passo_medicao = 10;
total_medicoes = floor(max_passos / passo_medicao);
vel_media = zeros(1, total_medicoes);

for ii=1:num_particulas
  pos = gera_pos_i(matriz);
  x(ii) = pos(1);
  y(ii) = pos(2);
endfor


xvet = x;
yvet = y;
xiter = x;
yiter = y;

% vetorizado

tic
while passo_atual < max_passos
  passo_atual += 1;

  [xvet, yvet] = anda_1_passo(xvet, yvet, matriz, num_particulas, 1);

  a = printa_particulas(xvet, yvet, num_linhas);

  if mod(passo_atual, passo_medicao) == 0
    vel = sqrt((xvet - x).^2 + (yvet - y).^2) / passo_atual;
    vel_media(floor(passo_atual / passo_medicao)) = sum(vel)/num_particulas;
  endif

endwhile
toc

% plot(1:total_medicoes, vel_media) % isso funciona? Aqui não

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iterado

#{

passo_atual = 0;
vel_media = zeros(1, total_medicoes);

tic
while passo_atual < max_passos
  passo_atual += 1;

  for ii=1:num_particulas
    dir = randi([0, 1]);
    sentido = randi([0, 1]);
    if sentido == 0
      sentido = -1;
    endif
    if dir == 0 && matriz(xiter(ii) + sentido, yiter(ii)) == 0
      xiter(ii) += sentido;
    elseif dir == 1 && matriz(xiter(ii), yiter(ii) + sentido) == 0
      yiter(ii) += sentido;
    endif
    if mod(passo_atual, passo_medicao) == 0
      d = sqrt((xiter(ii) - x(ii))^2 + (yiter(ii) - y(ii))^2);
      vel(ii) = d/passo_atual;
    endif
  endfor

  if mod(passo_atual, passo_medicao) == 0
    vel_media(floor(passo_atual / passo_medicao)) = sum(vel)/num_particulas;
  endif

endwhile
toc

% plot(1:total_medicoes, vel_media)

#}




