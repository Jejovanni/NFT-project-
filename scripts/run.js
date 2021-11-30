const { hexStripZeros } = require("@ethersproject/bytes")

const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MyDevNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
    //call function and wait till mined.
    let txn = await nftContract.makeADevNFT()
    await txn.wait()
    txn = await nftContract.makeADevNFT()
    await txn.wait()
};

const runMain = async () => {
    try{
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
    process.exit(1);
}
};
runMain();