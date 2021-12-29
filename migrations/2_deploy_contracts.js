const DBZToken = artifacts.require("DBZToken");
const DBZTokenSale = artifacts.require("DBZTokenSale");

module.exports = (deployer) => {
  deployer.deploy(DBZToken, 1000000).then(() => {
    // Token price is 0.001 Ether
    const tokenPrice = 1000000000000000;
    return deployer.deploy(DBZTokenSale, DBZToken.address, tokenPrice);
  });
};
