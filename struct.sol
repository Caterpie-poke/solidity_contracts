
pragma solidity ^0.4.23;
contract Array {
    struct Struct {
        int elem1;
        string elem2;
        bool elem3;
        byte elem4;
    }

    mapping (address => Struct) public array1;
    mapping (uint => Struct) public array2;
    Struct[] public array3;
    //mapping (string => Struct) public array4; //string(=> byte[] => dynamically-sized)はキーにできない
    mapping (byte => Struct) public array5;

    string[] oldTOKIO = ["Joshima","Nagase","Yamaguchi","Matsuoka","Kokubun"];
    string[] newTOKIO;

    function reconstruction() public returns (string){
        for(uint i; i < oldTOKIO.length; i++){
            if(keccak256(oldTOKIO[i]) == keccak256("Yamaguchi")){
                return "Yamaguchi withdrew from TOKIO.";
            } else {
                newTOKIO.push(oldTOKIO[i]);
            }
        }
    }
}

contract Int {
    uint8 ui8;
    uint16 ui16;
    uint24 ui24;
    //uint8N(N = 1..32)
    uint256 ui256;//==> uint

    int8 i8;
    int256 i256;//==> int

    function intTest(uint _selector) public {

    }

    function retunAll() public view returns (address,uint,address,uint) {
        return (
            msg.sender,//contractを呼び出したaccountのアドレスを返す
            msg.value,//送金額を返す
            tx.origin,//account->contract1->contract2のようにコントラクトから呼ばれた場合、contract1のアドレスを返す
            now//ブロックのタイムスタンプを返す
            );
    }
}

contract STSTSTS {
    struct s0 {
        uint n;
        string name;
    }
    struct s1 {
        uint n;
        string name;
    }
    struct s2 {
        uint n;
        string name;
    }
    struct s3 {
        uint n;
        string name;
    }
    struct s4 {
        uint n;
        string name;
    }
    struct s5 {
        uint n;
        string name;
    }
    struct s6 {
        uint n;
        string name;
    }
    struct s7 {
        uint n;
        string name;
    }
    struct s8 {
        uint n;
        string name;
    }
    struct s9 {
        uint n;
        string name;
    }
    struct s10 {
        uint n;
        string name;
    }
    struct s11 {
        uint n;
        string name;
    }
    struct s12 {
        uint n;
        string name;
    }
    struct s13 {uint n;string name;}
    struct s14 {
        uint n;
        string name;
    }
    struct s15 {
        uint n;
        string name;
    }

    function hoge() public pure returns(uint){
        return 114514;
    }
}
