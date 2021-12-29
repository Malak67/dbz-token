// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "./DBZToken.sol";

contract DBZTokenSale {
    address admin;
    DBZToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);
    event EndSale(uint256 _totalAmountSold);

    constructor(DBZToken _tokenContract, uint256 _tokenPrice) {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function multiply(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == multiply(_numberOfTokens, tokenPrice), 'msg.value must equal number of tokens in wei');
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens, 'cannot purchase more tokens than available');
        require(tokenContract.transfer(msg.sender, _numberOfTokens), 'Unable to send tokens');

        tokensSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == admin);
        require(
            tokenContract.transfer(
                admin,
                tokenContract.balanceOf(address(this))
            )
        );

        // UPDATE: Let's not destroy the contract here
        // Just transfer the balance to the admin
        payable(admin).transfer(address(this).balance);
        
        emit EndSale(tokensSold);
    }
}
