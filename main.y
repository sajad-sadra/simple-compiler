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

%token K_BREAK K_CASE K_CHAR K_CONST K_CONTINUE K_DEFAULT K_DOUBLE K_ELSE  K_FUNCTION MOD K_BOOL SPACE DIV PMIN LOG_AND LOG_OR
%token  K_FLOAT K_OUTPUT K_INT K_RETURN K_STATIC K_STRING K_SWITCH  K_TYPE K_FOR K_IF COL SEMI OPEN_C CLOSE_C MIN LOG_T
%token K_INPUT NUM TRUE FALSE STRING VAR COMMENT PADD ADD MUL REL_NEQ REL_EQ REL_GEQ REL_LEQ REL_G REL_L LOG_BAND LOG_BOR OPEN_P CLOSE_P OPEN_B CLOSE_B COM EQU NEW

%%


program: func_def {printf("OK\new_variable_2");}
       | 
	   ;

func_def:  	func_def K_FUNCTION VAR COL inout block 
		|   K_FUNCTION VAR COL inout block 
		;

inout:  input_list output_list
	 |	input_list
	 |	output_list  
	 |
	 ;

input_list:		K_INPUT params;

output_list:	K_OUTPUT params;	

params:		type VAR COM params
		|	type VAR
		;

block:	OPEN_B CLOSE_B
     | 	OPEN_B	new_block CLOSE_B
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

type:	K_INT
	|	K_FLOAT
	|	K_BOOL
	|	K_CHAR
	|	K_DOUBLE
	|	VAR
	|	K_STRING
	| 	type OPEN_C CLOSE_C
	;

var_dcl_cnt: 	variable EQU expr
			|	variable 
            ;

statement:	assignment SEMI
		|	func_call SEMI
		|   cond_stmt  
		|	loop_stmt 
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

variable:	VAR num_const2
		|	VAR
		|	PADD variable
		|	variable PADD
		;

num_const2:	num_const2 OPEN_C num_const CLOSE_C
			|	OPEN_C num_const CLOSE_C
			| 
			;

func_call:	VAR OPEN_P parameters CLOSE_P
		|	VAR OPEN_P CLOSE_P
		;

parameters:	variable
		|	variable COM parameters
		;

cond_stmt:	K_IF OPEN_P expr CLOSE_P block K_ELSE block
		|	K_IF OPEN_P expr CLOSE_P block 
		|	K_SWITCH OPEN_P VAR CLOSE_P COL OPEN_B K_DEFAULT COL block CLOSE_B
		|	K_SWITCH OPEN_P VAR CLOSE_P COL OPEN_B cond_stmt_2 K_DEFAULT COL block CLOSE_B
		;

cond_stmt_2:	cond_stmt_2 K_CASE num_const COL block
			|	K_CASE num_const COL block
			;

loop_stmt: 	K_FOR OPEN_P var_dcl expr SEMI loop_stmt_2 CLOSE_P block
		|	K_FOR OPEN_P SEMI expr SEMI loop_stmt_2 CLOSE_P block
		|	K_FOR OPEN_P var_dcl expr SEMI CLOSE_P block
		|	K_FOR OPEN_P SEMI expr SEMI CLOSE_P block
		;

loop_stmt_2:	assignment
			|	expr
			;

expr:	expr binary_op expr 
	|	CLOSE_P expr CLOSE_P 
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
		|	DIV
		|	MOD
		|	log_op
		;
		
log_op:		LOG_BAND 
		|	LOG_BOR
		|	LOG_AND	
		|	LOG_OR
		;


conditional:	REL_NEQ
			|	REL_EQ
			|	REL_GEQ
			|	REL_LEQ
			|	REL_G
			|	REL_L
			;
			
const_val:	num_const
		|	bool_const
		|	string_const
		;

bool_const: TRUE
	| FALSE
	;

string_const: STRING ;

num_const: NUM ;

%%

int main() {
	yyparse();
	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Error\n");
	exit(1);
}
