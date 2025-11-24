
# programa para consertar arquivos de matrix, se precisar
# pega um arquivo de matriz sem virgula e bota virgula entre celulas
# precisa estar nesse formato para a funcao dlmread do octave
nome_arquivo = "matriz_1.txt"
new_matrix = []
with open(nome_arquivo, "r") as f:
    lines = f.readlines()

    for line in lines:
        line = line.strip()
        chars = list(line)           
        line_str = ",".join(chars)   
        line_str += "\n"             
        new_matrix.append(line_str)

with open(nome_arquivo, "w") as f:
    f.writelines(new_matrix)