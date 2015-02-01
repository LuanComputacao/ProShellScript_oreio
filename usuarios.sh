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
#
#
#

MENSAGEM_USO="
Uso: $(basename $0) [-h | -V]

-s, --sort          Ordena a listagem alfabeticamente
-h, --help          Mostra esta tela de ajuda e sai
-V, --version       Mostra a versão do programa e sai
-e                  Exporta o conteudo para um arquivo CSV
"
VERSAO="3"
ordenar=0
# Tratamento das opções de linha de comando

case "$1" in
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

    -s | --sort)
        ordenar=1
    ;;

    *)
        if test -n "$1"
        then
            echo "Oção invalida"
            exit 1
        fi
    ;;
#     echo "login,usuario" > usuarios.csv
#     cut -d : -f 1,5 /etc/passwd | tr -d , | tr : , >> usuarios.csv
esac

#Extrai a listagem
lista=$(cut -d : -f 1,5 /etc/passwd | tr -d , | tr : \\t)

#Ordena a listagem (se necessário)
if test "$ordenar" = 1
then
    lista=$(echo "$lista" | sort)
fi

echo "$lista"
