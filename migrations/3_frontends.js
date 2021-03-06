var SubscriptionFactory = artifacts.require("SubscriptionFactory");
var MonthlyTermsFactory = artifacts.require("MonthlyTermsFactory");
var MonthsTermsFactory = artifacts.require("MonthsTermsFactory");
var YearlyTermsFactory = artifacts.require("YearlyTermsFactory");
var SecondsTermsFactory = artifacts.require("SecondsTermsFactory");
var SubscriptionFrontEnd = artifacts.require("SubscriptionFrontEnd");
var PublisherFrontEnd = artifacts.require("PublisherFrontEnd");

module.exports = function(deployer) {

  // link deployed libraries to the two frontends
  deployer.link(SubscriptionFactory, [SubscriptionFrontEnd, PublisherFrontEnd]);
  deployer.link(MonthlyTermsFactory, [SubscriptionFrontEnd, PublisherFrontEnd]);
  deployer.link(MonthsTermsFactory, [SubscriptionFrontEnd, PublisherFrontEnd]);
  deployer.link(YearlyTermsFactory, [SubscriptionFrontEnd, PublisherFrontEnd]);
  deployer.link(SecondsTermsFactory, [SubscriptionFrontEnd, PublisherFrontEnd]);

  deployer.deploy(PublisherFrontEnd);

};
