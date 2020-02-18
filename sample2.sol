pragma solidity ^0.4.23;
contract Sample2 {
    address public adr;
    string public text;
    constructor(string _message) public {
        text = _message;
    }
    function getSender() public constant returns(address){
        return msg.sender;
    }
    function even(int _num) public pure returns(bool, string){
        if(_num % 2 == 0)
            return (true, "Even");
        else
            return (false, "Odd");
    }
    function hoge(int _num) public pure returns(string){
        var (b,s) = even(_num);
        return s;
    }
    function wloop() public pure returns (string){
        int check = 0;
        while(true){
            if(check>3000)break;
            check++;
        }
        return "loop out";
    }
    function add(uint _left, uint _right) public pure returns (uint) {
        return _left+_right;
    }
    function recursion(int _num) public pure returns (int) {
        if(_num < 1000){return recursion(_num + 1);}
        else{return _num;}
    }
}
