#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # Sem cor (reinicia a cor padrão)
BLUE='\033[0;34m'
CIANO='\033[0;36m'
PURPLE='\033[0;35m'

echo -e "${RED} _____                     _                _    _  _               _${NC}"
echo -e "${RED}|  __ \\                   (_)              | |  | || |             | |${NC}"
echo -e "${RED}| |__) |  __ _  _ __  ___  _  _ __    __ _ | |__| || |_  _ __ ___  | |${NC}"
echo -e "${RED}|  ___/  / _\` || '__|/ __|| || '_ \\  / _\` ||  __  || __|| '_ \` _ \\ | |${NC}"
echo -e "${RED}| |     | (_| || |   \\__ \\| || | | || (_| || |  | || |_ | | | | | || |${NC}"
echo -e "${RED}|_|      \\__,_||_|   |___/|_||_| |_| \\__, ||_|  |_| \\__||_| |_| |_||_|${NC}"
echo -e "${RED}                                      __/ |${NC}"
echo -e "${RED}                                     |___/${NC}"


if [ "$1" == "" ]; then
    echo -e "${YELLOW}#########################################################################${NC}"
    echo -e "${YELLOW}                     Modo de uso: $0 URL                               ${NC}"
    echo -e "${YELLOW}                     Exemplo: $0 www.site.exemplo.com                   ${NC}"
    echo -e "${YELLOW}#########################################################################${NC}"

else
    echo -e "${YELLOW}========================================================================${NC}"
    echo -e "${GREEN}		[+] Resolvendo URLs em:${NC} ${CIANO}$1${NC}"
    echo -e "${PURPLE}			Desenvolvido by: R4nyM0n3y ${NC}"
    echo -e "${YELLOW}========================================================================${NC}"

    wget -qO- "$1" | \
    grep -o 'href="[^"]*' | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" > lista_urls


    for url in $(cat lista_urls); do
        ip=$(host "$url" | grep "has address" | awk '{print $NF}')
        if [ -n "$ip" ]; then
            echo -e "Host ${BLUE}$url${NC} tem o IP: ${RED}$ip${NC}"
            echo "$ip" >> "resultado.$(echo "$1" | tr -d ':/').ip"
        fi
    done

    rm lista_urls
fi
