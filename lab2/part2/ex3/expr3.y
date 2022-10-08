%{
#include <iostream>
#include <string>
#include <any>
#include "SymbolTable.h"
#ifndef YYSTYPE
#define YYSTYPE double
#endif

int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);

SymbolTable symbolTable;

%}

%token ADD
%token SUB
%token MUL
%token DIV
%token UMINUS
%token LEFT
%token RIGHT
%token NUMBER
%token IDENTIFIER
%token ASSIGN
%token SEMI
%token END

%left ADD SUB
%left MUL DIV
%right UMINUS

%%

program :   program END                 {symbolTable.printAll();}
        |   program stmt
        |   stmt
        ;

stmt    :   IDENTIFIER ASSIGN expr SEMI {
                                            symbolTable.insert(($1), ($3));
                                        }
        ;

expr    :   expr ADD expr               {$$ = ($1) + ($3);}
        |   expr SUB expr               {$$ = ($1) - ($3);}
        |   expr MUL expr               {$$ = ($1) * ($3);}
        |   expr DIV expr               {$$ = ($1) / ($3);}
        |   LEFT expr RIGHT             {$$ = ($2);}
        |   SUB expr %prec UMINUS       {$$ = -($2);}
        |   NUMBER                      {$$ = ($1);}
        |   IDENTIFIER                  {
                                            std::string identifier = ($1);
                                            if(!symbolTable.lookup(identifier)){
                                                std::cout << "ERROR! " << identifier << " NOT DEFINED!" << std::endl;
                                            }
                                            else{
                                                $$ = symbolTable.getValue(identifier);
                                            }
                                        }
        ;

%%

int yylex()
{
    int ch;
    while(1) {
        ch = getchar();
        if(ch == ' ' || ch == '\t' || ch =='\n');
        else if (isdigit(ch)){
            yylval = 0;
            while(isdigit(ch)){
                yylval = yylval * 10 + ch - '0';
                ch = getchar();
            }
            ungetc(ch, stdin);
            return NUMBER;
        }
        else if (isalpha(ch) || ch == '_'){
            std::string str = "";
            while(isalpha(ch) || isdigit(ch) || ch == '_'){
                str.push_back(ch);
                ch = getchar();
            }
            ungetc(ch, stdin);
            if(str=="END!") {
                return END;
            }
            else{
                symbolTable.insert(str, 0);
                return IDENTIFIER;
            }
        }
        else if (ch == '+'){
            return ADD;
        }
        else if(ch == '-'){
            return SUB;
        }
        else if (ch == '*'){
            return MUL;
        }
        else if (ch == '/'){
            return DIV;
        }
        else if (ch == '('){
            return LEFT;
        }
        else if (ch == ')'){
            return RIGHT;
        }
        else if (ch == '='){
            return ASSIGN;
        }
        else if (ch == ';'){
            return SEMI;
        }
        else{
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