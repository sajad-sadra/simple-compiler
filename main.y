%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
}

%token K_BREAK K_CASE K_CHAR K_CONST K_CONTINUE K_DEFAULT K_DOUBLE K_ELSE  K_FUNCTION K_FLOAT K_OUTPUT K_INT K_RETURN K_STATIC K_STRING K_SWITCH  K_TYPE K_FOR K_IF K_INPUT NUM TRUE FALSE STRING VAR NEWLINE COMMENT PADD ADD MUL REL LOG OPEN_P CLOSE_P OPEN_B CLOSE_B COM EQU NEW

%%


program: NEW
       | kk NEW { printf("\tResult: %f\n", $1);}


;

%%

int main() {
	yyin = stdin;
	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
