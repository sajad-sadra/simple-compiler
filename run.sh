rm zpp > /dev/null 2>&1
rm main.tab.c > /dev/null 2>&1
rm main.tab.h > /dev/null 2>&1
rm lex.yy.c > /dev/null 2>&1


bison -d main.y
flex main.l
gcc main.tab.c lex.yy.c -o zpp
./zpp
