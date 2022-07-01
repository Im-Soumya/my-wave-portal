const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    
    console.log("Contract address to: ", waveContract.address);
    console.log("Contract deployed by: ", owner.address);

    let totalWaves;
    totalWaves = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave();
    await waveTxn.wait();

    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();

    totalWaves = await waveContract.getTotalWaves();
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch(e) {
        console.log(e.message);
        process.exit(1);
    }
};

runMain();


