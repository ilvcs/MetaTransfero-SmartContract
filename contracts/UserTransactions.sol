// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract UserTransactions {
  uint256 transactionCount;

  event Transfer(address from, address to, uint amount, string senderName, string message, uint256 timestamp );

  struct TransferStruct{
    address from; 
    address to; 
    uint amount; 
    string senderName; 
    string message; 
    uint256 timestamp;
  }
  TransferStruct [] transactions;



  function sendTransaction( address payable _to, uint256 _amount,  string memory _senderName, string memory _message) public payable {
    require( _amount > 0, 'Not enough ETH sent');
    
    transactionCount += 1;
    transactions.push(TransferStruct(msg.sender, _to, msg.value, _senderName, _message, block.timestamp));
    emit Transfer(msg.sender, _to, msg.value, _senderName, _message, block.timestamp);
  }

  function getUserTransactions() public view returns(TransferStruct[] memory){
    uint userTransactionsCount = 0;
    uint currentIndex = 0;
    for(uint i = 0; i < transactionCount; i++){
      if(transactions[i].from == msg.sender){
        userTransactionsCount += 1;
      }
    }
    TransferStruct [] memory userTransactions = new TransferStruct [](userTransactionsCount);

    for(uint i = 0; i < transactionCount; i++){
      if(transactions[i].from == msg.sender){
       TransferStruct storage currentTransaction = transactions[i];
        userTransactions[currentIndex] = currentTransaction;
        currentIndex += 1;
      }
    }

    return userTransactions;

  }
}