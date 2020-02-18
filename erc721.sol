contract ERC721 {
    struct Data {
        uint d1;
        address d2;
        string d3;
        bool d4;
    }

    Data[] datas;
    mapping (uint256 => address) internal idToOwner;
    mapping (uint256 => address) internal idToApprovals;
    mapping (address => uint256) internal ownerToNFTokenCount;
    mapping (address => mapping (address => bool)) internal ownerToOperators;

    function mint(uint p1,address p2,string p3,bool p4) external returns(uint){
        uint id = datas.push(Data({d1:p1,d2:p2,d3:p3,d4:p4})) - 1;
        idToOwner[id] = msg.sender;
        ownerToNFTokenCount[msg.sender] += 1;
        return id;
    }

    function balanceOf(address _owner) external view returns (uint256){
        return ownerToNFTokenCount[_owner];
    }
    function ownerOf(uint256 _tokenId) external view returns (address){
        return idToOwner[_tokenId];
    }
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes _data) external;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external;
    function transferFrom(address _from, address _to, uint256 _tokenId) external{
        ownerToNFTokenCount[_from]-=1;
        idToOwner[_tokenId] = _to;
        ownerToNFTokenCount[_to]+=1;
    }
    function approve(address _approved, uint256 _tokenId) external;
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}
