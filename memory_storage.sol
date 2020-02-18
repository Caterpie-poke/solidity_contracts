contract Test {
    uint public number;
    string public str = "Initial";
    uint[5] public static_numbers;
    uint[] public dynamic_numbers;
    mapping(address=>uint) balance;
    struct S {
        uint id;
        bool which;
    }
    S s1;

    function f0(string storage storageParam) internal {
        str = storageParam;
    }
    function f1(string memory memoryParam) public {
        str = memoryParam;
    }
    function f3_0() public {
        uint[5] storage tempArray = static_numbers;
        tempArray[0] = 3;
    }
    function f4_0() public {
        uint[5] memory tempArray = static_numbers;
        tempArray[0] = 4;
    }
    function f3_1() public {
        uint[] storage tempArray = dynamic_numbers;
        tempArray.push(3);
    }
    function f4_1() public {
        uint[] memory tempArray = dynamic_numbers;
        tempArray[0] = 4;
    }
    function f5(){
        S storage ttt = s1;
        uint num2;
        num2 = number;
    }
}
