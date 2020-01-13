%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YYDEBUG 1
%}

%token NO

%token ID
%token CST
%token INT
%token CHAR
%token BOOL
%token ARRAY
%token FLOAT
%token STRUCT
%token IF
%token ELSE
%token FOR
%token WHILE
%token BEG
%token END
%token RE
%token WR
%token STRING
%token EPSILON

%token SQUARE_LEFT_B
%token SQUARE_RIGHT_B
%token CURLY_LEFT_B
%token CURLY_RIGHT_B
%token ROUND_LEFT_B
%token ROUND_RIGHT_B
%token TWO_DOTS
%token SEMI_COLON
%token SPACE
%token COMA
%token DOT

%left PLUS MINUS
%left MULTIPLY DIVIDE
%left AND OR

%token LESS_THAN
%token GREATER_THAN
%token LESS_THAN_OR_EQ
%token EQ
%token GREATER_THAN_OR_EQ
%token DOUBLE_EQ
%token MODULO
%token NOT
%token NOT_EQ
%token POW

%start program

%%

program:	BEG END
		| BEG decllist cmpdstmt END
		;
decllist:	/* empty */
		| decllist decl SEMI_COLON
		| decl SEMI_COLON 
		;

decl:		type ID EQ expression 
		| type ID
		;
type:		INT 
		| BOOL 
		| FLOAT 
		| CHAR 
		| STRING 
		;
cmpdstmt:	/* empty */
		| cmpdstmt stmt SEMI_COLON
		| stmt SEMI_COLON
		;
stmt:		assignstmt
		| iostmt
		| ifstmt
		| whilestmt
		| forstmt
		;
assignstmt:	ID EQ expression
		;
iostmt:		RE ROUND_LEFT_B expression ROUND_RIGHT_B 
		| WR ROUND_LEFT_B expression ROUND_RIGHT_B
		;
else_stmt:	/* empty */
		| ELSE CURLY_LEFT_B cmpdstmt CURLY_RIGHT_B
		;
ifstmt:		IF ROUND_LEFT_B condition ROUND_RIGHT_B CURLY_LEFT_B cmpdstmt CURLY_RIGHT_B  else_stmt 
		;
whilestmt:	WHILE ROUND_LEFT_B condition ROUND_RIGHT_B CURLY_LEFT_B cmpdstmt CURLY_RIGHT_B 
		;
forstmt:	FOR ROUND_LEFT_B assignstmt SEMI_COLON condition SEMI_COLON assignstmt ROUND_RIGHT_B CURLY_LEFT_B cmpdstmt CURLY_RIGHT_B 
		;
condition:	condition relation expression
		| expression
		;
expression:     expression operation term
		| term
		;
term:		ID
		| NO
		;


relation:	LESS_THAN 
		| GREATER_THAN 
		| LESS_THAN_OR_EQ
		| GREATER_THAN_OR_EQ 
		| DOUBLE_EQ
		| AND 
		| OR 
		| NOT_EQ 
		| NOT 
		;	
operation:	PLUS 
		| MINUS 
		| MULTIPLY 
		| DIVIDE 
		| MODULO 
		| POW
		;

%%

yyerror(char *s)
{
  printf("%s\n", s);
}

extern FILE *yyin;

int main(int argc, char **argv)
{
  if(argc>1)
    yyin = fopen(argv[1], "r");

  if((argc>2)&&(!strcmp(argv[2],"-d")))
    yydebug = 1;

  if(!yyparse()) 
    fprintf(stderr,"\tThe input program is valid according to the given grammar rules.\n");
  else 	
    printf( "The input program is incorrect.\n" ); 
  return 0;
}