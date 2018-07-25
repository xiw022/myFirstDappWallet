contract SimpleWallet {
   address owner;
   mapping(address => bool) isAllowedToSendFundsMapping;

 function SimpleWallet() {
   owner = msg.sender;
 }
}
