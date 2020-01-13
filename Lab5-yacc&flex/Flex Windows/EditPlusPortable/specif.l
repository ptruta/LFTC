%{
#include <math.h> 
#include "parser.tab.h"
int lines = 0;
%}
%option noyywrap

SIGN		[+-]
DIGIT		[0-9]
NO		(0|[1-9]{DIGIT}*)
CST		[a-zA-Z]*|[1-9]*[0-9]*|0
ID		[a-zA-Z_][a-zA-Z_0-9]*{0,8}



%%

{NO}		{printf( "Number: %s\n", yytext );  return NO;}

"INT"		{printf( "Reserved word: %s\n", yytext );	return INT;}
"CHAR"		{printf( "Reserved word: %s\n", yytext );	return CHAR;}
"BOOL"		{printf( "Reserved word: %s\n", yytext );	return BOOL;}
"ARRAY"		{printf( "Reserved word: %s\n", yytext );	return ARRAY;}
"FLOAT"		{printf( "Reserved word: %s\n", yytext );	return FLOAT;}
"STRUCT"	{printf( "Reserved word: %s\n", yytext );	return STRUCT;}
"IF"		{printf( "Reserved word: %s\n", yytext );	return IF;}
"ELSE"		{printf( "Reserved word: %s\n", yytext );	return ELSE;}
"FOR"		{printf( "Reserved word: %s\n", yytext );	return FOR;}
"WHILE"		{printf( "Reserved word: %s\n", yytext );	return WHILE;}
"BEGIN"		{printf( "Reserved word: %s\n", yytext );	return BEG;}
"END"		{printf( "Reserved word: %s\n", yytext );	return END;}
"READ"		{printf( "Reserved word: %s\n", yytext );	return RE;}
"WRITE"		{printf( "Reserved word: %s\n", yytext );	return WR;}
"STRING"	{printf( "Reserved word: %s\n", yytext );	return STRING;}
"EPSILON"	{printf( "Reserved word: %s\n", yytext );	return EPSILON;}

{ID}		{printf( "Identifier: %s\n", yytext ); return ID;}
{CST}		{printf( "Constant: %s\n", yytext ); return CST;}

"+"		{printf( "Operator: %s\n", yytext );  return PLUS;}
"-"		{printf( "Operator: %s\n", yytext );  return MINUS;}
"*"		{printf( "Operator: %s\n", yytext );  return MULTIPLY;}
"/"		{printf( "Operator: %s\n", yytext );  return DIVIDE;}
"<"		{printf( "Operator: %s\n", yytext );  return LESS_THAN;}
">"		{printf( "Operator: %s\n", yytext );  return GREATER_THAN;}
"<="		{printf( "Operator: %s\n", yytext );  return LESS_THAN_OR_EQ;}
">="		{printf( "Operator: %s\n", yytext );  return GREATER_THAN_OR_EQ;}
"=="		{printf( "Operator: %s\n", yytext );  return DOUBLE_EQ;}
"&&"		{printf( "Operator: %s\n", yytext );  return AND;}
"||"		{printf( "Operator: %s\n", yytext );  return OR;}
"%"		{printf( "Operator: %s\n", yytext );  return MODULO;}
"!"		{printf( "Operator: %s\n", yytext );  return NOT;}
"!="		{printf( "Operator: %s\n", yytext );  return NOT_EQ;}
"^"		{printf( "Operator: %s\n", yytext );  return POW;}
"="		{printf( "Operator: %s\n", yytext );  return EQ;}

"["		{printf( "Separator: %s\n", yytext );  return SQUARE_LEFT_B;}
"]"		{printf( "Separator: %s\n", yytext );  return SQUARE_RIGHT_B;}
"{"		{printf( "Separator: %s\n", yytext );  return CURLY_LEFT_B;}
"}"		{printf( "Separator: %s\n", yytext );  return CURLY_RIGHT_B;}
"("		{printf( "Separator: %s\n", yytext );  return ROUND_LEFT_B;} 
")"		{printf( "Separator: %s\n", yytext );  return ROUND_RIGHT_B;} 
":"		{printf( "Separator: %s\n", yytext );  return TWO_DOTS;}
";"		{printf( "Separator: %s\n", yytext );  return SEMI_COLON;} 
","		{printf( "Separator: %s\n", yytext );  return COMA;}

[ \t\n]+ 	/* eat up whitespace */ {}
"{"[^}\n]*"}"	/* elimina comentarii */ {}
. 		{printf("Unknown symbol\n");	 return -1;}

