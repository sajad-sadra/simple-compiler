%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "main.tab.h"

%}

%%

"break"     {return K_BREAK;}
"case"     {return K_CASE;}
"char"     {return K_CHAR;}
"const"     {return K_CONST;}
"continue"     {return K_CONTINUE;}
"default"     {return K_DEFAULT;}
"double"     {return K_DOUBLE;}
"else"     {return K_ELSE;}
"function"     {return K_FUNCTION;}
"float"     {return K_FLOAT;}
"output"     {return K_OUTPUT;}
"int"     {return K_INT;}
"return"     {return K_RETURN;}
"static"     {return K_STATIC;}
"string"     {return K_STRING;}
"bool"      {return K_BOOL;}
"switch"     {return K_SWITCH;}
"type"     {return K_TYPE;}
"for"     {return K_FOR;}
"if"     {return K_IF;}
"input"     {return K_INPUT;}


[0-9]+(\.[0-9]+)?(E(\+|-)?[0-9]+)? 	{return NUM;}
"true"  {return TRUE;}
"false"  {return FALSE;}
["]([^"]|\\(.|\n))*["]    {return STRING;}
[a-zA-Z]([a-zA-Z]|[0-9]|_)*     {return VAR;}
\n
\#\#.* 
\/\#((.|\n)*)\#\/  


"++" {return PADD;}
"+"	{return ADD;}
"--" {return PMIN;}
"-"	{return MIN;}
"*"	{return MUL;}
"/"	{return DIV;}
"<>" {return REL_NEQ;}
"==" {return REL_EQ;}
">=" {return REL_GEQ;}
"<=" {return REL_LEQ;}
">"	{return REL_G;}
"<"	{return REL_L;}
"&&" {return LOG_AND;}
"||" {return LOG_OR;}
"%"	{return MOD;}
"&"	{return LOG_BAND;}
"|"	{return LOG_BOR;}
"!"	{return LOG_T;}
"("	{return OPEN_P;}
")"	{return CLOSE_P;}
"{"	{return OPEN_B;}
"}"	{return CLOSE_B;}
"[" {return OPEN_C;}
"]" {return CLOSE_C;}
";"	{return SEMI;}
":" {return COL;}
","	{return COM;}
"="	{return EQU;}
\t	
[ ]	

%%
