function[A] = gera_mapa(n)

A = ones(n); % Matriz inicial preenchida com 1

% Centro do círculo
cx = ceil(n / 2);
cy = ceil(n / 2);

% Raio do círculo
r = n / 3; % Pode ajustar o tamanho do círculo aqui

% Criando grade de coordenadas
[x, y] = meshgrid(1:n, 1:n);

% Criando a máscara circular
mask = (x - cx).^2 + (y - cy).^2 <= r^2;

% Aplicando a máscara à matriz
A(mask) = 0;
