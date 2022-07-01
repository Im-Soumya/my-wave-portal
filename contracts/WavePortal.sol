//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 waveCount;

    constructor() {
        console.log("This is Wave Portal smart contract");
    }

    function wave() public {
        waveCount += 1;
        console.log("%s has waved.", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Total waves: %d", waveCount);
        return waveCount;
    }
}