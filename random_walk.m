% para pegar nome de arquivo de args: nome_arquivo_matriz = sprintf("%s", argv(){1});
nome_arquivo_matriz = "matrix_1.txt"
delimitador = ","
M = dlmread(nome_arquivo_matriz, delimitador)
n_matriz = size(M)(1)

% n_matriz = 1000;
% M = gera_mapa(n_matriz);

n_particulas = 100;
X = zeros(1, n_particulas);
Y = zeros(1, n_particulas);
V = zeros(1, n_particulas);

dimensao = 2
k = dimensao ^ 2

numpassos = 0;
limite = 1000;
passo_medicao = 10;
total_medicoes = floor(limite / passo_medicao);
Vel_media = zeros(1, total_medicoes);

for ii=1:n_particulas
  pos = gera_pos_i(M);
  X(ii) = pos(1);
  Y(ii) = pos(2);
endfor

Xi = X;
Yi = Y;

while numpassos < limite
  numpassos += 1;

  for ii=1:n_particulas

    dir = randi([0, 1]);
    sentido = randi([0, 1]);
    if sentido == 0
      sentido = -1;
    endif
    if dir == 0 && M(X(ii) + sentido, Y(ii)) == 0
      X(ii) += sentido;
    elseif dir == 1 && M(X(ii), Y(ii) + sentido) == 0
      Y(ii) += sentido;
    endif

    if mod(numpassos, passo_medicao) == 0
      V(ii) = (X(ii) - Xi(ii))^2 + (Y(ii) - Yi(ii))^2;
    endif

  endfor

  if mod(numpassos, passo_medicao) == 0
    Vel_media(floor(numpassos / passo_medicao)) = (sum(V)/n_particulas) / (numpassos * k);
  endif


endwhile

plot(1:total_medicoes, Vel_media)
