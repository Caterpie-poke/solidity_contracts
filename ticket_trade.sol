pragma solidity ^0.4.23;
contract Accounts {
    uint accountId;
    struct Account {
        address addr;
        uint balance;
    }
    mapping(uint => Account) accounts;

    function createAccount(address _addr)public returns(uint) {
        accountId += 1;
        accounts[accountId].addr = _addr;
        accounts[accountId].balance = 0;
        return accountId;
    }

    function deposit(uint _fromAccId, uint _cash)public returns(bool) {
        if(accounts[_fromAccId].addr != msg.sender)
            return false;
        accounts[_fromAccId].balance = accounts[_fromAccId].balance + _cash;
            return true;
    }

    function getAccountInfo(uint _id)public constant returns(address, uint) {
        return (
            accounts[_id].addr,
            accounts[_id].balance
            );
    }

    function payment(uint _fromAccId, uint _toAccId, uint _money)public returns (bool, string) {
        if(accounts[_fromAccId].balance < _money)
            return (false, "Balance short!");
        if(accounts[_fromAccId].addr != msg.sender)
            return (false, "Id false");
        accounts[_fromAccId].balance -= _money;
        accounts[_toAccId].balance += _money;
        return (true, "success!");
    }
}

contract Tickets {
    uint ticketId;
    Accounts acc;
    struct Ticket{
        string ticketName;
        uint price;
        uint issuedAmount;
        uint salesCount;
    }
    mapping(uint => Ticket) tickets;
    constructor (address _addr) public {
        acc = Accounts(_addr);
    }

    function issueTicket(string _ticketName, uint _price,uint _issuedAmount)public returns(uint) {
        ticketId += 1;
        tickets[ticketId] = Ticket(_ticketName, _price, _issuedAmount, 0);
        return ticketId;
    }

    function getTicketInfo(uint _ticketId) public constant returns(string, uint, uint, uint) {
        return (
            tickets[_ticketId].ticketName,
            tickets[_ticketId].price,
            tickets[_ticketId].issuedAmount,
            tickets[_ticketId].salesCount
            );
    }

    function getCurrentTicketId()public constant returns(uint) {
        return ticketId;
    }

    function buyTicket(uint _ticketId, uint _buyerAccId, uint _sellerAccId, uint _money)
    public returns(bool,string) {
        if(tickets[_ticketId].salesCount >= tickets[_ticketId].issuedAmount)
            return (false,"Sold Out");
        var (check, message) = acc.payment(_buyerAccId, _sellerAccId, _money);
        if(!check)
            return (false,message);
        tickets[_ticketId].salesCount += 1;
            return (true,"success");
    }

}
