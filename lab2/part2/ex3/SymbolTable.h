#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <string>
#include <unordered_map>

class SymbolTable {
    std::unordered_map<std::string, double> symbolTable;
public:
    bool lookup(std::string identifier);
    void insert(std::string identifier, double value);
    double getValue(std::string identifier);
    void printAll();
};
#endif //SYMBOLTABLE_H