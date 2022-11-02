#ifndef __AST_H__
#define __AST_H__

#include <fstream>
#include <vector>

class SymbolEntry;
class Type;

class Node
{
private:
    static int counter;
    int seq;
public:
    Node();
    int getSeq() const {return seq;};
    virtual void output(int level) = 0;
};

// todo 考虑加一个const标志位来表示是否为常量表达式？
class ExprNode : public Node
{
protected:
    SymbolEntry *symbolEntry;
public:
    ExprNode(SymbolEntry *symbolEntry) : symbolEntry(symbolEntry){};
    Type* getType();
};

class BinaryExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr1, *expr2;
public:
    enum {ADD, SUB, MUL, DIV, MOD, AND, OR, LESS, LESSEQ, GREAT, GREATEQ, EQ, NEQ};
    BinaryExpr(SymbolEntry *se, int op, ExprNode*expr1, ExprNode*expr2) : ExprNode(se), op(op), expr1(expr1), expr2(expr2){};
    void output(int level);
};

class OneOpExpr : public ExprNode
{
private:
    int op;
    ExprNode *expr;
public:
    enum {SUB, NOT};
    OneOpExpr(SymbolEntry *se, int op, ExprNode* expr): ExprNode(se), op(op), expr(expr){};
    void output(int level);
};

class Constant : public ExprNode
{
public:
    Constant(SymbolEntry *se) : ExprNode(se){};
    void output(int level);
};

class StmtNode : public Node
{};

class ExprStmtNode : public StmtNode
{//注意：该类由ExprStmt与ArrayIndices共享，二者的行为完全一致
private:
    std::vector<ExprNode*> exprList;
public:
    ExprStmtNode(){};
    void addNext(ExprNode* next);
    void output(int level);
};

class Id : public ExprNode
{
private:
    ExprStmtNode* indices;
public:
    Id(SymbolEntry *se) : ExprNode(se), indices(nullptr){};
    SymbolEntry* getSymbolEntry() {return symbolEntry;}
    bool isArray();     //必须配合indices!=nullptr使用（a[]的情况）
    void addIndices(ExprStmtNode* idx) {indices = idx;}
    void output(int level);
};

class EmptyStmt : public StmtNode
{
public:
    EmptyStmt(){};
    void output(int level);
};

class FuncCallParamsNode : public StmtNode
{
private:
    std::vector<ExprNode*> paramsList;
public:
    FuncCallParamsNode(){};
    void addNext(ExprNode* next);
    void output(int level);
};

class FuncCallNode : public ExprNode
{
private:
    Id* funcId;
    FuncCallParamsNode* params;
public:
    FuncCallNode(SymbolEntry *se, Id* id, FuncCallParamsNode* params) : ExprNode(se), funcId(id), params(params){};
    void output(int level);
};

class CompoundStmt : public StmtNode
{
private:
    StmtNode *stmt;
public:
    CompoundStmt(StmtNode *stmt) : stmt(stmt) {};
    void output(int level);
};

class SeqNode : public StmtNode
{
private:
    std::vector<StmtNode*> stmtList;
public:
    SeqNode(){};
    void addNext(StmtNode* next);
    void output(int level);
};

class InitValNode : public StmtNode
{
private:
    bool isConst;
    ExprNode* leafNode; //可能为空，j即使是叶节点（考虑{}）
    std::vector<InitValNode*> innerList;//为空则为叶节点，这是唯一判断标准
public:
    InitValNode(bool isConst) : 
        isConst(isConst), leafNode(nullptr){};
    void addNext(InitValNode* next);
    void setLeafNode(ExprNode* leaf);
    bool isLeaf();
    void output(int level);
};

class DefNode : public StmtNode
{
private:
    bool isConst;
    bool isArray;
    Id* id;
    Node* initVal;//对于非数组，是ExprNode；对于数组，是InitValueNode
public:
    DefNode(Id* id, Node* initVal, bool isConst, bool isArray) : 
        isConst(isConst), isArray(isArray), id(id), initVal(initVal){};
    Id* getId() {return id;}
    void output(int level);
};

class DeclStmt : public StmtNode
{
private:
    bool isConst;
    std::vector<DefNode*> defList;
public:
    DeclStmt(bool isConst) : isConst(isConst){};
    void addNext(DefNode* next);
    void output(int level);
};

class IfStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
public:
    IfStmt(ExprNode *cond, StmtNode *thenStmt) : cond(cond), thenStmt(thenStmt){};
    void output(int level);
};

class IfElseStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *thenStmt;
    StmtNode *elseStmt;
public:
    IfElseStmt(ExprNode *cond, StmtNode *thenStmt, StmtNode *elseStmt) : cond(cond), thenStmt(thenStmt), elseStmt(elseStmt) {};
    void output(int level);
};

class WhileStmt : public StmtNode
{
private:
    ExprNode *cond;
    StmtNode *bodyStmt;
public:
    WhileStmt(ExprNode *cond, StmtNode *bodyStmt) : cond(cond), bodyStmt(bodyStmt){};
    void output(int level);
};

class BreakStmt : public StmtNode
{
public:
    void output(int level);
};

class ContinueStmt : public StmtNode
{
public:
    void output(int level);
};

class ReturnStmt : public StmtNode
{
private:
    ExprNode *retValue;
public:
    ReturnStmt(ExprNode*retValue) : retValue(retValue) {};
    void output(int level);
};

class AssignStmt : public StmtNode
{
private:
    ExprNode *lval;
    ExprNode *expr;
public:
    AssignStmt(ExprNode *lval, ExprNode *expr) : lval(lval), expr(expr) {};
    void output(int level);
};

class FuncDefParamsNode : public StmtNode
{
private:
    std::vector<Id*> paramsList;
public:
    FuncDefParamsNode() {};
    void addNext(Id* next);
    std::vector<Type*> getParamsType();
    void output(int level);
};

class FunctionDef : public StmtNode
{
private:
    SymbolEntry *se;
    FuncDefParamsNode *params;
    StmtNode *stmt;
public:
    FunctionDef(SymbolEntry *se, FuncDefParamsNode *params, StmtNode *stmt) : se(se), params(params), stmt(stmt){};
    void output(int level);
};

class Ast
{
private:
    Node* root;
public:
    Ast() {root = nullptr;}
    void setRoot(Node*n) {root = n;}
    void output();
};

#endif
