pragma solidity ^0.4.24;
contract Math {

    // function calc(bytes stringBytes) external pure returns(int) {
    function calc(string _input) external pure returns(int) {
        bytes memory stringBytes = bytes(_input);
        (int answer,) = addsub(stringBytes,0);
        return (answer);
    }
    function addsub(bytes _input, uint pc) internal pure returns(int, uint){
        (int leftNum, uint leftRemain) = muldiv(_input,pc);
        if(leftRemain >= _input.length)return (leftNum, leftRemain);
        int rightNum;
        uint rightRemain = leftRemain;
        int sum = leftNum;
        while(rightRemain < _input.length) {
            if(_input[rightRemain] == 0x2b){
                (rightNum,rightRemain) = muldiv(_input,rightRemain+1);
                sum += rightNum;
            } else if(_input[rightRemain] == 0x2d) {
                (rightNum,rightRemain) = muldiv(_input,rightRemain+1);
                sum -= rightNum;
            } else {
                break;
            }
        }
        return (sum, rightRemain);
    }
    function muldiv(bytes _input, uint pc) internal pure returns(int,uint){
        (int leftNum, uint leftRemain) = num(_input,pc);
        if(leftRemain >= _input.length)return (leftNum, leftRemain);
        int rightNum;
        uint rightRemain = leftRemain;
        int sum = leftNum;
        while(rightRemain < _input.length) {
            if(_input[rightRemain] == 0x2a){
                (rightNum,rightRemain) = num(_input,rightRemain+1);
                sum *= rightNum;
            } else if(_input[rightRemain] == 0x2f) {
                (rightNum,rightRemain) = num(_input,rightRemain+1);
                sum /= rightNum;
            } else {
                break;
            }
        }
        return (sum, rightRemain);
    }
    function num(bytes _input, uint pc) internal pure returns(int, uint){
        pc = spaceSkip(_input,pc);

        if(_input[pc] == 0x28){
            (int innerAns, uint innerOut) = addsub(_input,pc+1);
            innerOut = spaceSkip(_input, innerOut);
            require(_input[innerOut] == 0x29);
            innerOut = spaceSkip(_input, innerOut+1);
            return (innerAns, innerOut);
        }

        uint start = pc;
        while(pc < _input.length && isNum(_input[pc])){
            pc++;
        }
        uint remain = pc;
        bytes memory temp = selectedBytes(_input,start,remain);
        int thisNum = bytesToInteger(temp);
        remain = spaceSkip(_input,remain);
        return (thisNum, remain);
    }
    function spaceSkip(bytes memory _input, uint pc) internal pure returns(uint){
        while(pc < _input.length && _input[pc] == 0x20){
            pc++;
        }
        return pc;
    }
    function selectedBytes(bytes memory _input, uint start, uint stop) internal pure returns(bytes){
        bytes memory temp = new bytes(stop-start);
        for(uint i=start;i<stop;i++){
            temp[i-start] = _input[i];
        }
        return temp;
    }
    function isNum(byte b) internal pure returns(bool){
        if(0x30<=uint(b) && uint(b)<=0x39)return true;
        else return false;
    }
    function stringToInteger(string memory _str) internal pure returns(int){
        bytes memory temp = bytes(_str);
        return bytesToInteger(temp);
    }
    function bytesToInteger(bytes memory _str) internal pure returns(int){
        uint strLen = _str.length;
        uint tempAns = 0;
        for(uint i=strLen;i>0;i--){
            tempAns += bytesToUnsignedInteger(_str,strLen-i) * 10**(i-1);
        }
        return int(tempAns);
    }
    function bytesToUnsignedInteger(bytes memory strByte, uint index) internal pure returns(uint){
        byte char = strByte[index];
        if     (char == 0x30) return 0;
        else if(char == 0x31) return 1;
        else if(char == 0x32) return 2;
        else if(char == 0x33) return 3;
        else if(char == 0x34) return 4;
        else if(char == 0x35) return 5;
        else if(char == 0x36) return 6;
        else if(char == 0x37) return 7;
        else if(char == 0x38) return 8;
        else if(char == 0x39) return 9;
        else revert("Can't parse byte to uint");
    }
    function stringToBytes(string memory str) internal pure returns(bytes){
        return bytes(str);
    }
}



