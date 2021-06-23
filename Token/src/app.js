App = {
  contract: null,
  web3: null,


  init: function () {

    var web3Provider = new Web3.providers.HttpProvider('http://127.0.0.1:7545');
    App.web3 = new Web3(web3Provider);

    $.getJSON("../build/contracts/CarbonToken.json", function (data) {

      App.contract = TruffleContract(data);
      App.contract.setProvider(web3Provider);
    });

    return App.EventBind();
  },


  EventBind: function () {
    //CHANGEABLY ELEMENT(bind function to button)
    $("#SubmitAddress").click(App.GetAccountInfo);
    $("#NewAccount").click(App.NewAccount);
    $("#Transfer").click(App.TransferFrom);
  },


  GetAccountInfo: function () {
    //CHANGEABLY ELEMENT "#AddressInput"
    account = $("#AddressInput").val();

    App.contract.deployed().then(function (instance) {

      instance.symbol().then(sym => {
        instance.balanceOf(account).then(balance => {
          //CHANGEABLY ELEMENT "#Balance"
          $("#Balance").text(balance + "  " + sym);
        })
      });
    });
  },


  NewAccount: function () {

    //CHANGEABLY ELEMENT "#Passwd"
    let Passwd=$("#Passwd").val();

    let newAccount = App.web3.personal.newAccount();

    App.contract.deployed().then(instance => {

      instance.InitAccount(newAccount, Passwd,{ from: App.web3.eth.coinbase, gas: 100000 });
    });

    //CHANGEABLY ELEMENT "#NewAddress"
    $("#NewAddress").text(newAccount);
  },


  TransferFrom: function () {

    //CHANGEABLY ELEMENT "#FromInput"
    FromAddress = $("#FromInput").val();
    //CHANGEABLY ELEMENT "#ToInput"
    ToAddress = $("#ToInput").val();
    //CHANGEABLY ELEMENT "#AmountInput"
    Amount = $("#AmountInput").val();
   //CHANGEABLY ELEMENT "#Passwd2"
    Passwd=$("#Passwd2").val();

    App.contract.deployed().then(instance => {

      instance.CarbonTokenTransfer(FromAddress, Passwd,ToAddress, Amount, { from: App.web3.eth.coinbase, gas: 1000000}).then(function(res){
          alert("SUCCESSFUL TRANSACTIONI");
      }).catch(function(err){
          alert("TRANSACTION FAilED!\nPLEASE CHECK YOU INPUT!");
      });
      
    });
  }



}

$(function () {
  $(window).load(function () {
    App.init();
  });
});