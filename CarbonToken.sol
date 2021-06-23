pragma solidity ^0.4.24;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract CarbonToken is StandardToken{

    string public name='CarbonToken'; //Token name

    string public symbol='CO2'; //Token symbol

    uint public deciamls=2; //Divdied accuracy

    uint public INITIAL_SUPPLY=10000;

    //govern this token system,own all assets,initate client's accont
    address Controller_Address;

    uint Inital_Asset=100;

    //ocnstructor function
    constructor  (){
            totalSupply_=INITIAL_SUPPLY;
            balances[msg.sender]=INITIAL_SUPPLY;
            Controller_Address=msg.sender;
    }

    //initate asset of client's accont
    function InitAccount
    (address newaccount)
    public
    returns(bool)
    {
        return transferFrom(Controller_Address,newaccount,Inital_Asset);
    }

    //only controller can change the Inital_Asset value
    function ChanInitAsset
    (uint newvalue)
    public
    returns(bool)
    {
        require(msg.sender==Controller_Address);
        Inital_Asset=newvalue;
        return true;
    }

}