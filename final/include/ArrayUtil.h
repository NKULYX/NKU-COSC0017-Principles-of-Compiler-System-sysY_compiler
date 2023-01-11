#ifndef TMP_COMPILER_ARRAYUTIL_H
#define TMP_COMPILER_ARRAYUTIL_H

#include "Type.h"
#include "Operand.h"
#include "Ast.h"
#include <vector>

class ArrayUtil {
    static Type* currentArrayType;
    static std::vector<int> arrayDims;
    static int currentArrayDim;
    static Operand* arrayAddr;
    static int currentOffset;
    static std::vector<ExprNode*> initVals;
public:
    static void init();
    static void setArrayType(Type* type);
    static Type* getArrayType();
    static Type* getElementType();
    static void setCurrentArrayDim(int dim);
    static int getCurrentArrayDim();
    static void incCurrentDim();
    static void decCurrentDim();
    static int getDimSize(int i);
    static int getCurrentDimCapacity();
    static void setArrayAddr(Operand* dst);
    static Operand* getArrayAddr();
    static void incCurrentOffset();
    static int getCurrentOffset();
    static void insertInitVal(ExprNode* val);
    static void paddingInitVal(int size);
    static std::vector<ExprNode*>& getInitVals();
};


#endif //TMP_COMPILER_ARRAYUTIL_H
