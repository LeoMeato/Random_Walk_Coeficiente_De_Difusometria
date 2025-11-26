delimitador = ",";

num_particulas = 10000;
max_passos = 10000;
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
    
    % run_iterativo desativado para focar nos testes vetorizados
    disp(ii);

endfor

medicoes = (1:total_medicoes) * passo_medicao; % eixo x em número de passos simulados
cores = {"r", "g", "b", "y", "c"};
marcadores = {"o", "s", "^", "d", "+"};

figure;
hold on;
h_lines = zeros(1, numel(matrizes));
for jj = 1:numel(matrizes)
    h_lines(jj) = plot(medicoes, coeficientes(jj, :), cores{jj}, "LineWidth", 1.5);
    marker_idx = 1:max(1, floor(numel(medicoes)/15)):numel(medicoes);
    marker_fmt = strcat(cores{jj}, marcadores{jj});
    plot(medicoes(marker_idx), coeficientes(jj, marker_idx), marker_fmt, ...
             "MarkerSize", 4, "LineStyle", "none", "HandleVisibility", "off");
endfor
hold off;
h_leg = legend(h_lines, matrizes{:}, "Location", "northoutside", "Orientation", "horizontal");
set(h_leg, "FontSize", 12, "Box", "off");
xlabel("Passos simulados");
ylabel("Coeficiente de difusão (D)");
title("Evolução do coeficiente de difusão por matriz");
grid on;

fclose(file);
