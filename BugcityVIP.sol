// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@kaiachain/contracts/KIP/token/KIP17/KIP17.sol";
import "@kaiachain/contracts/utils/Counters.sol";
import "@kaiachain/contracts/access/Ownable.sol";

contract BugcityVIP is KIP17, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string private _baseTokenURI;

    event BaseURIChanged(string newBaseURI);
    event TokenMinted(address to, uint256 tokenId);

    constructor() KIP17("Bugcity VIP", "VIP") {
        _baseTokenURI = "https://api.ssunibug.com/vip/";
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        require(bytes(baseURI).length > 0, "Base URI cannot be empty");
        _baseTokenURI = baseURI;
        emit BaseURIChanged(baseURI);
    }
    function getBaseURI() public view returns (string memory) {
        return _baseTokenURI;
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }

    function mint(address to) public onlyOwner {
        require(to != address(0), "Cannot mint to the zero address");
        uint256 newTokenId = _tokenIds.current();
        _safeMint(to, newTokenId);
        _tokenIds.increment();
        emit TokenMinted(to, newTokenId);
    }
}