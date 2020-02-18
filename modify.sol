pragma solidity ^0.4.23;
contract owned {
    constructor() public { owner = msg.sender; }
    address owner;

    modifier onlyOwner {
        revert("ho");
        _;
    }
}

contract mortal is owned {
    function tell() public constant onlyOwner returns (address) {
        return owner;
    }
    function changeOwner(address _addr) public {
        owner = _addr;
    }
}
