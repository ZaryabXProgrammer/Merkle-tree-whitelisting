// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MyToken is ERC721, Ownable {
    uint256 private _nextTokenId;
    bytes32 public root;

    constructor(bytes32 _root) ERC721("MyToken", "MTK") Ownable(msg.sender) {
        root = _root;
    }

    function safeMint(
        address to,
        bytes32[] memory proof
       
    ) public returns (uint256) {
       

        require(isValid(proof, keccak256(abi.encodePacked(msg.sender))), "Not A part of allow list");
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        return tokenId;
    }

    function isValid(bytes32[] memory proof, bytes32 leaf)
        public
        view
        returns (bool)
    {
        return MerkleProof.verify(proof, root, leaf);
    }

    function setRoot(bytes32 _newRoot) external onlyOwner {
    root = _newRoot;
}

}
