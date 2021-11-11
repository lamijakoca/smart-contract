const TrustFund = artifacts.require("./TrustFund.sol");

module.exports = function (deployer) {
  deployer.deploy(TrustFund);
};
