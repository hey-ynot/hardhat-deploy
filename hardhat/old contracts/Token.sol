// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;

  //add minter changed event
  event MinterChanged(address indexed from, address to);

  constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
    minter = msg.sender;
  }

  function passMinterRole(address dBank) public returns (bool) {
      require(msg.sender==minter, 'Error, only owner can change pass minter role');
      minter = dBank;

      emit MinterChanged(msg.sender, dBank);
      return true;
  }

  //Add pass minter role function

  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
        require(msg.sender == minter, "Error, Minter =/= sender.");
		_mint(account, amount);
	}
}
