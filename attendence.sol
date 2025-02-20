pragma solidity ^0.8.0;

contract POAP {
    struct POAPToken {
        uint256 id;
        address attendee;
        string eventDetails;
    }

    uint256 private nextTokenId;
    address public organizer;
    mapping(uint256 => POAPToken) public poaps;
    mapping(address => uint256[]) public ownedPOAPs;

    event POAPIssued(address indexed attendee, uint256 tokenId, string eventDetails);

    modifier onlyOrganizer() {
        require(msg.sender == organizer, "Only organizer can issue POAPs");
        _;
    }

    constructor() {
        organizer = msg.sender;
        nextTokenId = 1;
    }

    function issuePOAP(address _attendee, string memory _eventDetails) public onlyOrganizer {
        uint256 tokenId = nextTokenId;
        poaps[tokenId] = POAPToken(tokenId, _attendee, _eventDetails);
        ownedPOAPs[_attendee].push(tokenId);

        emit POAPIssued(_attendee, tokenId, _eventDetails);
        nextTokenId++;
    }

    function getPOAPs(address _attendee) public view returns (uint256[] memory) {
        return ownedPOAPs[_attendee];
    }
}

