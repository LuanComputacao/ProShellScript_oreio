#!/bin/bash
# usuarios.sh
#
# Mostra os logins e nomes de usuários do sistema
# Obs: Lê dados do arquivo /etc/passwd
#
# Aurelio, Novembro de 2007
#
# Versão 1: Mostra usuários e nomes separados por TAB
# Versão 2: Adicionado suporte à opção -h
#
#
#

MENSAGEM_USO="
Uso $0 [-h]


-h              Mostra esta tela de ajuda e sai
-e              Exporta o conteudo para um arquivo CSV
"
# Tratamento das opções de linha de comando

if test "$1" = "-h"
then
    echo "$MENSAGEM_USO"
    exit 0
elif test "$1" = "-V"

fi
# if test "$1" = "-e"
#     echo "login,usuario" > usuarios.csv
#     cut -d : -f 1,5 /etc/passwd | tr -d , | tr : , >> usuarios.csv
# fi

cut -d : -f 1,5 /etc/passwd | tr -d , | tr : \\t