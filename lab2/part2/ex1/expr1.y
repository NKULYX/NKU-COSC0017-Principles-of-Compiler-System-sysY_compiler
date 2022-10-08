%{
#include <stdio.h>
#include <stdlib.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif

int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}

%token ADD
%token SUB
%token MUL
%token DIV
%token UMINUS
%token LEFT
%token RIGHT
%token NUMBER

%left ADD SUB
%left MUL DIV
%right UMINUS

%%

lines   :   lines expr ';' {printf("%f\n", $2);}
        |   lines ';'
        |   
        ;

expr    :   expr ADD expr           {$$ = $1 + $3;}
        |   expr SUB expr           {$$ = $1 - $3;}
        |   expr MUL expr           {$$ = $1 * $3;}
        |   expr DIV expr           {$$ = $1 / $3;}
        |   LEFT expr RIGHT         {$$ = $2;}
        |   SUB expr %prec UMINUS   {$$ = -$2;}
        |   NUMBER                  {$$ = $1;}
        ;

%%

int yylex()
{
    int ch;
    while(1) {
        ch = getchar();
        if(ch == ' ' || ch == '\t' || ch =='\n');
        else if (isdigit(ch))
        {
            yylval = 0;
            while(isdigit(ch))
            {
                yylval = yylval * 10 + ch - '0';
                ch = getchar();
            }
            ungetc(ch, stdin);
            return NUMBER;
        }
        else if (ch == '+')
        {
            return ADD;
        }
        else if(ch == '-')
        {
            return SUB;
        }
        else if (ch == '*')
        {
            return MUL;
        }
        else if (ch == '/')
        {
            return DIV;
        }
        else if (ch == '(')
        {
            return LEFT;
        }
        else if (ch == ')')
        {
            return RIGHT;
        }
        else
        {
            return ch;
        }
    }
}

int main()
{
    yyin = stdin;
    do {
        yyparse();
    } while(!feof(yyin));
    return 0;
}

void yyerror(const char* s)
{
    fprintf(stderr, "Parse error:%s\n", s);
    exit(1);
}