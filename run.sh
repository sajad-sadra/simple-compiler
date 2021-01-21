rm $(cat .gitignore) > /dev/null 2>&1

bison -d main.y
flex main.l
gcc main.tab.c lex.yy.c -o zpp
clear
./zpp < input.zpp
