#ifndef __MACHINECODE_H__
#define __MACHINECODE_H__
#include <utility>
#include <vector>
#include <set>
#include <queue>
#include <string>
#include <algorithm>
#include <fstream>
#include "SymbolTable.h"

/* Hint:
* MachineUnit: Compiler unit
* MachineFunction: Function in assembly code 
* MachineInstruction: Single assembly instruction  
* MachineOperand: Operand in assembly instruction, such as immediate number, register, address label */

/* Todo:
* We only give the example code of "class BinaryMInstruction" and "class AccessMInstruction" (because we believe in you !!!),
* You need to complete other the member function, especially "output()" ,
* After that, you can use "output()" to print assembly code . */

class MachineUnit;
class MachineFunction;
class MachineBlock;
class MachineInstruction;

class MachineOperand
{
private:
    MachineInstruction* parent;
    int type;
    int val;  // value of immediate number
    int reg_no; // register no
    std::string label; // address label
    bool is_funct; //用于判断是否函数
    bool is_float = false;  // 判断是否浮点数
    float fval;
public:
    enum { IMM, VREG, REG, LABEL };
    MachineOperand(int tp, int val, bool flt = false, float fval = 0.0);
    MachineOperand(std::string label, bool is_func = false, bool flt = false);
    bool operator == (const MachineOperand&) const;
    bool operator < (const MachineOperand&) const;
    bool isImm() { return this->type == IMM; }; 
    bool isReg() { return this->type == REG; };
    bool isVReg() { return this->type == VREG; };
    bool isLabel() { return this->type == LABEL; };
    void setVal(int in_val) {this->val = in_val;};
    int getVal() {return this->val; };
    float getFVal() { return this->fval; }
    void setFVal(float fval) { this->fval = fval;}
    bool isFloat() { return this->is_float; }
    int getReg() {return this->reg_no; };
    void setReg(int regno) {this->type = REG; this->reg_no = regno;};
    std::string getLabel() {return this->label; };
    void setParent(MachineInstruction* p) { this->parent = p; };
    MachineInstruction* getParent() { return this->parent;};
    void PrintReg();
    void output();
};

class MachineInstruction
{
protected:
    MachineBlock* parent;
    int no;
    int type;  // Instruction type
    int cond = MachineInstruction::NONE;  // Instruction execution condition, optional !!
    int op;  // Instruction opcode
    // Instruction operand list, sorted by appearance order in assembly instruction
    std::vector<MachineOperand*> def_list;
    std::vector<MachineOperand*> use_list;
    void addDef(MachineOperand* ope) { def_list.push_back(ope); };
    void addUse(MachineOperand* ope) { use_list.push_back(ope); };
    // Print execution code after printing opcode
    void PrintCond();
    enum instType { BINARY, LOAD, STORE, MOV, BRANCH, CMP, STACK, ZEXT, VCVT, VMRS};
public:
    enum condType { EQ, NE, LT, LE , GT, GE, NONE };
    virtual void output() = 0;
    void setNo(int no) {this->no = no;};
    int getNo() {return no;};
    std::vector<MachineOperand*>& getDef() {return def_list;};
    std::vector<MachineOperand*>& getUse() {return use_list;};
    MachineBlock* getParent(){ return parent; };
};

class BinaryMInstruction : public MachineInstruction
{
public:
    enum opType { ADD, SUB, MUL, DIV, AND, OR, VADD, VSUB, VMUL, VDIV};
    BinaryMInstruction(MachineBlock* p, int op, 
                    MachineOperand* dst, MachineOperand* src1, MachineOperand* src2, 
                    int cond = MachineInstruction::NONE);
    void output();
};


class LoadMInstruction : public MachineInstruction
{
public:
    enum opType{LDR, VLDR};
    LoadMInstruction(MachineBlock* p,
                    MachineOperand* dst, MachineOperand* src1, MachineOperand* src2 = nullptr, 
                    int op = LDR, int cond = MachineInstruction::NONE);
    void output();
};

class StoreMInstruction : public MachineInstruction
{
public:
    enum opType{STR, VSTR};
    StoreMInstruction(MachineBlock* p,
                    MachineOperand* src1, MachineOperand* src2, MachineOperand* src3 = nullptr, 
                    int op = STR, int cond = MachineInstruction::NONE);
    void output();
};

class MovMInstruction : public MachineInstruction
{
public:
    //MVN指令不同的是在传送之前，将被传送的对象先按位取反，再传送到目的寄存器。
    enum opType { MOV, MVN, MOVT, VMOV, VMOVF32};
    MovMInstruction(MachineBlock* p, int op, 
                MachineOperand* dst, MachineOperand* src,
                int cond = MachineInstruction::NONE);
    void output();
};

class BranchMInstruction : public MachineInstruction
{
public:
    enum opType { B, BL, BX };
    BranchMInstruction(MachineBlock* p, int op, 
                MachineOperand* dst, 
                int cond = MachineInstruction::NONE);
    void output();
};

class CmpMInstruction : public MachineInstruction
{
public:
    enum opType { CMP, VCMP };
    CmpMInstruction(MachineBlock* p, 
                MachineOperand* src1, MachineOperand* src2,
                int cond = MachineInstruction::NONE, int optype = CMP);
    void output();
};

class StackMInstruction : public MachineInstruction
{
public:
    enum opType { PUSH, POP, VPUSH, VPOP };
    StackMInstruction(MachineBlock* p, int op, 
                std::vector<MachineOperand*> src,
                int cond = MachineInstruction::NONE);
    void output();
};

class ZextMInstruction : public MachineInstruction
{
public:
    ZextMInstruction(MachineBlock* p,
                MachineOperand* dst, MachineOperand* src,
                int cond = MachineInstruction::NONE);
    void output();
};

class VcvtMInstruction : public MachineInstruction {
public:
    enum opType { S2F, F2S };
    VcvtMInstruction(MachineBlock* p,
                     int op,
                     MachineOperand* dst,
                     MachineOperand* src,
                     int cond = MachineInstruction::NONE);
    void output();
};

class VmrsMInstruction : public MachineInstruction {
public:
    VmrsMInstruction(MachineBlock* p);
    void output();
};

class MachineBlock
{
private:
    MachineFunction* parent;
    int no;  
    std::vector<MachineBlock *> pred, succ;
    std::vector<MachineInstruction*> inst_list;
    std::set<MachineOperand*> live_in;
    std::set<MachineOperand*> live_out;
    int current_branch_cond = MachineInstruction::NONE;
    static int spilt_label;
public:
    std::vector<MachineInstruction*>& getInsts() {return inst_list;};
    std::vector<MachineInstruction*>::iterator begin() { return inst_list.begin(); };
    std::vector<MachineInstruction*>::iterator end() { return inst_list.end(); };
    std::vector<MachineInstruction*>::reverse_iterator rbegin() { return inst_list.rbegin(); };
    MachineBlock(MachineFunction* p, int no) { this->parent = p; this->no = no; };
    void InsertInst(MachineInstruction* inst) { this->inst_list.push_back(inst); };
    void addPred(MachineBlock* p) { this->pred.push_back(p); };
    void addSucc(MachineBlock* s) { this->succ.push_back(s); };
    std::set<MachineOperand*>& getLiveIn() {return live_in;};
    std::set<MachineOperand*>& getLiveOut() {return live_out;};
    std::vector<MachineBlock*>& getPreds() {return pred;};
    std::vector<MachineBlock*>& getSuccs() {return succ;};
    void insertBefore(MachineInstruction* at, MachineInstruction* src);
    void insertAfter(MachineInstruction* at, MachineInstruction* src);
    void setCurrentBranchCond(int cond) {this->current_branch_cond = cond;};
    int getCurrentBranchCond() {return this->current_branch_cond;};
    MachineFunction* getParent() {return this->parent;}
    void output();
};

class MachineFunction
{
private:
    MachineUnit* parent;
    std::vector<MachineBlock*> block_list;
    int stack_size;
    std::set<int> saved_regs;
    std::vector<MachineOperand*> saved_params_offset;
    SymbolEntry* sym_ptr;
public:
    std::vector<MachineBlock*>& getBlocks() {return block_list;};
    std::vector<MachineBlock*>::iterator begin() { return block_list.begin(); };
    std::vector<MachineBlock*>::iterator end() { return block_list.end(); };
    MachineFunction(MachineUnit* p, SymbolEntry* sym_ptr);
    /* HINT:
    * Alloc stack space for local variable;
    * return current frame offset ;
    * we store offset in symbol entry of this variable in function AllocInstruction::genMachineCode()
    * you can use this function in LinearScan::genSpillCode() */
    int AllocSpace(int size) { this->stack_size += size; return this->stack_size; };
    void InsertBlock(MachineBlock* block) { this->block_list.push_back(block); };
    void addSavedRegs(int regno) {saved_regs.insert(regno);};
    std::vector<MachineOperand*> getSavedRRegs();
    std::vector<MachineOperand*> getSavedFRegs();
    void insertSavedParamsOffset(MachineOperand* offset) {saved_params_offset.push_back(offset);};
    MachineUnit* getParent() {return parent;}
    void output();
};

class MachineUnit
{
private:
    std::vector<MachineFunction*> func_list;
    std::vector<IdentifierSymbolEntry*> global_var_list;
    void PrintGlobalDecl();
    int n;
public:
    std::vector<MachineFunction*>& getFuncs() {return func_list;};
    std::vector<MachineFunction*>::iterator begin() { return func_list.begin(); };
    std::vector<MachineFunction*>::iterator end() { return func_list.end(); };
    void InsertFunc(MachineFunction* func) { func_list.push_back(func);};
    void insertGlobalVar(IdentifierSymbolEntry* sym_ptr);
    void PrintGlobal();
    int getN() {return n;}
    void output();
};

#endif