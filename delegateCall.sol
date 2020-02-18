contract A {
    bool public b;
    uint public n;
    address public s;
    function deleCall(address c){
        c.delegatecall(bytes4(sha3("setNum(uint256)")), 3);
    }
}

contract AA {
    uint public nn;
    address public ss;
    function hoge(address ad, address c){
        A a = A(ad);
        a.deleCall(c);
    }
}

contract Origin {
  uint public num;
  address public sender;

  function setNum(uint _num) public {
    num = _num;
    sender = msg.sender;
  }
}
