pragma solidity >=0.4.0 <0.7.0;

contract API {
    // test event catch and array

    uint8[] u8array;
    uint8 n;
    bytes32 b32;

    event Test(address indexed caller, uint256 indexed id, string indexed message);

    function callEvent(uint256 _id, string memory _message) public {
        emit Test(msg.sender, _id, _message);
    }
    function get_b32() public view returns(bytes32) {
        return b32;
    }
    function set_b32() public {
        b32 = bytes32(0x0);
    }
    function fuga(uint8 _n) public returns(uint8){
        require(_n < 10, 'Param must be less than 10');
        n = _n;
    }
    function dedede(uint8 _n) public returns(bool){
        n = _n;
        return true;
    }
    function getArray() public view returns(uint8[] memory) {
        return u8array;
    }
    function setArray(uint8 _n) public {
        u8array.push(_n);
    }
    function cancel1() public pure {
        require(1==2, "Error");
    }
    function cancel11() public pure {
        require(false, "Hoge");
    }
    function cancel2() public pure {
        require(1==2);
    }
    function cancel3() public pure {
        revert();
    }
}
