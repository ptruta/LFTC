/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NO = 258,
     ID = 259,
     CST = 260,
     INT = 261,
     CHAR = 262,
     BOOL = 263,
     ARRAY = 264,
     FLOAT = 265,
     STRUCT = 266,
     IF = 267,
     ELSE = 268,
     FOR = 269,
     WHILE = 270,
     BEG = 271,
     END = 272,
     RE = 273,
     WR = 274,
     STRING = 275,
     EPSILON = 276,
     SQUARE_LEFT_B = 277,
     SQUARE_RIGHT_B = 278,
     CURLY_LEFT_B = 279,
     CURLY_RIGHT_B = 280,
     ROUND_LEFT_B = 281,
     ROUND_RIGHT_B = 282,
     TWO_DOTS = 283,
     SEMI_COLON = 284,
     SPACE = 285,
     COMA = 286,
     DOT = 287,
     MINUS = 288,
     PLUS = 289,
     DIVIDE = 290,
     MULTIPLY = 291,
     OR = 292,
     AND = 293,
     LESS_THAN = 294,
     GREATER_THAN = 295,
     LESS_THAN_OR_EQ = 296,
     EQ = 297,
     GREATER_THAN_OR_EQ = 298,
     DOUBLE_EQ = 299,
     MODULO = 300,
     NOT = 301,
     NOT_EQ = 302,
     POW = 303
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
