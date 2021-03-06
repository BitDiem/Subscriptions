pragma solidity ^0.5.0;

import "../../accounts/AuthorizedTokenTransferer.sol";
import "../../recurrence/subscription/StandardSubscription.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

/**
 * @title SubscriptionFactory
 * @dev External library for creating an instance of StandardSubscription.sol.
 */
library SubscriptionFactory {

    function create(
        address payor,
        address payee,
        IAuthorizedTokenTransferer authorizedTransferer,
        IERC20 paymentToken,
        PaymentObligation paymentTerms
    ) 
        external
        returns (StandardSubscription)
    {
        return new StandardSubscription(
            payor,
            payee,
            authorizedTransferer, 
            paymentToken, 
            paymentTerms
        );
    }

}