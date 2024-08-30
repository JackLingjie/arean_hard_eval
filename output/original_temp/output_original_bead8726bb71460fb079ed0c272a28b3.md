**1155 Smart Contract Logic for Creds Token**

### Overview

This contract implements the ERC-1155 standard for a Creds token. It allows for the creation, management, and transfer of tokens.

### Contract Structure

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/access/Ownable.sol";

contract CredsToken is ERC1155, Ownable {
    // Mapping of token IDs to their respective balances
    mapping(uint256 => mapping(address => uint256)) private _balances;

    // Mapping of token IDs to their respective total supplies
    mapping(uint256 => uint256) private _totalSupply;

    // Mapping of token IDs to their respective URI metadata
    mapping(uint256 => string) private _tokenURIs;

    // Event emitted when a token is minted
    event Mint(address indexed account, uint256 indexed tokenId, uint256 amount);

    // Event emitted when a token is burned
    event Burn(address indexed account, uint256 indexed tokenId, uint256 amount);

    // Event emitted when a token's URI metadata is updated
    event UpdateURI(uint256 indexed tokenId, string newURI);

    // Event emitted when a token's balance is updated
    event UpdateBalance(address indexed account, uint256 indexed tokenId, uint256 newBalance);

    // Constructor
    constructor() ERC1155("") {
        // Initialize the contract
    }

    // Function to mint a new token
    function mint(
        address _account,
        uint256 _tokenId,
        uint256 _amount
    ) public onlyOwner {
        // Check if the token ID already exists
        require(_totalSupply[_tokenId] == 0, "Token ID already exists");

        // Update the total supply
        _totalSupply[_tokenId] = _amount;

        // Update the balance
        _balances[_tokenId][_account] = _amount;

        // Emit the mint event
        emit Mint(_account, _tokenId, _amount);
    }

    // Function to burn a token
    function burn(
        address _account,
        uint256 _tokenId,
        uint256 _amount
    ) public {
        // Check if the account has a balance for the token
        require(_balances[_tokenId][_account] > 0, "Account has no balance for this token");

        // Update the balance
        _balances[_tokenId][_account] -= _amount;

        // Update the total supply
        _totalSupply[_tokenId] -= _amount;

        // Emit the burn event
        emit Burn(_account, _tokenId, _amount);
    }

    // Function to update a token's URI metadata
    function updateURI(
        uint256 _tokenId,
        string memory _newURI
    ) public onlyOwner {
        // Update the token's URI metadata
        _tokenURIs[_tokenId] = _newURI;

        // Emit the update URI event
        emit UpdateURI(_tokenId, _newURI);
    }

    // Function to get a token's balance
    function balanceOf(
        address _account,
        uint256 _tokenId
    ) public view returns (uint256) {
        // Return the account's balance for the token
        return _balances[_tokenId][_account];
    }

    // Function to get a token's total supply
    function totalSupply(
        uint256 _tokenId
    ) public view returns (uint256) {
        // Return the token's total supply
        return _totalSupply[_tokenId];
    }

    // Function to get a token's URI metadata
    function uri(
        uint256 _tokenId
    ) public view returns (string memory) {
        // Return the token's URI metadata
        return _tokenURIs[_tokenId];
    }
}
```

### Key Features

- **Minting**: Allows the contract owner to mint new tokens.
- **Burning**: Enables token holders to burn their tokens.
- **URI Updates**: Enables the contract owner to update the URI metadata for tokens.
- **Balance and Supply Management**: Manages token balances and total supplies.

### Usage

1. **Minting**:
   - Call the `mint` function with the account address, token ID, and amount to mint new tokens.

2. **Burning**:
   - Call the `burn` function with the account address, token ID, and amount to burn tokens.

3. **URI Updates**:
   - Call the `updateURI` function with the token ID and new URI to update the token's metadata.

4. **Balance and Supply Management**:
   - Use the `balanceOf` function to get a token's balance.
   - Use the `totalSupply` function to get a token's total supply.
   - Use the `uri` function to get a token's URI metadata.