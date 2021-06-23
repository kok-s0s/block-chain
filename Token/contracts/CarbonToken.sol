pragma solidity ^0.4.24;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

contract CarbonToken is StandardToken{


    mapping(address=>string) Passwd;

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
            Passwd[msg.sender]="000000";
            Controller_Address=msg.sender;
    }

    //CarbonToken transfer function
    function CarbonTokenTransfer
    (address _from,string passwd,address _to,uint amount)
    public
    returns(bool)
    {
        require(keccak256(passwd)==keccak256(Passwd[_from]));
        require(balances[_from]>amount);
        require(amount>0);
        require(_from!=address(0));
        require(_to!=address(0));

        balances[_from]=balances[_from].sub(amount);
        balances[_to]=balances[_to].add(amount);

        return true;
    }

    //initate asset of client's accont
    function InitAccount
    (address newaccount,string passwd)
    public
    returns(bool)
    { 

        balances[newaccount]=0;
        Passwd[newaccount]=passwd;
        return CarbonTokenTransfer(Controller_Address,"000000",newaccount,Inital_Asset) ;
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