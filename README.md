# Merkle Tree Proof Generator

## Description

This web application generates Merkle proofs for wallet addresses using a Merkle tree. It takes a list of predefined wallet addresses, hashes them, and organizes them into a Merkle tree structure. Users can input a wallet address, and the application will generate a proof to validate that the address is part of the whitelist.

## Features

- **Merkle Tree Construction**: Wallet addresses are hashed using the `keccak256` function and organized into a Merkle tree.
- **Merkle Proof Generation**: For any given wallet address, the application generates a Merkle proof, which is a series of hashes that prove the address is part of the tree.
- **Proof Display**: Displays the Merkle proof, root, and leaf information for the given address.

## What is a Merkle Tree?

A **Merkle tree** is a binary tree structure used to efficiently and securely verify the integrity of data. In this case, we are verifying wallet addresses using Merkle trees. The tree is constructed as follows:

1. **Leaves**: Each wallet address is hashed using the `keccak256` hashing function. These hashed addresses form the leaves of the tree.
2. **Nodes**: Internal nodes represent the hash of the concatenation of their child nodes. This ensures that each node is a cryptographic representation of its children.
3. **Root**: The Merkle root is the final hash of the entire tree and serves as the fingerprint for the entire set of wallet addresses. It can be used to verify that the tree hasn't been tampered with.

## Code Explanation

### 1. Hashing Wallet Addresses

We start by hashing the list of wallet addresses using the `keccak256` hashing function. This is done to create the leaves of the Merkle tree.

```javascript
const leaves = addresses.map((x) => keccak256(x)); // Mapping each address to its hashed value



// Create a Merkle tree using the leaves (hashed wallet addresses) with the keccak256 hash function
// The `sortPairs: true` option sorts the pairs of leaves in the tree for consistency and deterministic hash computation
const tree = new MerkleTree(leaves, keccak256, { sortPairs: true }); // Create the Merkle tree

// Helper function to convert a buffer (binary data) into a hex string with '0x' prefix
const buff2hex = (x) => "0x" + x.toString("hex"); // Convert buffer to hex and add '0x' prefix

const leaf = keccak256(input); // Hash the input address (leaf of the Merkle tree)

// Get the Merkle proof for the leaf (the path that proves the address is part of the Merkle tree)
// The proof is the series of hashes that demonstrate the leaf's inclusion in the tree
const proof = tree.getProof(leaf).map((x) => buff2hex(x.data)); // Get Merkle proof and convert to hex format
```
