%code top{
    #include <iostream>
    #include <assert.h>
    #include "parser.h"
    extern Ast ast;
    int yylex();
    int yyerror( char const * );

    Type* currentType;
}

%code requires {
    #include "Ast.h"
    #include "SymbolTable.h"
    #include "Type.h"
}

%union {
    int itype;
    float ftype;
    char* strtype;
    StmtNode* stmttype;
    ExprNode* exprtype;
    Type* type;
}

%start Program
%token <strtype> ID 
%token <itype> INTEGER
%token <ftype> FLOATING
%token CONST
%token TYPE_INT TYPE_FLOAT TYPE_VOID
%token IF ELSE WHILE BREAK CONTINUE RETURN
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE COMMA SEMICOLON
%token ADD SUB MUL DIV MOD AND OR NOT LESS LESSEQ GREAT GREATEQ EQ NEQ ASSIGN

%type <stmttype> Stmts Stmt AssignStmt BlockStmt IfStmt WhileStmt BreakStmt ContinueStmt ReturnStmt DeclStmt ConstDefList ConstDef FuncDef
%type <exprtype> Exp ConstExp AddExp MulExp UnaryExp PrimaryExp LVal Cond LOrExp LAndExp EqExp RelExp
%type <type> Type

%precedence THEN
%precedence ELSE
%%

// 程序
Program
    :   Stmts{
            ast.setRoot($1);
        }
    ;

// 语句序列
Stmts
    :   Stmt{
            $$=$1;
        }
    |   Stmts Stmt{
            $$ = new SeqNode($1, $2);
        }
    ;

// 语句
Stmt
    :   AssignStmt {$$=$1;}
    |   BlockStmt {$$=$1;}
    |   IfStmt {$$=$1;}
    |   WhileStmt {$$=$1;}
    |   BreakStmt {$$=$1;}
    |   ContinueStmt {$$=$1;}
    |   ReturnStmt {$$=$1;}
    |   DeclStmt {$$=$1;}
    |   FuncDef {$$=$1;}
    ;

// 左值
LVal
    :   ID {
            SymbolEntry *se;
            se = identifiers->lookup($1);
            if(se == nullptr)
            {
                fprintf(stderr, "identifier \"%s\" is undefined\n", (char*)$1);
                delete [](char*)$1;
                assert(se != nullptr);
            }
            $$ = new Id(se);
            delete []$1;
        }
    // 缺少数组的左值
    ;

// 赋值语句
AssignStmt
    :   LVal ASSIGN Exp SEMICOLON {
            $$ = new AssignStmt($1, $3);
        }
    ;

// 语句快
BlockStmt
    :   LBRACE {
            identifiers = new SymbolTable(identifiers);
        } 
        Stmts RBRACE {
            $$ = new CompoundStmt($3);
            SymbolTable *top = identifiers;
            identifiers = identifiers->getPrev();
            delete top;
        }
    ;

// if语句
IfStmt
    :   IF LPAREN Cond RPAREN Stmt %prec THEN {
            $$ = new IfStmt($3, $5);
        }
    |   IF LPAREN Cond RPAREN Stmt ELSE Stmt {
            $$ = new IfElseStmt($3, $5, $7);
        }
    ;

//todo while 语句
WhileStmt
    :   WHILE LPAREN Cond RPAREN Stmt {
            std::cout << "WhileStmt -> WHILE LPAREN Cond RPAREN Stmt" << std::endl;
        }
    ;

//todo break 语句
BreakStmt
    :   BREAK SEMICOLON {
            std::cout << "BreakStmt -> BREAK SEMICOLON" << std::endl;
        }
    ;

//todo continue 语句
ContinueStmt
    :   CONTINUE SEMICOLON{
            std::cout << "ContinueStmt -> CONTINUE SEMICOLON" << std::endl;
        }
    ;


// return 语句
ReturnStmt
    :   RETURN Exp SEMICOLON {
            $$ = new ReturnStmt($2);
        }
    |   RETURN SEMICOLON {
            std::cout << "ReturnStmt -> RETURN SEMICOLON" << std::endl;
        }
    ;

// 变量表达式
Exp
    :   AddExp {
            $$ = $1;
        }
    ;

// 常量表达式
ConstExp
    :   AddExp {
            $$ = $1;
        }
    ;

// 加法级表达式
AddExp
    :   MulExp {
            $$ = $1;
        }
    |   AddExp ADD MulExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::ADD, $1, $3);
        }
    |   AddExp SUB MulExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::SUB, $1, $3);
        }
    ;

// 乘法级表达式
MulExp
    :   UnaryExp {
            $$ = $1;
        }
    |   MulExp MUL UnaryExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::MUL, $1, $3);
        }
    |   MulExp DIV UnaryExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::DIV, $1, $3);
        }
    |   MulExp MOD UnaryExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::MOD, $1, $3);
        }
    ;

// 非数组表达式
UnaryExp
    :   PrimaryExp {
            $$ = $1;
        }
    |   ID LPAREN RPAREN {
            std::cout << "UnaryExp -> ID LPAREN RPAREN" << std::endl;
        }
    // todo 函数调用
    /* |   ID LPAREN FuncRParams RPAREN {
            std::cout << "UnaryExp -> ID LPAREN FuncRParams RPAREN" << std::endl;
        } */
    |   ADD UnaryExp {
            $$ = $2;
        }
    |   SUB UnaryExp {
            $$ = new OneOpExpr(nullptr, OneOpExpr::SUB, $2);
        }
    |   NOT UnaryExp {
            $$ = new OneOpExpr(nullptr, OneOpExpr::NOT, $2);
        }
    ;

// 原始表达式
PrimaryExp
    :   LVal {
            $$ = $1;
        }
    |   LPAREN Exp RPAREN {
            $$ = $2;
        }
    |   INTEGER {
            SymbolEntry *se = new ConstantSymbolEntry(TypeSystem::intType, $1);
            $$ = new Constant(se);
        }
    // todo 浮点数
    /* |   FLOATING {

    } */
    ;

//todo 函数参数列表
/* FuncRParams
    :
    ; */

// 条件表达式
Cond
    :   LOrExp {$$ = $1;}
    ;

// 或运算表达式
LOrExp
    :   LAndExp {
            $$ = $1;
        }
    |   LOrExp OR LAndExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::OR, $1, $3);
        }
    ;

// 与运算表达式
LAndExp
    :   EqExp {
            $$ = $1;
        }
    |   LAndExp AND EqExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::AND, $1, $3);
        }
    ;

// 相等判断表达式
EqExp
    :   RelExp {
            $$ = $1;
        }
    |   EqExp EQ RelExp {
            SymbolEntry* se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::EQ, $1, $3);
        }
    |   EqExp NEQ RelExp {
            SymbolEntry* se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::NEQ, $1, $3);
        }
    ;

// 关系表达式
RelExp
    :   AddExp {
            $$ = $1;
        }
    |   RelExp LESS AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::LESS, $1, $3);
        }
    |   RelExp LESSEQ AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::LESSEQ, $1, $3);
        }
    |   RelExp GREAT AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::GREAT, $1, $3);
        }
    |   RelExp GREATEQ AddExp {
            SymbolEntry *se = new TemporarySymbolEntry(TypeSystem::intType, SymbolTable::getLabel());
            $$ = new BinaryExpr(se, BinaryExpr::GREATEQ, $1, $3);
        }
    ;

// 类型
Type
    :   TYPE_INT {
            $$ = TypeSystem::intType;
            currentType = TypeSystem::intType;
        }
    |   TYPE_FLOAT {
            $$ = TypeSystem::floatType;
            currentType = TypeSystem::floatType;
        }
    |   TYPE_VOID {
            $$ = TypeSystem::voidType;
        }
    ;

// 声明语句
DeclStmt
    :   CONST Type ConstDefList SEMICOLON {
            $$ = $3;
        }
    |   Type ID SEMICOLON {
            SymbolEntry *se;
            se = new IdentifierSymbolEntry($1, $2, identifiers->getLevel());
            identifiers->install($2, se);
            $$ = new DeclStmt(new Id(se));
            delete []$2;
        }
    ;

// 常量定义列表
ConstDefList
    :   ConstDefList COMMA ConstDef {
            DeclStmt* node = (DeclStmt*) $1;
            node->addNext((DefNode*)$3);
            $$ = node;
        }
    |   ConstDef {
            DeclStmt* node = new DeclStmt(true);
            node->addNext((DefNode*)$1);
            $$ = node;
        }
    ;

// 常量定义
ConstDef
    :   ID ASSIGN ConstExp {
            // 首先将ID插入符号表中
            Type* type;
            if(currentType->isInt()){
                type = TypeSystem::constIntType;
            }
            else{
                type = TypeSystem::constFloatType;
            }
            SymbolEntry *se;
            se = new IdentifierSymbolEntry(type, $1, identifiers->getLevel());
            identifiers->install($1, se);
            $$ = new DefNode(new Id(se), $3);
        }
    // todo 数组的定义
    ;

// 函数定义
FuncDef
    :
    Type ID {
        Type *funcType;
        funcType = new FunctionType($1,{});
        SymbolEntry *se = new IdentifierSymbolEntry(funcType, $2, identifiers->getLevel());
        identifiers->install($2, se);
        identifiers = new SymbolTable(identifiers);
    }
    LPAREN RPAREN
    BlockStmt
    {
        SymbolEntry *se;
        se = identifiers->lookup($2);
        assert(se != nullptr);
        $$ = new FunctionDef(se, $6);
        SymbolTable *top = identifiers;
        identifiers = identifiers->getPrev();
        delete top;
        delete []$2;
    }
    ;
%%

int yyerror(char const* message)
{
    std::cerr<<message<<std::endl;
    return -1;
}
