/**
 * linear scan register allocation
 */

#ifndef _LINEARSCAN_H__
#define _LINEARSCAN_H__
#include <set>
#include <map>
#include <vector>
#include <list>

class MachineUnit;
class MachineOperand;
class MachineFunction;


class LinearScan
{
private:
    struct Interval
    {
        int start;
        int end;
        bool spill; // whether this vreg should be spilled to memory
        int disp;   // displacement in stack
        int rreg;   // the real register mapped from virtual register if the vreg is not spilled to memory
        bool freg;  //为true时，为浮点寄存器
        std::set<MachineOperand *> defs;
        std::set<MachineOperand *> uses;
    };
    MachineUnit *unit;
    MachineFunction *func;
    std::vector<int> regs;
    std::vector<int> fregs;//可分配的浮点寄存器集合
    std::map<MachineOperand *, std::set<MachineOperand *>> du_chains;
    std::vector<Interval*> intervals;
    std::vector<Interval*> active;
    static bool compareStart(Interval*a, Interval*b);
    void expireOldIntervals(Interval *interval);
    void spillAtInterval(Interval *interval);
    void makeDuChains();
    void computeLiveIntervals();
    bool linearScanRegisterAllocation();
    void modifyCode();
    void genSpillCode();
    //比较函数1：用于确定可释放的active interval
    static bool victimComp(Interval* active, Interval* candidate){return active->end < candidate->start;}
    //比较函数2：用于确定插入active数组的位置
    static bool insertComp(Interval* first, Interval* second){return first->end < second->end;}
public:
    LinearScan(MachineUnit *unit);
    void allocateRegisters();
};

#endif