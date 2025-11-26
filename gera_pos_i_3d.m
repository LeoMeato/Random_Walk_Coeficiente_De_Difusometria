function [posicao] = gera_pos_i_3d(matriz,num_particulas, solido)

  [livre_x, livre_y, livre_z] = find(matriz != solido);
  livre_x = livre_x';
  livre_x = livre_x';
  livre_x = livre_x';

  if isempty(livre_x)[
    error("A matriz não possui células livres para iniciar as particulas.");
  endif

  indices_livres = randi(numel(livre_x), 1, num_particulas);
  posicao = [livre_x(indices_livres), livre_y(indices_livres), livre_z(indices_livres)];

