#!/bin/bash
# getopts-teste-sh
#
# Loop que processa todas as opções da linha de comando.
# Atenção ao formato das opções válidas ":s:"
# - Os dois-pontos do início ligam o modo silencioso
# - As opções válidas são 'sa:', que são -s e -a
# - Os dois-pontos de 'a:' representam um argumento: -a FOO
#
#

while getopts ":sa:z" opcao
do
    # $opcao guarda a opção da vez(ou ? e : em caso de erro)
    # $OPTARG guarda o argumento da opção (se houver)
    case $opcao in
        s) echo "OK opção simples (-s)";;
        z) echo "OK opção simples (-z)";;
        a) echo "OK Opção com argumento (-a), recebeu: $OPTARG";;
        \?) echo "ERRO Opção inválida: $OPTARG" ;;
        :) echo "ERRO Faltou argumento para: $OPTARG";;
    esac
done

# O loop termina quando nenhuma opão for encontrada.
# Mas ainda podem existir argumentos, como um nome de arquivo
# A variável $OPTIND guarda o índice do resto da linha de
# comando, útil para arrancar opções já processadas.
#

echo
shift $((OPTIND -1))
echo "INDICE: $OPTIND"
echo "RESTO: $*"
echo