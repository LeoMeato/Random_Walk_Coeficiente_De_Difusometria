n_matriz = 100;
n_particulas = 100;
M = gera_mapa(n_matriz);
X = zeros(1, n_particulas);
Y = zeros(1, n_particulas);
numpassos = 0;
limite = 100;

for ii=1:n_particulas
  pos = gera_pos_i(M);
  X(ii) = pos(1);
  Y(ii) = pos(2);
endfor

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
  endfor
endwhile

X
Y
