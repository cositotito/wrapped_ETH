
// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.1;

interface WethLike {
    function deposit() external payable;
    function withdraw(uint256) external;
    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    // function withdrawTo(address payable to) external;
    function balanceOf(address) external view returns (uint);
}

contract MyContract {
  WethLike weth;
  address tokenWETH= 0xd0A1E359811322d97991E03f863a0C30C2cF029C;
  constructor() {
    weth = WethLike(tokenWETH); // Kovan
    weth.approve(address(this),1000000000000000000000000);
    weth.approve(tokenWETH,1000000000000000000000000);
  }

  event Data(uint);
  function deposit(uint256 _amount) external payable {
    require(_amount==msg.value,"amount -1");
    emit Data(msg.value);
  }

  event DepositWETH(uint256);
  function depositWETH() external {   
    weth.deposit{ value: 1 }();
    emit DepositWETH(1);
  }

  event Transfer(uint);
  function transferWETH(uint _amountEth) public{
    weth.transfer(0xd0A1E359811322d97991E03f863a0C30C2cF029C,_amountEth);
    emit Transfer(1);
  }


  function balanceOfContract() public view returns(uint256){
    return weth.balanceOf(address(this));
  }

  function withdrawTo(address payable to) public payable  { 
    uint balance= weth.balanceOf(address(this));
    if (balance > 0) {
      weth.withdraw(balance);    
      (bool success,) = to.call{value: balance, gas:100000}("");
      require(success, "WITHDRAW_TO_CALL_FAILED");
    }    
  }
}
