#include "Unit.h"
#include "Type.h"

void Unit::insertFunc(Function *f)
{
    func_list.push_back(f);
}

void Unit::removeFunc(Function *func)
{
    func_list.erase(std::find(func_list.begin(), func_list.end(), func));
}

void Unit::insertDecl(IdentifierSymbolEntry* se)
{
    declare_func.insert(se);
}

void Unit::output() const
{
    // 先定义全局变量
    for (auto decl : declare_func){
        if(!decl->isLibFunc())
            decl->outputFuncDecl();
    }
    // 再定义库函数
    for (auto decl : declare_func){
        if(decl->isLibFunc())
            decl->outputFuncDecl();
    }
    for (auto &func : func_list){
        func->output();
    }
}

void Unit::genMachineCode(MachineUnit* munit) 
{
    AsmBuilder* builder = new AsmBuilder();
    builder->setUnit(munit);
    // 设置全局变量
    for(auto decl : declare_func){
        if((!decl->isLibFunc() && !decl->getType()->isConst()) || decl->getType()->isArray()) {
            munit->insertGlobalVar(decl);
        }
    }
    for (auto &func : func_list)
        func->genMachineCode(builder);
}

Unit::~Unit()
{
    for(auto &func:func_list)
        delete func;
}
