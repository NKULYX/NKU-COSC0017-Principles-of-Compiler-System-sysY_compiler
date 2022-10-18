%option noyywrap
%{
    /*
    * You will need to comment this line in lab5.
    */
    #define ONLY_FOR_LEX
    
    #ifdef ONLY_FOR_LEX
    #else
    #define YYSTYPE void *
    #include "parser.h"
    #endif

    #define YY_NO_UNPUT
    #define YY_NO_INPUT
    #include <string>
    #include <sstream>

    #ifdef ONLY_FOR_LEX
    #include <ostream>
    #include <fstream>
    using namespace std;
    extern FILE *yyin; 
    extern FILE *yyout;

    int offset = 1;

    void DEBUG_FOR_LAB4(std::string token, std::string lexeme){
        fprintf(yyout, "[DEBUG LAB4]:  %10s%10s%10d%10d\n",token.c_str(), lexeme.c_str(), yylineno, offset);
    }
    #endif
%}

INTEGER ([1-9][0-9]*|0)
OCTAL (0[1-7][0-7]*|0)
HEXAL (0(x|X)[1-9a-fA-F][0-9a-fA-F]*|0)
FLOATING ((([0-9]*[.][0-9]*([eE][+-]?[0-9]+)?)|([0-9]+[eE][+-]?[0-9]+))[fLlL]?)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
COMMENT (\/\/[^\n]*)
COMBLOCK (\/\*(.|\n)*\*\/)

%%

"int" {
    /*
    * Questions: 
    *   Q1: Why we need to return INT in further labs?
    *   Q2: What is "INT" actually?
    */
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("TYPE_INT", "int");
        offset+=strlen(yytext);
    #else
        return TYPE_INT;
    #endif
}
"float" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("TYPE_FLOAT", "float");
        offset+=strlen(yytext);
    #else
        return TYPE_FLOAT;
    #endif
}
"void" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("TYPE_VOID", "void");
        offset+=strlen(yytext);
    #else
        return TYPE_VOID;
    #endif 
}
"if" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("IF", "if");
        offset+=strlen(yytext);
    #else
        return IF;
    #endif
}
"else" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ELSE", "else");
        offset+=strlen(yytext);
    #else
        return ELSE;
    #endif
}
"while" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("WHILE", "while");
        offset+=strlen(yytext);
    #else
        return WHILE;
    #endif
}
"break" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("BREAK", "break");
        offset+=strlen(yytext);
    #else
        return BREAK;
    #endif
}
"continue" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("CONTINUE", "continue");
        offset+=strlen(yytext);
    #else
        return CONTINUE;
    #endif
}
"return" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RETURN", "return");
        offset+=strlen(yytext);
    #else
        return RETURN;
    #endif
}
"=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ASSIGN", "=");
        offset+=strlen(yytext);
    #else
        return ASSIGN;
    #endif
}
"==" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("EQ", "==");
        offset+=strlen(yytext);
    #else
        return EQ;
    #endif
}
"!=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("NEQ", "!=");
        offset+=strlen(yytext);
    #else
        return NEQ;
    #endif
}
"<" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LESS", "<");
        offset+=strlen(yytext);
    #else
        return LESS;
    #endif
}
"<=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LESSEQ", "<=");
        offset+=strlen(yytext);
    #else
        return LESSEQ;
    #endif
}
">" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("GREAT", ">");
        offset+=strlen(yytext);
    #else
        return GREAT;
    #endif
}
">=" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("GREATEQ", ">=");
        offset+=strlen(yytext);
    #else
        return GREATEQ;
    #endif
}
"+" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ADD", "+");
        offset+=strlen(yytext);
    #else
        return ADD;
    #endif
}
"-" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SUB", "-");
        offset+=strlen(yytext);
    #else
        return SUB;
    #endif
}
"*" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("MUL", "*");
        offset+=strlen(yytext);
    #else
        return MUL;
    #endif
}
"/" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("DIV", "/");
        offset+=strlen(yytext);
    #else
        return DIV;
    #endif
}
"||" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("OR", "||");
        offset+=strlen(yytext);
    #else
        return OR;
    #endif
}
"&&" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("AND", "&&");
        offset+=strlen(yytext);
    #else
        return AND;
    #endif
}
"!" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("NOT", "!");
        offset+=strlen(yytext);
    #else
        return NOT;
    #endif
}
"," {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("COMMA", ",");
        offset+=strlen(yytext);
    #else
        return COMMA;
    #endif
}
";" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("SEMICOLON", ";");
        offset+=strlen(yytext);
    #else
        return SEMICOLON;
    #endif
}
"(" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LPAREN", "(");
        offset+=strlen(yytext);
    #else
        return LPAREN;
    #endif
}
")" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RPAREN", ")");
        offset+=strlen(yytext);
    #else
    return RPAREN;
    #endif
}
"[" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LBRACKET", "[");
        offset+=strlen(yytext);
    #else
        return LBRACKET;
    #endif
}
"]" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RBRACKET", "]");
        offset+=strlen(yytext);
    #else
    return RBRACKET;
    #endif
}
"{" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("LBRACE", "{");
        offset+=strlen(yytext);
    #else
        return LBRACE;
    #endif
}
"}" {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("RBRACE", "}");
        offset+=strlen(yytext);
    #else
        return RBRACE;
    #endif
}

{INTEGER} {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("INTEGER", ""+std::string(yytext));
        offset+=strlen(yytext);
    #else
        return INTEGER;
    #endif
}
{FLOATING} {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("FLOATING", ""+std::string(yytext));
        offset+=strlen(yytext);
    #else
        return FLOATING;
    #endif
}
{ID} {
    #ifdef ONLY_FOR_LEX
        DEBUG_FOR_LAB4("ID", ""+std::string(yytext));
        offset+=strlen(yytext);
    #else
        return ID;
    #endif
}
{OCTAL} {
    #ifdef ONLY_FOR_LEX
        char* stop;
        int dec = strtol(yytext, &stop, 8);
        DEBUG_FOR_LAB4("DECIMAL", ""+to_string(dec));
        offset+=strlen(yytext);
    #else
        return INTEGER;
    #endif 
}
{HEXAL} {
    #ifdef ONLY_FOR_LEX
        char* stop;
        int dec = strtol(yytext, &stop, 16);
        DEBUG_FOR_LAB4("DECIMAL", ""+to_string(dec));
        offset+=strlen(yytext);
    #else
        return INTEGER;
    #endif 
}
{EOL} yylineno++,offset=1;
{WHITE} {
    if(yytext[0] == 32)
        offset+=1;
    else
        offset+=4;
}
{COMMENT}
{COMBLOCK}

%%

#ifdef ONLY_FOR_LEX
int main(int argc, char **argv){

    if(argc != 5){
        fprintf(stderr, "Argument Not Enough");
        exit(EXIT_FAILURE);
    }

    
    if(!(yyin = fopen(argv[1], "r"))){
        fprintf(stderr, "No such file or directory: %s", argv[1]);
        exit(EXIT_FAILURE);
    }

    if(!(yyout = fopen(argv[3], "w"))){
        fprintf(stderr, "No such file or directory: %s", argv[3]);
        exit(EXIT_FAILURE);
    }
    fprintf(yyout, "[DEBUG LAB4]:  %10s%10s%10s%10s\n","token", "lexeme", "lineno", "offset");
    yylineno = 1;
    yylex();
    return 0;
}
#endif