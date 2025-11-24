clear

% CSV

output_file_name = 'resultado_experimento.csv';
FID = fopen(output_file_name, 'w');
fprintf(FID, 'run,tam_matriz,num_particulas,max_passos,passo_medicao,tipo_execucao,tempo_total,coef_difusao\n');

% Parâmetros

exp_matriz = [10^2, 10^3];
exp_particulas = [10^2, 10^3, 10^4, 10^5];
exp_max_passos = [10^3, 10^4, 10^5];
exp_passo_medicao = [10^2, 10^3];
% exp_mapa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Vetorizado

num_runs = 3;
max_razao_passos = 10^3; % máximo de medições por run -> max_passos / passo_medicao
max_particulas_passos = 10^9; % máximo de particulas * max_passos -> 1 Bi
cont = 0;

# {
tipo_execucao = 'vet'

for run = 1:num_runs
  for tam_matriz = exp_matriz
    matriz = gera_mapa(tam_matriz);

    for num_particulas = exp_particulas

      for max_passos = exp_max_passos

        if num_particulas * max_passos <= max_particulas_passos

          for passo_medicao = exp_passo_medicao
            if max_passos > passo_medicao && max_passos / passo_medicao <= max_razao_passos

              cont += 1

              tic
              [deslocamento_quadrado_medio, coef_difusao] = run_vetorizado(matriz, num_particulas, max_passos, passo_medicao);
              tempo_total = toc

              fprintf(FID, '%d, %d, %.0e, %.0e, %d, %s, %f, %f\n', ...
                      run, tam_matriz, num_particulas, max_passos, passo_medicao, ...
                      tipo_execucao, tempo_total, coef_difusao);

            endif

          endfor

        endif

      endfor

    endfor

  endfor

endfor



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Iterativo

num_runs = 1;
max_razao_passos = 10^2; % máximo de medições por run -> max_passos / passo_medicao
max_particulas_passos = 10^4; % máximo de particulas * max_passos -> 1 Bi

tipo_execucao = 'iter'

for run = 1:num_runs
  for tam_matriz = exp_matriz
    matriz = gera_mapa(tam_matriz);

    for num_particulas = exp_particulas

      for max_passos = exp_max_passos

        if num_particulas * max_passos <= max_particulas_passos

          for passo_medicao = exp_passo_medicao
            if max_passos > passo_medicao && max_passos / passo_medicao <= max_razao_passos

              cont += 1

              tic
              [deslocamento_quadrado_medio, coef_difusao] = run_iterativo(matriz, num_particulas, max_passos, passo_medicao);
              tempo_total = toc

              fprintf(FID, '%d, %d, %.0e, %.0e, %d, %s, %f, %f\n', ...
                      run, tam_matriz, num_particulas, max_passos, passo_medicao, ...
                      tipo_execucao, tempo_total, coef_difusao);

            endif

          endfor

        endif

      endfor

    endfor

  endfor

endfor



fclose(FID);
printf("\nExperimento concluído. Total de %d execuções. Resultados salvos em %s\n", cont, output_file_name);

