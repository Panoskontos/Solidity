// Adding license Identifier avoiding legal problems
// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

contract SimpleStorage {
    // variables

    uint256 public favnum;

    bool public ispositive = true;

    string public name = "panos";

    address public id = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // 4 function types
    // external, public, internal, private

    // whenever you call a function that makes a change
    //  you make a transaction (gas)
    function store(uint256 _favnum) public {
        favnum = _favnum;
    }

    // view, pure functions
    //  don't make transcations (no gas)
    function retrivenum() public view returns (uint256) {
        return favnum;
    }

    // structs
    struct Anime {
        uint256 episodes;
        string name;
    }

    Anime public anime = Anime({episodes: 12, name: "Jojo"});

    // array of animes
    Anime[] public favanimes;

    // initialise dynamic array
    function addAnime(string memory _name, uint256 _episodes) public {
        favanimes.push(Anime(_episodes, _name));
        nameAnimeEpisodes[_name] = _episodes;
    }

    // Dictionaries
    // In sol they are called mapping
    mapping(string => uint256) public nameAnimeEpisodes;
}
