#include "Util.h"

float strToNum(std::string str){
    std::stringstream ss;
    ss << str;
    float num;
    ss >> num;
    return num;
}

std::string numToStr(float num){
    std::stringstream ss;
    ss << num;
    std::string str;
    ss >> str;
    return str;
}
