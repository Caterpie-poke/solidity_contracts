contract UnderflowManipulation {
    address public owner;
    uint256 public manipulateMe = 10;
    constructor() public {
        owner = msg.sender;
    }

    uint[] public bonusCodes;

    function pushBonusCode(uint code) public {
        bonusCodes.push(code);
    }

    function popBonusCode() public {
        require(bonusCodes.length >=0);  // this is a tautology
        bonusCodes.length--; // an underflow can be caused here
    }

    function search() public view returns(uint,bool) {
        for(uint i=0;i<bonusCodes.length;i++){
            if(bonusCodes[i]==10)return (i,true);
            if(i>10000)break;
        }
        return (0,false);
    }
    function getLength() public view returns(uint) {
        return bonusCodes.length;
    }

    function modifyBonusCode(uint index, uint update) public {
        require(index < bonusCodes.length);
        bonusCodes[index] = update; // write to any index less than bonusCodes.length
    }

}
