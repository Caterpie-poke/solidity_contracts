// pragma solidity ^0.4.25;
pragma experimental ABIEncoderV2;
contract ReleaseTheSpyce {
    function f1() public pure returns(uint[6]){
        uint[6] memory hoge = [uint(1),1,4,5,1,4];
        return hoge;
    }
    function f2() public returns(uint[]){
        uint[] hoge;
        hoge.push(uint(114514));
        hoge.push(23);
        return hoge;
    }
    struct S1 {
        uint p1;
        bool p2;
    }
    function f3() public pure returns(S1){
        S1 memory hoge;
        hoge.p1 = 334;
        hoge.p2 = true;
        return hoge;
    }
    function f4(){
        uint Internal = 0;
    }
}
