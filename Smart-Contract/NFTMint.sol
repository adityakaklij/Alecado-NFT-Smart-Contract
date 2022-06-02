// SPDX-License-Identifier: MIT

pragma solidity ^0.8.5;


// Importing Openzeppline contracts
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMint is ERC721Enumerable, Ownable {
  
  using Strings for uint256;

  string baseURI;
  string public baseExtension = ".json";
  uint256 public cost = 0.00 ether;  // Mint Cost for NFT
  uint256 public maxSupply = 50;     // Total Supply of NFT
  uint256 public maxMintAmount = 1;  // Max mint per transaction
  bool public paused = false;


  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI
  ) ERC721(_name, _symbol) {
    setBaseURI(_initBaseURI);
  }


  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

 // Mint function

  function mint() public payable {

    uint256 supply = totalSupply();
    require(!paused);
    require(supply + 1 <= maxSupply);

    if (msg.sender != owner()) {
      require(msg.value >= cost );
    }
    _safeMint(msg.sender, supply + 1);
    
  }

  function walletOfOwner(address _owner) public view returns (uint256[] memory) {

    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    require( _exists(tokenId), "Token Not yet Minted");
    
    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

// Function to set new cost
  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }

  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }

// To pause the function.
  function pause(bool _state) public onlyOwner {
    paused = _state;
  }
 
  function withdraw() public payable onlyOwner {
   
    (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
  }
}
