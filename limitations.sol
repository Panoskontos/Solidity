pragma solidity 0.8.10;

contract Tutorial {
    // ! Avoid using arrays instead use mappings
    // Cost a lot of gas
    //------------------- Arrays------------
    // dynamic array
    uint256[] public arr;

    // static size array
    uint256[5] public arr2;

    // initialise static array
    function modArr2(uint256 val, uint256 idx) public {
        arr2[idx] = val;
    }

    // initialise dynamic array
    function modArr(uint256 val) public {
        arr.push(val);
    }

    // arr length
    function getLength() external view returns (uint256) {
        return arr.length;
    }

    //----------------- Strings -------------

    // Avoid Them!
    // The more data you store the more eth you will pay
    // try to store the least data
    string public hello = "world";

    // parameter must be stored in memory
    function setString(string memory val) public {
        hello = val;
    }

    //--------------- Loops -------------
    // Very expensive if not in Pure function
    function forloop(uint256 n) public pure {
        uint256 sum = 0;
        for (uint256 i; i < n; i++) {
            sum += i;
        }
    }

    function whileloop(uint256 n) public pure {
        uint256 sum = 0;
        uint256 i = 0;
        while (i < n) {
            sum += i;
            i++;
        }
    }

    // ----------  Gas Estimation on Network-------------
    // Really Pricy functions
    string[] arr;

    function createArr(uint256 n, string memory val) public {
        for (uint256 i; i < n; i++) {
            arr.push(val);
        }
    }

    uint256 public x = 0;

    function setX(uint256 val) public {
        x = val;
        // multiplication = really pricy
        x = val * 10;
    }
}

// Structs
// Structs are cheaper and a better practice than a seperate contract
struct Person {
    uint256 age;
    string name;
    uint256 balance;
}

contract MyTutorial {
    mapping(address => Person) people;

    function CreatePrson(uint256 age, string memory name) public {
        Person memory p;
        p.age = age;
        p.name = name;
        people[msg.sender] = p;
    }
}
