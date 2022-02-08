pragma solidity >=0.6.0;

interface WethLike {
    function deposit() external payable;
    function withdraw(uint256) external;
    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract MyContract {
  WethLike weth;
  address tokenWETH= 0xd0A1E359811322d97991E03f863a0C30C2cF029C;
  constructor() public{
    weth = WethLike(tokenWETH); // Kovan
    weth.approve(address(this),1000000000000000000000000);
     weth.approve(tokenWETH,1000000000000000000000000);
  }

  event Data(uint);
  function deposit(uint256 _amount) external payable {
    require(_amount==msg.value,"amount -1");
    emit Data(msg.value);

  }

  event DepositETH(uint256);
  function depositWETH() external payable {
   
    weth.deposit{ value: 1 }();
    emit DepositETH(1);
  }

  function withdraw(uint256 _amount) public { 
    weth.withdraw(_amount);    
  }
}
