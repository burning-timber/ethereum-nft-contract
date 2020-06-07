pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BtNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(uint256 => uint24) private _tokenTypes;
    
    constructor() ERC721("Burning Timber", "BTNFT") public {
        _setBaseURI('https://token.burningtimber.com/api/eth/btnft/'); 
    }

    function mint(address rcpt, uint24 tokenType) public onlyOwner returns (uint256) {
        _tokenIds.increment();
        
        uint256 newTokenId = _tokenIds.current();
        _mint(rcpt, newTokenId);
        _setType(newTokenId, tokenType);
    }

    function _setType(uint256 tokenId, uint24 tokenType) private {
        require(_exists(tokenId), "Type set of nonexistent token");
        require(tokenType > 0, "Type attribute must be non-zero");
        require(_tokenTypes[tokenId] == 0, "Type attribute cannot be changed once set");
        _tokenTypes[tokenId] = tokenType;
    }

    function tokenType(uint256 tokenId) public view returns (uint32) {
        return _tokenTypes[tokenId];
    }

}
