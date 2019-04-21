%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <math.h>
  extern int yylex();
  extern int yyparse();
  extern FILE *yyin;

  FILE *file1;
  FILE *file2;
  void yyerror(const char *s);
%}

%union{
  double ival;
  char *sval; 
}
%expect 20


%left MINUS
%left PLUS
%left MULT
%left DIVIDE 
%left EXP
%left LPAREN RPAREN


%token <ival> NUMBER
%token <sval> IDENT
%token <sval> TAGIDENT
%token <sval> ENDTAGHEAD
%token <sval> PLUS 
%token <sval> MINUS
%token <sval> MULT
%token <sval> DIVIDE
%token <sval> MODULO
%token <sval> LPAREN
%token <sval> RPAREN
%token <sval> LBRACKET
%token <sval> RBRACKET
%token <sval> EQUALS
%token <sval> LTHAN
%token <sval> GTHAN
%token <sval> COLON
%token <sval> COMMA 
%token <sval> SCOLON
%token <sval> PERIOD
%token <sval> QUOTE
%token <sval> DQUOTE
%token <sval> EXP

%type <ival> EXPR
%type <ival> S_EXPR

%error-verbose

%start program
%%

program: summary /*{fprintf(file1,"%s", "End of file \t"); } only put it back if debugging */ 
;

summary: opener rows closer | opener rows closer contents
;

opener: TAGIDENT GTHAN | TAGIDENT IDENT EQUALS NUMBER GTHAN
;

closer: ENDTAGHEAD IDENT GTHAN
;

rows: row | row rows
;

row: opener cells closer
{
  fprintf(file2,"\n");
}
;

cells: cell | cell cells
;

cell: opener contents closer | opener opener contents closer 
;

contents: content | content contents
;

content: LBRACKET S_EXPR RBRACKET  {{fprintf(file2,"%s",",");}}
  | EQUALS EXPR {{fprintf(file2,"%0.2lf%s",$2,",");}}
  | IDENT {fprintf(file2,"%s%s",$1,",");}
  | NUMBER {fprintf(file2,"%0.2lf%s",$1,",");}
  | PLUS {fprintf(file2,"%s%s",$1,",");}
  | MINUS {fprintf(file2,"%s%s",$1,",");}
  | MULT {fprintf(file2,"%s%s",$1,",");}
  | DIVIDE {fprintf(file2,"%s%s",$1,",");}
  | MODULO {{fprintf(file2,"%s%s",$1,",");}}
  | LPAREN {{fprintf(file2,"%s%s",$1,",");}}
  | RPAREN {{fprintf(file2,"%s%s",$1,",");}}
  | LBRACKET {{fprintf(file2,"%s%s",$1,",");}}
  | RBRACKET {{fprintf(file2,"%s%s",$1,",");}}
  | EQUALS {{fprintf(file2,"%s%s",$1,",");}}
  | LTHAN {{fprintf(file2,"%s%s",$1,",");}}
  | GTHAN {{fprintf(file2,"%s%s",$1,",");}}
  | COLON {{fprintf(file2,"%s%s",$1,",");}}
  | COMMA {{fprintf(file2,"%s%s",$1,",");}}
  | SCOLON {{fprintf(file2,"%s%s",$1,",");}}
  | PERIOD {{fprintf(file2,"%s%s",$1,",");}}
  | QUOTE {{fprintf(file2,"%s%s",$1,",");}}
  | DQUOTE {{fprintf(file2,"%s%s",$1,",");}}
  | EXP {{fprintf(file2,"%s%s",$1,",");}}
  
;

EXPR: NUMBER { $$ = $1;}
  | EXPR PLUS EXPR {$$ = $1 + $3;}
  | EXPR MINUS EXPR {$$ = $1 - $3;}
  | EXPR MULT EXPR {$$ = $1 * $3;}
  | EXPR DIVIDE EXPR {$$ = $1 / $3;} 
  | EXPR EXP EXPR { $$ = pow ($1, $3); } 
  | LPAREN EXPR RPAREN { $$ = $2;}
  | EXPR MODULO EXPR { $$ = fmod($1, $3); }
;

S_EXPR: NUMBER  {fprintf(file2,"%0.2lf",$1);}
  | nums NUMBER {fprintf(file2,"%0.2lf",$2);}
; 

nums: num | nums num
;

num: NUMBER PLUS {fprintf(file2,"%0.2lf%s",$1,$2);}
| NUMBER MINUS {fprintf(file2,"%0.2lf%s",$1,$2);}
| NUMBER MULT {fprintf(file2,"%0.2lf%s",$1,$2);}
| NUMBER DIVIDE {fprintf(file2,"%0.2lf%s",$1,$2);}

;

%%
int main(int argc, char *argv[])
{
    #ifdef YYDEBUG
    yydebug = 1;
    #endif
    yyin = fopen(argv[1], "r");
    file1 = fopen(argv[2], "w");
    file2 = fopen(argv[3], "w");    
    //fprintf(file1, "%s%s","TOKEN\t\t","LEXEME\n");   
	//fprintf(file1, "-------------------------------------------------\n");
	yyparse();
    fclose(yyin);
    fclose(file1);
    fclose(file2);
}

void yyerror(const char *s) {
	fprintf(stderr, "%s\n", s);		
}