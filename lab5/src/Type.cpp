#include "Type.h"
#include <sstream>

IntType TypeSystem::commonInt = IntType(4);
IntType TypeSystem::commonConstInt = IntType(4, true);
FloatType TypeSystem::commonFloat = FloatType(4);
FloatType TypeSystem::commonConstFloat = FloatType(4, true);
BoolType TypeSystem::commonBool = BoolType(1);
BoolType TypeSystem::commonConstBool = BoolType(1, true);
VoidType TypeSystem::commonVoid = VoidType();

Type* TypeSystem::intType = &commonInt;
Type* TypeSystem::constIntType = &commonConstInt;
Type* TypeSystem::floatType = &commonFloat;
Type* TypeSystem::constFloatType = &commonConstFloat;
Type* TypeSystem::boolType = &commonBool;
Type* TypeSystem::constBoolType = &commonConstBool;
Type* TypeSystem::voidType = &commonVoid;

Type* TypeSystem::getMaxType(Type* type1, Type* type2){
    if(type1->isFloat() || type2->isFloat()) return floatType;
    if(type1->isInt() || type2->isInt()) return intType;
    else return boolType;
}

bool TypeSystem::needCast(Type* src, Type* target) {
    if(src->isInt() && target->isInt()) {
        return false;
    }
    if(src->isFloat() && target->isFloat()) {
        return false;
    }
    if(src->isBool() && target->isBool()) {
        return false;
    }
    return true;
}

std::string IntType::toStr()
{
    return "i32";
}

std::string FloatType::toStr()
{
    return "float";
}

// std::string ConstIntType::toStr()
// {
//     return "i32";
// }

// std::string ConstFloatType::toStr()
// {
//     return "const float";
// }

std::string BoolType::toStr()
{
    return "i1";
}

std::string VoidType::toStr()
{
    return "void";
}

void FunctionType::setparamsType(std::vector<Type*> in)
{
    paramsType = in;
}

std::string FunctionType::toStr()
{
    return returnType->toStr();
    // std::ostringstream buffer;
    // buffer << returnType->toStr() << "(";
    // for(int i = 0;i < (int)paramsType.size();i++){
    //     if(i!=0) buffer << ", ";
    //     buffer << paramsType[i]->toStr();
    // }
    // buffer << ")";
    // return buffer.str();
}

void IntArrayType::pushBackDimension(int dim)
{
    dimensions.push_back(dim);
}

std::vector<int> IntArrayType::getDimensions()
{
    return dimensions;
}

std::string IntArrayType::toStr()
{
    return "int array";
}

void FloatArrayType::pushBackDimension(int dim)
{
    dimensions.push_back(dim);
}

std::vector<int> FloatArrayType::getDimensions()
{
    return dimensions;
}

std::string FloatArrayType::toStr()
{
    return "float array";
}
void ConstIntArrayType::pushBackDimension(int dim)
{
    dimensions.push_back(dim);
}

std::vector<int> ConstIntArrayType::getDimensions()
{
    return dimensions;
}

std::string ConstIntArrayType::toStr()
{
    return "const int array";
}

void ConstFloatArrayType::pushBackDimension(int dim)
{
    dimensions.push_back(dim);
}

std::vector<int> ConstFloatArrayType::getDimensions()
{
    return dimensions;
}

std::string ConstFloatArrayType::toStr()
{
    return "const float array";
}

std::string PointerType::toStr()
{
    std::ostringstream buffer;
    buffer << valueType->toStr() << "*";
    return buffer.str();
}