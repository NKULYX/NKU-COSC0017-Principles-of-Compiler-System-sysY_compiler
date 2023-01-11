#include "../include/ArrayUtil.h"


Type* ArrayUtil::currentArrayType;
std::vector<int> ArrayUtil::arrayDims;
int ArrayUtil::currentArrayDim;
Operand* ArrayUtil::arrayAddr;
int ArrayUtil::currentOffset;
std::vector<ExprNode*> ArrayUtil::initVals;

void ArrayUtil::init() {
    currentArrayType = nullptr;
    arrayDims.clear();
    currentArrayDim = -1;
    arrayAddr = nullptr;
    currentOffset = 0;
    initVals.clear();
};

void ArrayUtil::setArrayType(Type* type) {
    currentArrayType = type;
    if(type->isIntArray()) {
        arrayDims = dynamic_cast<IntArrayType*>(type)->getDimensions();
    }
    else if(type->isFloatArray()) {
        arrayDims = dynamic_cast<FloatArrayType*>(type)->getDimensions();
    }
    else if(type->isConstIntArray()) {
        arrayDims = dynamic_cast<ConstIntArrayType*>(type)->getDimensions();
    }
    else if(type->isConstFloatArray()) {
        arrayDims = dynamic_cast<ConstFloatArrayType*>(type)->getDimensions();
    }
    else {
        throw "Invalid array type";
    }
    arrayDims.push_back(1);
};

Type* ArrayUtil::getArrayType() {
    return currentArrayType;
};

Type* ArrayUtil::getElementType() {
    if(currentArrayType->isIntArray()) {
        return TypeSystem::intType;
    }
    else if(currentArrayType->isFloatArray()) {
        return TypeSystem::floatType;
    }
    else if(currentArrayType->isConstIntArray()) {
        return TypeSystem::constIntType;
    }
    else if(currentArrayType->isConstFloatArray()) {
        return TypeSystem::constFloatType;
    }
    else {
        throw "Invalid array type";
    }
}

void ArrayUtil::setCurrentArrayDim(int dim) {
    currentArrayDim = dim;
};

int ArrayUtil::getCurrentArrayDim() {
    return currentArrayDim;
};

void ArrayUtil::incCurrentDim() {
    currentArrayDim++;
};

void ArrayUtil::decCurrentDim() {
    currentArrayDim--;
};

int ArrayUtil::getDimSize(int i) {
    return arrayDims[i];
};

void ArrayUtil::setArrayAddr(Operand* dst) {
    arrayAddr = dst;
};

Operand* ArrayUtil::getArrayAddr() {
    return arrayAddr;
};

void ArrayUtil::incCurrentOffset() {
    currentOffset++;
};

int ArrayUtil::getCurrentOffset() {
    return currentOffset;
};

int ArrayUtil::getCurrentDimCapacity() {
    int capacity = 1;
    for(int i = currentArrayDim; i < int(arrayDims.size()); i++) {
        capacity *= arrayDims[i];
    }
    return capacity;
};

void ArrayUtil::insertInitVal(ExprNode *val) {
    initVals.push_back(val);
};

void ArrayUtil::paddingInitVal(int size) {
    int padding = getCurrentDimCapacity();
    while(size++ < arrayDims[currentArrayDim] || initVals.size() % padding != 0) {
        if(getElementType()->isInt()) {
            initVals.push_back(new Constant(new ConstantSymbolEntry(TypeSystem::constIntType, 0)));
        }
        else {
            initVals.push_back(new Constant(new ConstantSymbolEntry(TypeSystem::constFloatType, 0)));
        }
    }
};

std::vector<ExprNode *> &ArrayUtil::getInitVals() {
    return initVals;
};
