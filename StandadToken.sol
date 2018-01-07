pragma solidity ^0.4.0;

contract ERC20 {
  uint public totalSupply;
  
  event Transfer(address indexed from, address indexed to, uint value);
  event Approval(address indexed owner, address indexed spender, uint value);
  
  function balanceOf(address who) public constant returns (uint);
  
  function transfer(address to, uint value) public;
  
  function allowance(address owner, address spender) public constant returns (uint);

  function transferFrom(address from, address to, uint value) public;
  
  function approve(address spender, uint value) public;
}

contract StandardToken is ERC20 {
  string public constant name = "Token Name";
  string public constant symbol = "TKN";
  uint8 public constant decimals = 18; 

  mapping (address => mapping (address => uint)) allowed;
  mapping (address => uint) balances;
  
  function StandardToken() public {
    balances[msg.sender] = 1000000;
  }

  function transferFrom(address _from, address _to, uint _value) public {
    balances[_to] +=_value;
    balances[_from] -= _value;
    allowed[_from][msg.sender] -= _value;
    Transfer(_from, _to, _value);
  }

  function approve(address _spender, uint _value) public {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
  }

  function allowance(address _owner, address _spender) public constant returns (uint remaining) {
    return allowed[_owner][_spender];
  }

  function transfer(address _to, uint _value) public {
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    Transfer(msg.sender, _to, _value);
  }

  function balanceOf(address _owner) public constant returns (uint balance) {
    return balances[_owner];
  }
  
  function mint() payable external {
    if (msg.value == 0) revert();

    var numTokens = msg.value;
    totalSupply += numTokens;

    balances[msg.sender] += numTokens;

    Transfer(0, msg.sender, numTokens);
  }
}
