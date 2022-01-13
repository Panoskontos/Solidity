// which complier to use
pragma solidity 0.8.10;

// what is JavascriptVM enviroment?
// is a VM that simulates ethereum in your browser so you can test it

// if you have your code as a smart contract
// you can fully and transparently see the code which can never be changed

contract TestContract {
    // defining and setting variables
    uint256 public x = 22;

    function setx(uint256 _x) public {
        x = _x;
    }

    //map key with values like dictionary
    mapping(uint256 => int256) public map;

    // map[1] = -2

    function setkey(uint256 key, int256 value) public {
        map[key] = value;
    }

    // store an ethereum account address
    address public lastSender;

    // functions that can receive money
    function receive() external payable {
        // saves the account that sent the eth
        lastSender = msg.sender;
        // lastValue = msg.value;
        // lastgas = msg.gas;
    }

    // function to see how much ether is in this account
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // function that can send money
    function pay(address payable addr) public payable {
        // DON'T USE addr.transfer(), addr.send()
        // USE the following
        (bool sent, bytes memory data) = addr.call{value: 1 ether}("");
        require(sent, "Error sending eth");
    }
}

// contract that acts like an ATM
contract ATM {
    // because is private i can't get the value
    mapping(address => uint256) private balances;

    // funtion to deposit eth
    // even if variable msg.sender doesn't exist it is going to have a 0 value when i access it
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(address payable addr, uint256 amount) public payable {
        //  balance shloude be greater that the amount
        require(balances[addr] >= amount, "Insufficient funds");
        (bool sent, bytes memory data) = addr.call{value: amount}("");
        require(sent, "could not withdraw");
        //  otherwise subtract the balance
        balances[msg.sender] -= amount;
    }

    // function to see how much ether is in this account
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
