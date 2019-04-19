%{
#include <stdio.h>
#include <string.h>
#include "Parser.tab.h"

extern FILE *file1;
extern FILE *file2;
%}

NUMBER [0-9]+[\.0-9]*(e\-)?(e)?[0-9]*
IDENT  [A-Za-z]*
TAGIDENT  <[A-Za-z]+
WHITESPACE  [ \t\n]+
COMMENT  <!--[ \t\nA-Za-z]*?-->
PLUS  \+
MINUS  \-
MULT  \*
DIVIDE  \/
MODULO  \%
EXP  [*]{2}
LPAREN  \(
RPAREN  \)
LBRACKET \[
RBRACKET \]
EQUALS  \=
LTHAN  \<
GTHAN  \>
COLON  \:
COMMA  \,
SCOLON \;
PERIOD \.
QUOTE \'  																																		
DQUOTE \"																																			
ENDTAGHEAD <[/]
INVALIDTOKEN .																												

%%
\n 	{/* Do nothing */}
{COMMENT}	{/* Do nothing */}
{WHITESPACE}	{/* Do nothing */}
{NUMBER} {fprintf(file1,"%s%s%s", "NUMBER\t\t", yytext,"\n"); yylval.ival= atof(yytext); return NUMBER; }
{PLUS}	{fprintf(file1,"%s%s%s", "PLUS\t\t" ,yytext,"\n"); yylval.sval = strdup(yytext); return PLUS; }
{MINUS}	{fprintf(file1,"%s%s%s", "MINUS \t\t", yytext,"\n"); yylval.sval = strdup(yytext); return MINUS; }
{MULT}	{fprintf(file1,"%s%s%s", "MULT \t\t", yytext,"\n"); yylval.sval = strdup(yytext); return MULT; }
{DIVIDE} {fprintf(file1,"%s%s%s", "DIVIDE\t\t", yytext,"\n"); yylval.sval = strdup(yytext); return DIVIDE; }
{MODULO} {fprintf(file1,"%s%s%s", "MODULO\t\t", yytext,"\n"); yylval.sval = strdup(yytext); return MODULO; }
{EXP} {fprintf(file1,"%s%s%s", "EXP \t\t", yytext,"\n"); yylval.sval = strdup(yytext); return EXP;}
{LPAREN} {fprintf(file1,"%s%s%s", "LPAREN \t\t", yytext,"\n"); yylval.sval = strdup(yytext); return LPAREN; }
{RPAREN} {fprintf(file1,"%s%s%s", "RPAREN \t\t", yytext,"\n"); yylval.sval = strdup(yytext); return RPAREN; }
{EQUALS} {fprintf(file1,"%s%s%s", "EQUALS \t\t", yytext,"\n"); yylval.sval = strdup(yytext); return EQUALS; }
{LBRACKET} {fprintf(file1,"%s%s%s", "LBRACKET \t", yytext,"\n"); yylval.sval = strdup(yytext); return LBRACKET; }
{RBRACKET} {fprintf(file1,"%s%s%s", "RBRACKET \t", yytext,"\n"); yylval.sval = strdup(yytext); return RBRACKET; }
{LTHAN} {fprintf(file1,"%s%s%s", "LTHAN\t\t", yytext,"\n"); yylval.sval = strdup(yytext);return LTHAN; }
{GTHAN} {fprintf(file1,"%s%s%s", "GTHAN\t\t", yytext,"\n"); yylval.sval = strdup(yytext); return GTHAN; }
{COLON} {fprintf(file1,"%s%s%s", "COLON \t\t", yytext,"\n"); yylval.sval = strdup(yytext);return COLON;}
{COMMA} {fprintf(file1,"%s%s%s", "COMMA \t\t", yytext,"\n"); yylval.sval = strdup(yytext);return COMMA; }
{SCOLON} {fprintf(file1,"%s%s%s", "SCOLON \t\t", yytext,"\n"); yylval.sval = strdup(yytext);return SCOLON; }
{PERIOD} {fprintf(file1,"%s%s%s", "PERIOD \t\t", yytext,"\n"); yylval.sval = strdup(yytext);return PERIOD;}
{QUOTE} {fprintf(file1,"%s%s%s", "QUOTE \t\t", yytext,"\n"); yylval.sval = strdup(yytext);return QUOTE; }
{DQUOTE} {fprintf(file1,"%s%s%s", "DQUOTE \t\t", yytext,"\n"); yylval.sval = strdup(yytext);return DQUOTE;}
{IDENT} {fprintf(file1,"%s%s%s", "IDENT\t\t", yytext,"\n"); yylval.sval = strdup(yytext);return IDENT; }
{TAGIDENT} {fprintf(file1,"%s%s%s", "TAGIDENT \t", yytext,"\n"); yylval.sval = strdup(yytext);return TAGIDENT;}
{ENDTAGHEAD} {fprintf(file1,"%s%s%s", "ENDTAGHEAD \t", yytext,"\n"); yylval.sval = strdup(yytext);return ENDTAGHEAD; }
{INVALIDTOKEN} {fprintf(file1,"%s%s%s", "Invalid token \t", yytext,"\n"); }

%%
int yywrap (void ) 
{
    return 1;
}