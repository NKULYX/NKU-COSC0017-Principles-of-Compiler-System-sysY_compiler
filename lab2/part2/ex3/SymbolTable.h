#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <string>
#include <map>

class SymbolTable {
    std::map<std::string, double> symbolTable;
public:
    bool lookup(std::string identifier);
    bool insert(std::string identifier, double value);
    double getValue(std::string identifier);
    void printAll();
};
#endif //SYMBOLTABLE_H