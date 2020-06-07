const BtNFT = artifacts.require("BtNFT");

module.exports = function(deployer) {
  deployer.deploy(BtNFT);
};
