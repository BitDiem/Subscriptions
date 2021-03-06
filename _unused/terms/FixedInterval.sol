/*pragma solidity ^0.5.0;

import "../payment/PaymentObligation.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

/// key difference in how this works vs. fixed date - will pay out all elapsed intervals, not just first
contract FixedInterval is PaymentObligation {

    using SafeMath for uint;

    uint private _amount;
    uint private _timeInterval;             // interval as unix seconds
    uint private _lastIntervalTime;         // last interval timestamp
    uint private _outstandingIntervals;

    event RecurringPaymentsElapsed(
        uint totalOutstandingAmount, 
        uint totalOutstandingIntervals, 
        uint lastIntervalTime
    );

    constructor(
        uint amount, 
        uint timeInterval, // as measured in seconds between intervals
        uint delay // use case: "first 30 days free"
    )
        public
    {
        _amount = amount;
        _timeInterval = timeInterval;
        _lastIntervalTime = _getCurrentTimeInUnixSeconds().add(delay);
    }

    function _calculateOutstandingAmount() internal returns (uint) {
        uint currentTime = _getCurrentTimeInUnixSeconds();
        uint elapsedTime = currentTime - _lastIntervalTime;
        uint div = elapsedTime / _timeInterval;

        if (div == 0)
            return 0;

        uint mod = elapsedTime % _timeInterval;
        uint paymentAmount = _amount * div;

        _lastIntervalTime = currentTime - mod;
        _outstandingIntervals = _outstandingIntervals + div;
        uint outstandingAmount = paymentAmount;

        emit RecurringPaymentsElapsed(
            outstandingAmount, 
            _outstandingIntervals, 
            _lastIntervalTime
        );

        return outstandingAmount;
    }

    /// Wrap the call and make it internal - makes it easy to create a derived mock class
    function _getCurrentTimeInUnixSeconds() internal view returns (uint) {
        return now;
    }

}*/


pragma solidity ^0.5.0;

import "../terms/Seconds.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

/// key difference in how this works vs. fixed date - will pay out all elapsed intervals, not just first
contract FixedInterval is Seconds {

    using SafeMath for uint;

    constructor(
        uint amount, 
        uint timeInterval, // as measured in seconds between intervals
        uint delay // use case: "first 30 days free"
    )
        Seconds(amount, _getCurrentTimeInUnixSeconds().add(delay).add(timeInterval), timeInterval)
        public
    {        
    }

}
