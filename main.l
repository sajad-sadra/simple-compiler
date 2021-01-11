%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "main.tab.h"

%}

%%

[ \t]	; // ignore all whitespace

"bool"     {return K_BOOL};
"break"     {return K_BREAK};
"case"     {return K_CASE};
"char"     {return K_CHAR};
"const"     {return K_CONST};
"continue"     {return K_CONTINUE};
"default"     {return K_DEFAULT};
"double"     {return K_DOUBLE};
"else"     {return K_ELSE};
"false"     {return K_FALSE};
"function"     {return K_FUNCTION};
"float"     {return K_FLOAT};
"output"     {return K_OUTPUT};
"int"     {return K_INT};
"return"     {return K_RETURN};
"static"     {return K_STATIC};
"string"     {return K_STRING};
"switch"     {return K_SWITCH};
"true"     {return K_TRUE};
"type"     {return K_TYPE};
"for"     {return K_FOR};
"if"     {return K_IF};
"input"     {return K_INPUT};


[0-9]+\.[0-9]+ 	{yylval.fval = atof(yytext); return T_FLOAT;}
[0-9]+		{yylval.ival = atoi(yytext); return T_INT;}
\n		{return T_NEWLINE;}
"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
"exit"		{return T_QUIT;}
"quit"		{return T_QUIT;}

%%
