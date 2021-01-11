rm zpp > /dev/null
rm main.tab.c > /dev/null
rm main.tab.h > /dev/null
rm lex.yy.c > /dev/null


bison -d main.y
flex main.l
gcc main.tab.c lex.yy.c -o zpp
./zpp
