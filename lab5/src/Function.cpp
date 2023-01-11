#include "Function.h"
#include "Unit.h"
#include "Type.h"
#include <list>

extern FILE* yyout;

Function::Function(Unit *u, SymbolEntry *s)
{
    u->insertFunc(this);
    entry = new BasicBlock(this);
    sym_ptr = s;
    parent = u;
}

Function::~Function()
{
    auto delete_list = block_list;
    for (auto &i : delete_list)
        delete i;
    // parent->removeFunc(this);
}

// remove the basicblock bb from its block_list.
void Function::remove(BasicBlock *bb)
{
    block_list.erase(std::find(block_list.begin(), block_list.end(), bb));
}

// TODO : 添加有参数的函数声明
// 这里有很多问题 现行的实现方法并不能够找到函数参数对应的符号表项
// 以及函数参数应该使用什么样的临时寄存器
// 以及这个函数对应的符号表怎么找 甚至我觉得他现在的符号表设计就有问题
// 建议先把int能解决就行 float和数组先放放吧 工作量我觉得不小
void Function::output() const
{
    FunctionType* funcType = dynamic_cast<FunctionType*>(sym_ptr->getType());
    Type *retType = funcType->getRetType();
    fprintf(yyout, "define %s %s(", retType->toStr().c_str(), sym_ptr->toStr().c_str());
    bool first = true;
    for(auto param : params_list){
        if(first){
            first = false;
        }
        else fprintf(yyout, ", ");
        fprintf(yyout, "%s %s", param->getType()->toStr().c_str(), param->toStr().c_str());
    }
    fprintf(yyout, "){\n");
    std::set<BasicBlock *> v;
    std::list<BasicBlock *> q;
    q.push_back(entry);
    v.insert(entry);
    while (!q.empty())
    {
        auto bb = q.front();
        q.pop_front();
        bb->output();
        for (auto succ = bb->succ_begin(); succ != bb->succ_end(); succ++)
        {
            if (v.find(*succ) == v.end())
            {
                v.insert(*succ);
                q.push_back(*succ);
            }
        }
    }
    fprintf(yyout, "}\n");
}
