pragma solidity 0.8.10;

contract MyContract {
    // --------constructor -------------
    address public owner;
    // parameters
    uint256 public v;

    // this is called when a contract is deployed
    constructor(uint256 test) {
        v = test;
        owner = msg.sender;
    }

    // ------------------------------------

    // pure function ------------------
    // what is a pure function?
    // function that doesn't access the contract and just performs some computations

    function add2(uint256 x) public pure returns (uint256) {
        return x + 2;
    }

    // ---------------------------------

    mapping(address => uint256) private balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(address payable addr, uint256 amount) public payable {
        //  balance shloude be greater that the amount
        require(balances[addr] >= amount, "Insufficient funds");
        (bool sent, bytes memory data) = addr.call{value: amount}("");
        //  otherwise subtract the balance
        require(sent, "could not withdraw");
        balances[msg.sender] -= amount;
    }

    function whatIsMyBalance() public view returns (uint256) {
        //-------------- exceptions --------------------
        // revert("error that will revert the state")
        // assert(true == true, "hello")

        return address(this).balance;
    }
}
