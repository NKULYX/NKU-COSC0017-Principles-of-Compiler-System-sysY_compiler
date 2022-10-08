#include <iostream>
#include <cfloat>
#include "SymbolTable.h"

bool SymbolTable::lookup(std::string identifier)
{
    if(symbolTable.find(identifier) == symbolTable.end()){
        return false;
    }
    return true;
}

void SymbolTable::insert(std::string identifier, double value)
{
    auto res = symbolTable.insert(std::pair<std::string, double>(identifier, value));
    if(res.second){
        std::cout << "Insert " << identifier << "=" << value <<" success!" << std::endl;
    }
    else{
        std::cout << "Update " << identifier << ":" << symbolTable[identifier] << "->" << value << " success!" << std::endl;
        symbolTable[identifier] = value;
    }
    printAll();
}

double SymbolTable::getValue(std::string identifier)
{
    if(symbolTable.find(identifier) == symbolTable.end()) {
        return DBL_MIN;
    }
    return symbolTable.find(identifier)->second;
}

void SymbolTable::printAll()
{
    for (auto &item : symbolTable){
        std::cout << item.first << " = " << item.second << std::endl;
    }
}