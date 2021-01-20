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

%token K_BREAK K_CASE K_CHAR K_CONST K_CONTINUE K_DEFAULT K_DOUBLE K_ELSE  K_FUNCTION MOD
%token  K_FLOAT K_OUTPUT K_INT K_RETURN K_STATIC K_STRING K_SWITCH  K_TYPE K_FOR K_IF COL SEMI OPEN_C CLOSE_C MIN LOG_T
%token K_INPUT NUM TRUE FALSE STRING VAR NEWLINE COMMENT PADD ADD MUL REL LOG OPEN_P CLOSE_P OPEN_B CLOSE_B COM EQU NEW

%%


program: func_def
       | /*epsilon*/
	   ;

func_def: 	func_def K_FUNCTION VAR COL inout block
		|    K_FUNCTION VAR COL inout block
		;

inout:	input_list output_list
	 |	input_list
	 |	output_list
	 |  /*epsilon*/
	 ;

input_list:		K_INPUT params;

output_list:	K_OUTPUT params;	

params:		type VAR COM params
		|	type VAR
		;

block:	OPEN_B new_block CLOSE_B
     | 	OPEN_B	CLOSE_B
	 ;
      
new_block: new_block var_dcl
         | new_block statement
         | statement
         | var_dcl
         ;

var_dcl: 	K_CONST type var_dcl_cnt new_var_dcl_cnt SEMI
    	|	type var_dcl_cnt new_var_dcl_cnt SEMI
		|	K_CONST type var_dcl_cnt SEMI
		|	type var_dcl_cnt SEMI	
        ;

new_var_dcl_cnt: new_var_dcl_cnt COM var_dcl_cnt
                | COM var_dcl_cnt
  	            ;

var_dcl_cnt: 	variable EQU expr
			|	variable 
            ;

statement:	assignment SEMI
		|	func_call SEMI
		|	cond_stmt SEMI
		|	loop_stmt SEMI
		|	K_RETURN SEMI
		|	expr SEMI
		|	SEMI
		|	K_BREAK SEMI
		|	K_CONTINUE SEMI
		;

assignment:	variable EQU expr
		 |	new_variable EQU func_call
		 ;

new_variable:	variable new_variable_2
			|	variable
			;

new_variable_2:	new_variable_2 COM variable
			|	COM variable
			;

variable:	VAR num_const_2
		|	VAR
		|	PADD variable
		|	variable PADD
		;

num_const_2:	num_const_2 OPEN_C num_const CLOSE_C
			|	OPEN_C num_const CLOSE_C
			| /*epsilon*/
			;

func_call:	VAR OPEN_P parameters CLOSE_P
		|	VAR OPEN_P CLOSE_P
		;

parameters:	variable
		|	variable COM parameters
		;

cond_stmt:	K_IF OPEN_P expr CLOSE_P block K_ELSE block
		|	K_IF OPEN_P expr CLOSE_P
		|	K_SWITCH OPEN_P VAR CLOSE_P COL OPEN_B cond_stmt_2 K_DEFAULT COL block CLOSE_B
		|	K_SWITCH OPEN_P VAR CLOSE_P COL OPEN_B K_DEFAULT COL block CLOSE_B
		;

cond_stmt_2:	cond_stmt_2 K_CASE num_const COL block
			|	K_CASE num_const COL block
			;

loop_stmt: 	K_FOR OPEN_B var_dcl SEMI expr SEMI loop_stmt_2 CLOSE_B block
		|	K_FOR OPEN_B SEMI expr SEMI loop_stmt_2 CLOSE_B block
		|	K_FOR OPEN_B var_dcl SEMI expr SEMI CLOSE_B block
		|	K_FOR OPEN_B SEMI expr SEMI CLOSE_B block
		;

loop_stmt_2:	assignment
			|	expr
			;

expr:	expr binary_op expr
	|	OPEN_B expr CLOSE_B
	|	func_call
	|	variable
	|	const_val
	|	MIN expr
	|	LOG_T expr
	;

binary_op:	arithmatic
		|	conditional
		;

arithmatic:	ADD
		|	MIN
		|	MUL
		|	MOD
		|	LOG
		;

conditional:	REL;

const_val:	num_const
		|	bool_const
		|	string_const
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
