#!/bin/bash
# usuarios.sh
#
# Mostra os logins e nomes de usuários do sistema
# Obs: Lê dados do arquivo /etc/passwd
#
#
# Versão 1: Mostra usuários e nomes separados por TAB
# Versão 2: Adiciona suporte à opção -h
# Versão 3: Adiciona suporte à opção -V e opções inválidas
# Versão 4: Arrumando bug quando não tem opções, basename
#           no nome do programa, -V extraindo direto dos cabeçalhos,
#           adicionadas opções --help e --version
# Versão 5: Adiciona a opção -s e --sort
# Versão 6: Adicionando as opções -r, --reverse, -u, --uppercase,
#           leitura de múltiplas opções loop
#
#

MENSAGEM_USO="
Uso: $(basename $0) [-h | -V]

-r, --reverse       Inverte a listagem
-u, --uppercase     Mostra a listagem em MAIÚSCULAS
-s, --sort          Ordena a listagem alfabeticamente
-h, --help          Mostra esta tela de ajuda e sai
-V, --version       Mostra a versão do programa e sai
-e                  Exporta o conteudo para um arquivo CSV
"
# chaves
ordenar=0
inverte=0
miusculas=0

# Tratamento das opções de linha de comando
while test -n "$1"
do
    case "$1" in
        -r | --reverse)
            inverte=1
        ;;

        -u | --uppercase)
            maiusculas=1
        ;;
        -s | --sort)
            ordenar=1
        ;;

        -h | --help)
            echo "$MENSAGEM_USO"
            exit 0
        ;;

        -V | --version)
            echo -n $(basename $0)
            # Extrai a versão diretamente dos cabeçalhos do programa
            grep '^# Versão ' usuarios.sh | tail -1 | cut -d : -f 1 | tr -d '# '
            exit 0
        ;;

        *)
            if test -n "$1"
            then
                echo "Oção invalida"
                exit 1
            fi
        ;;
        # echo "login,usuario" > usuarios.csv
        # cut -d : -f 1,5 /etc/passwd | tr -d , | tr : , >> usuarios.csv
    esac

    # Opção $1 já processada, a fila deve andar
    shift

done



#Extrai a listagem
lista=$(cut -d : -f 1,5 /etc/passwd | tr -d , | tr : \\t)

#Ordena a listagem (se necessário)
if test "$ordenar" = 1
then
    lista=$(echo "$lista" | sort)
fi

# Inverte a listagem (se necessário)
if test "$inverte" = 1
then
    lista=$(echo "$lista" | tac)
fi

# Converte minúsculas para maiúsculas
if test "$maiusculas" = 1
then
    lista=$(echo "$lista" | tr a-z A-Z)
fi

echo "$lista"
