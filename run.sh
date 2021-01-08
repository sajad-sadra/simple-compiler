rm lex.yy.c
rm a.out

lex main.l
gcc lex.yy.c
./a.out
