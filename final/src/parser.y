%{
#include <stdio.h>
#include <stdlib.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif

int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}

%token ID
%token CONST
%token INTEGER FLOATING
%token TYPE_INT TYPE_FLOAT TYPE_VOID
%token IF ELSE WHILE BREAK CONTINUE RETURN
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE COMMA SEMICOLON 
%token ADD SUB MUL DIV AND OR NOT LESS LESSEQ GREAT GREATEQ EQ NEQ ASSIGN

%%
// 编译单元
CompUint        :       CompUint Decl
                |       CompUint FuncDef
                |       Decl
                |       FuncDef
                ;

// 常量、变量声明语句
Decl            :       ConstDecl
                |       VarDecl
                ;

// 基本类型
Type            :       TYPE_INT
                |       TYPE_FLOAT
                |       TYPE_VOID
                ;

// 数组的常量下标表示
ArrConstIndices :       ArrConstIndices LBRACKET ConstExp RBRACKET
                |       LBRACKET ConstExp RBRACKET
                ;

// 数组的变量下标表示
ArrValIndices   :       ArrValIndices LBRACKET Exp RBRACKET
                |       LBRACKET Exp RBRACKET
                ;

// 数组的函数参数下标表示
ArrFuncIndices  :       ArrFuncIndices LBRACKET Exp RBRACKET
                |       LBRACKET RBRACKET
                ;

// 常量声明语句
ConstDecl       :       CONST Type ConstDefList SEMICOLON
                ;

// 常量定义列表
ConstDefList    :       ConstDefList COMMA ConstDef
                |       ConstDef
                ;

// 常量定义
ConstDef        :       ID ASSIGN ConstInitVal
                |       ID ArrConstIndices ASSIGN ConstInitVal
                ;

// 常量初始化值
ConstInitVal    :       ConstExp
                |       LBRACE ConstInitValList RBRACE
                ;

// 数组常量初始化列表
ConstInitValList:       ConstInitValList COMMA ConstInitVal
                |       ConstInitVal

// 变量声明语句
VarDecl         :       Type VarDefList SEMICOLON
                ;

// 变量定义列表
VarDefList      :       VarDefList COMMA VarDef
                |       VarDef
                ;

// 变量定义
VarDef          :       ID
                |       ID ArrConstIndices
                |       ID ASSIGN VarInitVal
                |       ID ArrConstIndices ASSIGN VarInitVal
                ;

// 变量初始化值
VarInitVal      :       Exp
                |       LBRACE VarInitValList RBRACE
                ;

// 数组变量初始化列表
VarInitValList  :       VarInitValList COMMA VarInitVal
                |       VarInitVal
                ;

// 函数定义
FuncDef         :       Type ID LPAREN FuncParams RPAREN BlockStmt
                ;

// 函数参数列表
FuncParams      :       FuncParams COMMA FuncParam
                |       FuncParam
                |       %empty
                ;

// 函数参数
FuncParam       :       Type ID 
                |       Type ID ArrFuncIndices
                ;

// 语句块语句
BlockStmt       :       LBRACE Block RBRACE

// 语句块
Block           :       Block BlockItem
                |       BlockItem

// 语句块项
BlockItem       :       Decl
                |       Stmt
                ;

// 语句
Stmt            :       AssignStmt
                |       ExpStmt
                |       BlockStmt
                |       IfStmt
                |       WhileStmt
                |       BreakStmt
                |       ContinueStmt
                |       ReturnStmt
                ;

// 左值
LVal            :       ID
                |       ID ArrValIndices
                ;

// 赋值语句
AssignStmt      :       LVal ASSIGN Exp SEMICOLON
                ;

// 表达式语句
ExpStmt         :       Exp SEMICOLON
                ;

// if语句
IfStmt          :       IF LPAREN Cond RPAREN Stmt ELSE Stmt
                ;

// while语句
WhileStmt       :       WHILE LPAREN Cond RPAREN Stmt
                ;

// break语句
BreakStmt       :       BREAK SEMICOLON
                ;

// continue语句
ContinueStmt    :       CONTINUE SEMICOLON

// return语句
ReturnStmt      :       RETURN SEMICOLON
                |       RETURN Exp SEMICOLON
                ;

// 常量表达式
ConstExp        :       AddExp
                ;

// 算数表达式
Exp             :       AddExp
                ;

// 加法级表达式
AddExp          :       AddExp ADD MulExp
                |       AddExp SUB MulExp
                |       MulExp
                ;

// 乘法级表达式
MulExp          :       MulExp MUL UnaryExp
                |       MulExp DIV UnaryExp
                |       UnaryExp
                ;

// 非数组表达式
UnaryExp        :       PrimaryExp
                |       FuncCall
                |       OneOp UnaryExp
                ;

// 初始表达式
PrimaryExp      :       LPAREN Exp RPAREN
                |       LVal
                |       INTEGER
                |       FLOATING
                ;

// 函数调用
FuncCall        :       ID LPAREN FuncCallParams RPAREN
                ;

// 函数调用参数列表
FuncCallParams  :       FuncCallParams COMMA Exp
                |       Exp   
                ;

// 单目运算符
OneOp           :       ADD
                |       SUB
                |       NOT

// 条件表达式
Cond            :       LOrExp
                ;

// 或运算表达式
LOrExp          :       LOrExp OR LAndExp
                |       LAndExp
                ;

// 与运算表达式
LAndExp         :       LAndExp AND EqExp
                |       EqExp
                ;

// 相等判断表达式
EqExp           :       EqExp EQ RelExp
                |       EqExp NEQ RelExp
                |       RelExp
                ;

// 关系表达式
RelExp          :       RelExp LESS AddExp
                |       RelExp LESSEQ AddExp
                |       RelExp GREAT AddExp
                |       RelExp GREATEQ AddExp
                |       AddExp
                ;
%%

/* int yyerror(char const* message)
{
    std::cerr << message << std::endl;
    std::cerr << yytext << std::endl;
    return -1;
} */