contract SimpleWallet {
   address owner;
   mapping(address => bool) isAllowedToSendFundsMapping;

   event Deposit(address _sender, uint amount);
   event Withdrawl(address _sender, uint amount, address _beneficiary);


   struct WithdrawlStruct {
       address to;
       uint amount;
   }

   struct Senders {
       bool allowed;
       uint amount_sends;
       mapping(uint => WithdrawlStruct) withdrawls;
   }


   function SimpleWallet() {
     owner = msg.sender;
   }

   function() {
     if(isAllowedToSend(msg.sender)) {
       Deposit(msg.sender, msg.value);
     }
     else {
       throw;
     }
    }


    function sendFunds(uint amount, address receiver) returns (uint) {
      if(isAllowedToSend(msg.sender)) {
        if(this.balance >= amount) {
          if(!receiver.send(amount)) {
            throw;
          }
          Withdrawl(msg.sender, amount, receiver);
          return this.balance;
        }
      }
    }

    function allowAddressToSendMoney(address _address) {
      if(msg.sender == owner) {
          isAllowedToSendFundsMapping[_address].allowed = true;
      }
    }

    function disAllowAddressToSendMoney(address _address) {
      if(msg.sender == owner) {
          isAllowedToSendFundsMapping[_address].allowed = false;
      }
    }

    function isAllowedToSend(address _address) constant returns (bool) {
        return isAllowedToSendFundsMapping[_address] || _address== owner;
    }

    function killWallet() {
        if(msg.sender == owner) {
            suicide(owner);
        }
    }
}
