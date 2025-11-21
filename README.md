# como criar arquivos de matrizes

ir para a pasta "build_matrix"
    
    cd build_matrix

## Baixando dependências

usando o pip

    pip install -r requirements.txt

usando o uv

    uv sync


## Rodando o programa

usando o python

    python matrix_creator/main.py

usando o uv

    uv run matrix_creator/main.py


# como usar o criador de matrizes

OBS:
* quadrados pretos = ocupados = 1
* quadrados brancos = vazias = 0

Controles:

* botão esquerdo do mouse (apertar e segurar): torna quadrados dentro do círculo vermelho em quadrados pretos

* botão direito do mouse (apertar e segurar): torna quadrados dentro do círculo vermelho em quadrados brancos

* botão i: torna toda matrix branca ou preta

* botão e: salva matrix para arquivo (como nome "matrix_{timestamp}.txt")