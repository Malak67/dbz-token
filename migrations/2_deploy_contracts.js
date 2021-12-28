const DBZToken = artifacts.require("DBZToken");

module.exports = function (deployer) {
  deployer.deploy(DBZToken, 1000000);
};
