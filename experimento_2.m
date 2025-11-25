delimitador = ",";

num_particulas = 10000;
max_passos = 1000;
passo_medicao = 10;
total_medicoes = floor(max_passos / passo_medicao);


matrizes = {"matrix_1.txt"; "matrix_2.txt"; "matrix_3.txt"; "matrix_4.txt"; "matrix_5.txt"};
coeficientes = zeros(5, total_medicoes);

output_file_name = "resultados.csv";
file = fopen(output_file_name, 'a');

for ii=1:5
    nome_matriz = matrizes{ii};
    matriz = dlmread(nome_matriz, delimitador);

    tic
    [deslocamento_quadrado_medio_vet, coef_difusao_vet] = run_vetorizado(matriz, num_particulas, max_passos, passo_medicao);
    tempo_vet = toc
    coeficientes(ii, :) = coef_difusao_vet;

    fprintf(file, '%d,%d,%d,%d,%s,%d,%f,%f,%f,%s\n', ...
            num_particulas, max_passos, passo_medicao, total_medicoes, ...
            nome_matriz, size(matriz)(1), tempo_vet, coeficientes(ii, 1), coeficientes(ii, end), "vetorizado");
    
    tic
    [deslocamento_quadrado_medio_iter, coef_difusao_iter] = run_iterativo(matriz, num_particulas, max_passos, passo_medicao);
    tempo_iter = toc

    fprintf(file, '%d,%d,%d,%d,%s,%d,%f,%f,%f,%s\n', ...
            num_particulas, max_passos, passo_medicao, total_medicoes, ...
            nome_matriz, size(matriz)(1), tempo_iter, coef_difusao_iter(1), coef_difusao_iter(end), "iterativo");

    disp(ii);

endfor

plot(1:total_medicoes, coeficientes(1, :), "r", ...
     1:total_medicoes, coeficientes(2, :), "g", ...
     1:total_medicoes, coeficientes(3, :), "b", ...
     1:total_medicoes, coeficientes(4, :), "m", ...
     1:total_medicoes, coeficientes(5, :), "c")
legend(matrizes{:});
xlabel("tempo")
ylabel("Coeficiente difusão (D)")
title("Coeficientes difusão x tempo")

fclose(file);
