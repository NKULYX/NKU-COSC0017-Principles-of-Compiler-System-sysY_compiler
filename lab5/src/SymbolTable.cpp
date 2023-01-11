#include "SymbolTable.h"
#include "Type.h"
#include <iostream>
#include <sstream>
#include <string.h>
#include <iomanip>

extern FILE* yyout;

SymbolEntry::SymbolEntry(Type *type, int kind) 
{
    this->type = type;
    this->kind = kind;
}

ConstantSymbolEntry::ConstantSymbolEntry(Type *type, double value) : SymbolEntry(type, SymbolEntry::CONSTANT)
{
    this->value = value;
}

std::string ConstantSymbolEntry::toStr()
{
    // 如果是浮点数 需要转换成 IEEE754格式
    if(type->isFloat()) {
        static_assert(sizeof(double) == 8, "double must be 8 bytes");
        std::stringstream ss;
        ss << "0x" << std::hex << std::uppercase << std::setfill('0') << std::setw(16) << *reinterpret_cast<uint64_t*>(&value);
        return ss.str();
    }
    // 整数则可以直接转字符串
    else {
        std::ostringstream buffer;
        buffer << (int)value;
        return buffer.str();
    }
}

IdentifierSymbolEntry::IdentifierSymbolEntry(Type *type, std::string name, int scope) : SymbolEntry(type, SymbolEntry::VARIABLE), name(name)
{
    this->scope = scope;
}

std::string IdentifierSymbolEntry::toStr()
{
    // 如果value有，int型常量
    if(type==TypeSystem::constIntType){
        std::ostringstream buffer;
        buffer << (int)value;
        return buffer.str();
    }
    // float型常量
    if(type==TypeSystem::constFloatType) {
        static_assert(sizeof(double) == 8, "double must be 8 bytes");
        std::stringstream ss;
        ss << "0x" << std::hex << std::uppercase << std::setfill('0') << std::setw(16) << *reinterpret_cast<uint64_t*>(&value);
        return ss.str();
    }
    if(isGlobal()){
        return "@" + name;
    }
    else if(isParam()){
        return "%" + name;
    }
    return name;
}

void IdentifierSymbolEntry::outputFuncDecl()
{
    // 如果是库函数的声明
    if(this->type->isFunc()) {
        fprintf(yyout, "declare %s @%s(", 
            dynamic_cast<FunctionType*>(type)->getRetType()->toStr().c_str(), (const char*)name.c_str());
        bool first = true;
        for(auto type : dynamic_cast<FunctionType*>(type)->getParamsType()){
            if(!first){
                first = false;
                fprintf(yyout, ", ");
            }
            fprintf(yyout,"%s", type->toStr().c_str());
        }
        fprintf(yyout, ")\n");
    }
    // 否则应该为变量的声明
    else {
        if(this->type->isInt()) {
            fprintf(yyout, "@%s = dso_local global %s %d\n", this->name.c_str(), this->type->toStr().c_str(), (int)value);
        }
        else if(this->type->isFloat()) {
            fprintf(yyout, "@%s = dso_local global %s %s\n",this->name.c_str(), this->type->toStr().c_str(), toStr().c_str());
        }
    }
}

bool IdentifierSymbolEntry::isLibFunc()
{
    return name=="getint" || name=="getch" || name=="getfloat" 
        || name=="getdouble" || name=="getarray" || name=="getfarray" 
        || name=="putint" || name=="putch" || name=="putfloat" 
        || name=="putarray" || name=="putfarray" || name=="putf" 
        || name=="starttime" || name=="stoptime";
}

TemporarySymbolEntry::TemporarySymbolEntry(Type *type, int label) : SymbolEntry(type, SymbolEntry::TEMPORARY)
{
    this->label = label;
}

std::string TemporarySymbolEntry::toStr()
{
    std::ostringstream buffer;
    buffer << "%t" << label;
    return buffer.str();
}

SymbolTable::SymbolTable()
{
    prev = nullptr;
    level = 0;
}

SymbolTable::SymbolTable(SymbolTable *prev)
{
    this->prev = prev;
    this->level = prev->level + 1;
}

/*
    Description: lookup the symbol entry of an identifier in the symbol table
    Parameters: 
        name: identifier name
    Return: pointer to the symbol entry of the identifier

    hint:
    1. The symbol table is a stack. The top of the stack contains symbol entries in the current scope.
    2. Search the entry in the current symbol table at first.
    3. If it's not in the current table, search it in previous ones(along the 'prev' link).
    4. If you find the entry, return it.
    5. If you can't find it in all symbol tables, return nullptr.
*/
SymbolEntry* SymbolTable::lookup(std::string name)
{
    if(symbolTable.find(name)!=symbolTable.end()){
        return symbolTable[name];
    }else{
        if(prev != nullptr){
            return prev->lookup(name);
        }else{
            return nullptr;
        }
    }
}

bool SymbolTable::isRedefine(std::string name) {
    if(symbolTable.find(name)!=symbolTable.end()){
        return true;
    }
    else {
        return false;
    }
}

// install the entry into current symbol table.
void SymbolTable::install(std::string name, SymbolEntry* entry)
{
    symbolTable[name] = entry;
}

int SymbolTable::counter = 0;
static SymbolTable t;
SymbolTable *identifiers = &t;
SymbolTable *globals = &t;
