pragma solidity ^0.5.0;

import "./payment/PaymentProcessor.sol";
import "./payment/Balance.sol";
import "./terms/IPaymentTerms.sol";
import "./accounts/IAuthorizedTokenTransferer.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract StandardSubscription is PaymentProcessor {
    
    using SafeMath for uint;

    Balance private _debt;
    IPaymentTerms private _paymentTerms;

    event SubscriptionEnded(address endedBy);

    constructor (
        address payor,
        address payee,
        IAuthorizedTokenTransferer authorizedTransferer,
        address token,
        IPaymentTerms paymentTerms
    ) 
        PaymentProcessor(payor, payee, authorizedTransferer, token)
        public 
    {
        _debt = new Balance();
        _paymentTerms = paymentTerms;
    }

    function payCurrentAmountDue() public {
        uint newAmountDue = _paymentTerms.currentAmountDue();
        uint totalAmountDue = newAmountDue.add(_debt.get());
        (, uint remainder) = pay(totalAmountDue);

        _debt.set(remainder);

        _paymentTerms.markAsPaid(newAmountDue);
    }

    function endSubscription() public {
        require(getPayor() == msg.sender || getPayee() == msg.sender);
        emit SubscriptionEnded(msg.sender);
    }

}