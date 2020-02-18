contract ddd {
    uint[] public nums;
    uint public p1;
    bool public p2;
    address public p3;
    string public p4;

    function push(uint n) public {
        nums.push(n);
    }
    function pop(uint index) public returns(uint) {
        uint n = nums[index];
        delete nums[index];
        return n;
    }
    function set1() public {
        p1 = 1;
        p2 = true;
        p3 = msg.sender;
        p4 = 'hello';
    }
    function del() public {
        delete p1;
        delete p2;
        delete p3;
        delete p4;
    }
}
