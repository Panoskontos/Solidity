pragma solidity 0.8.10;

// -----------------NFT------------------
interface IERC721 {
    // Take an NFT ID and tranfer it to a specific addr
    function transfer(address, uint256) external;

    // tranfer from 1 addr to another addr
    function transferFrom(
        address,
        address,
        uint256
    ) external;
}

// --------------------------------

// solidity auction that connects with accounts and bids NFTs
contract Auction {
    // create events
    event Start();
    event End(address highestBidder, uint256 highestBid);
    event Bid(address indexed sender, uint256 amount);
    event Withdraw(address indexed bidder, uint256 amount);

    address payable public seller;

    bool public started;
    bool public ended;
    uint256 public endAt;
    uint256 public highestBid;
    address public highestBidder;
    mapping(address => uint256) public bids;

    // incorporate NFT code-----
    IERC721 public nft;
    // unique id of the nft
    uint256 public nftId;

    // ----------------

    constructor() {
        seller = payable(msg.sender);
    }

    function start(
        IERC721 _nft,
        uint256 _nftId,
        uint256 startingBid
    ) external {
        require(!started, "already started");
        require(msg.sender == seller, "You did not start");
        started = true;
        // relative timestamp of auction
        endAt = block.timestamp + 2 days;
        highestBid = startingBid;

        // set the NFT
        nft = _nft;
        nftId = _nftId;
        // tranfer from NFT to Contract
        nft.transferFrom(msg.sender, address(this), nftId);

        // start event
        emit Start();
    }

    function bid() external payable {
        require(started, "you need to start first");
        require(block.timestamp < endAt, "Auction ended");
        require(msg.value > highestBid);

        // address(0) = default address = 000000000000000
        //  as soon as they bid allow to withdraw so they can bid again
        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;
        emit Bid(highestBidder, highestBid);
    }

    function withdraw() external payable {
        uint256 balance = bids[msg.sender];
        bids[msg.sender] = 0;
        // sent to account
        (bool sent, bytes memory data) = payable(msg.sender).call{
            value: balance
        }("");
        require(sent, "could not withdraw");
        emit Withdraw(msg.sender, balance);
    }

    function end() external {
        require(started, "you need to start first");
        require(block.timestamp >= endAt, "Auction is still ongoing");
        require(!ended, "Auction already ended");

        // whoever has the highest bid wins the auction & gets the nft
        if (highestBidder != address(0)) {
            nft.transfer(highestBidder, nftId);
            // send nft
            (bool sent, bytes memory data) = seller.call{value: highestBid}("");
            require(sent, "could not sent");
        } else {
            // return nft to us
            nft.transfer(seller, nftId);
        }

        ended = true;
        emit End(highestBidder, highestBid);
    }
}
