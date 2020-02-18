contract Main {
    constructor() public payable {}

    function getMe() public view returns(address) {
        return this;
    }
    function getSender() public view returns(address) {
        return msg.sender;
    }
    function getOrigin() public view returns(address) {
        return tx.origin;
    }
    function getSelfBalance() public view returns(uint256) {
        return address(this).balance;
    }
    function giveMeMoney(uint amount) public payable returns(bool) {
        require(msg.sender.send(amount));
        return true;
    }
}

contract Ext {
    Main m;
    constructor(address cont) public {
        m = Main(cont);
    }
    function getMe() public view returns(address) {
        return this;
    }
    function getMeExt() public view returns(address) {
        return m.getMe();
    }
    function getSenderExt() public view returns(address) {
        return m.getSender();
    }
    function getOriginExt() public view returns(address) {
        return m.getOrigin();
    }
}
