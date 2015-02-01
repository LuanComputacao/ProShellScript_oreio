#!/bin/bash
# usuarios.sh
#
# Mostra os logins e nomes de usuários do sistema
# Obs: Lê dados do arquivo /etc/passwd
#

MENSAGEM_USO="
Uso $0 [-h]


-h              Mostra esta tela de ajuda e sai
-V              Mostra a versão do programa e sai
-e              Exporta o conteudo para um arquivo CSV
"
VERSAO="3"
# Tratamento das opções de linha de comando

case "$1" in
-h)
    echo "$MENSAGEM_USO"
    exit 0
;;
-V)
    echo $0 Versão $VERSAO
    exit 0
;;
*)
    echo "Oção invalida"
    exit 1

#     echo "login,usuario" > usuarios.csv
#     cut -d : -f 1,5 /etc/passwd | tr -d , | tr : , >> usuarios.csv
esac
cut -d : -f 1,5 /etc/passwd | tr -d , | tr : \\t