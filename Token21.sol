// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

contract Token21 is ERC20 {
    address public admin;
    mapping(address=> bool) isBlacklisted;
    
    constructor() ERC20('Token21','T21')
    {
        _mint(msg.sender, 10000 * 10 **18);   //just add 10000 token to admin for testing 
        admin = msg.sender;
    }
    
    function mint(address to, uint256 amount) external onlyAdmin()
    {
        require(isBlacklisted[to], "Recipiant is blacklisted");
        _mint(to, amount);
    
    }
    
    function burn( address account, uint256 amount) external onlyAdmin()
    {
        _burn(account, amount); 
    }
    
    //user is not allowed to do any thing with the token
    function blacklisted (address _user) external onlyAdmin()
    {
        require(!isBlacklisted[_user],"user is already blacklisted");
        isBlacklisted[_user] = true;  
    }
    
    //Remove someone 
    function removeFromBlacklist(address _user) external onlyAdmin(){
      require(isBlacklisted[_user],"use is already whitelisted");
      isBlacklisted[_user] = false;
    }
    modifier onlyAdmin() {
        require(msg.sender == admin, 'only admin');
        _;
    }
    
}