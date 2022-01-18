// ----------------
// Factory pattern
// ------------------
// Adding license Identifier avoiding legal problems
// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

// this is like copypastting it above
import "./lesson1.sol";

contract FactoryPattern {
    // put contracts to array of contracts
    SimpleStorage[] public simplestoragearray;

    // create new contract from new.sol
    function createsimplestoragecontract() public {
        SimpleStorage simplestorage = new SimpleStorage();
        simplestoragearray.push(simplestorage);
    }

    // call functions from the contracts
    function storefuntionfromStorestorage(uint256 _ssindex, uint256 _ssnumber)
        public
    {
        // We need 2 things
        // Address
        SimpleStorage ss = SimpleStorage(address(simplestoragearray[_ssindex]));
        // ABI
        ss.store(_ssnumber);
    }

    // retrive values from other contact
    function storefunctionget(uint256 _ssindex) public view returns (uint256) {
        SimpleStorage ss = SimpleStorage(address(simplestoragearray[_ssindex]));
        return ss.retrivenum();
    }
}

// Cotracts Inheritance
contract Child is SimpleStorage {
    // Now it will have all functions from simple storage
    // when deployed
}
