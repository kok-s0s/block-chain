const CarbonToken = artifacts.require("CarbonToken");

module.exports = function (deployer) {
  deployer.deploy(CarbonToken);
};
