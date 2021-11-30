// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
//util functions for strings.
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
// inherit imported contract with access to contract's methods.
contract MyDevNFT is ERC721URIStorage {
    // keep track of tokensIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    //svg code, only need to change word displayed.
    //create baseSvg variable that NFTs can use.
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    
    //three arrays, each with random words
    string[] firstWords = ["Great", "Fearsome", "Sexy", "Naked", "Unbeatable", "Unfuckwittable", "Troublesome", "Indomitable"];
    string[] secondWords = ["Spaghetti", "Cookie", "Spice", "Sugar", "Cinnamon", "Ginger", "Coke", "Chocolate"];
    string[] thirdWords = ["Mafia", "Army", "Militia", "Junta", "Squadron", "DeathSquad", "Gang", "Cult"];
    
    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("gm, this is my first NFT contract. WATMG, wgmi");
    }
    //a function to randomly pick words from arrays
    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
    // seed random generator. 
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    // Squash the # between 0 and the length of the array to avoid going out of bounds.
    rand = rand % firstWords.length;
    return firstWords[rand];
  }
  
  function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % secondWords.length;
    return secondWords[rand];
  }

  function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % thirdWords.length;
    return thirdWords[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }
    function makeADevNFT() public {
        uint256 newItemId = _tokenIds.current();

         // We go and randomly grab one word from each of the three arrays.
    string memory first = pickRandomFirstWord(newItemId);
    string memory second = pickRandomSecondWord(newItemId);
    string memory third = pickRandomThirdWord(newItemId);

        // concatenate strings, and then close the <text> and <svg> tags.
    string memory finalSvg = string(abi.encodePacked(baseSvg, first, second, third, "</text></svg>"));
    console.log("\n--------------------");
    console.log(finalSvg);
    console.log("--------------------\n");
    
    _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, "blah");
        //different tokenIds identifier each time an NFT is minted.
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }
}