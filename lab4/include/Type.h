#ifndef __TYPE_H__
#define __TYPE_H__
#include <vector>
#include <string>

class Type
{
private:
    int kind;
protected:
    enum {INT, FLOAT, CONST_INT, CONST_FLOAT, VOID, BOOL, FUNC};
public:
    Type(int kind) : kind(kind) {};
    virtual ~Type() {};
    virtual std::string toStr() = 0;
    bool isInt() const {return kind == INT;};
    bool isFloat() const {return kind == FLOAT;};
    bool isConstInt() const {return kind == CONST_INT;}
    bool isConstFloat() const {return kind == CONST_FLOAT;}
    bool isBool() const {return kind == BOOL;}
    bool isVoid() const {return kind == VOID;};
    bool isFunc() const {return kind == FUNC;};
};

class IntType : public Type
{
private:
    int size;
public:
    IntType(int size) : Type(Type::INT), size(size){};
    std::string toStr();
};

class FloatType : public Type
{
public:
    FloatType() : Type(Type::FLOAT){};
    std::string toStr();
};

class ConstIntType : public Type
{
public:
    ConstIntType() : Type(Type::CONST_INT){};
    std::string toStr();
};

class ConstFloatType : public Type
{
public:
    ConstFloatType() : Type(Type::CONST_FLOAT){};
    std::string toStr();
};

class BoolType : public Type
{
public:
    BoolType() : Type(Type::BOOL){};
    std::string toStr();
};

class VoidType : public Type
{
public:
    VoidType() : Type(Type::VOID){};
    std::string toStr();
};


class FunctionType : public Type
{
private:
    Type *returnType;
    std::vector<Type*> paramsType;
public:
    FunctionType(Type* returnType, std::vector<Type*> paramsType) : 
    Type(Type::FUNC), returnType(returnType), paramsType(paramsType){};
    std::string toStr();
};

class TypeSystem
{
private:
    static IntType commonInt;
    static FloatType commonFloat;
    static ConstIntType commonConstInt;
    static ConstFloatType commonConstFloat;
    static BoolType commonBool;
    static VoidType commonVoid;
public:
    static Type *intType;
    static Type *floatType;
    static Type *constIntType;
    static Type *constFloatType;
    static Type *boolType;
    static Type *voidType;
};

#endif
