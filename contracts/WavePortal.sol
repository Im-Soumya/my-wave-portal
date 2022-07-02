//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 waveCount;
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("This is Wave Portal smart contract");
        
        seed = (block.difficulty + block.timestamp) % 100;
    }

    function wave(string memory _message) public {
        require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Wait 30 seconds");
        
        lastWavedAt[msg.sender] = block.timestamp;
        
        waveCount += 1;
        console.log("%s has waved saying %s.", msg.sender, _message);
        
        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random number generated: ", seed);
        if(seed < 50) {
            console.log("%s won", msg.sender);
        }

        uint256 prize = 0.0001 ether;
        require(prize <= address(this).balance, "Trying get more money than the contract has.");

        (bool success, ) = (msg.sender).call{value: prize}("");
        require(success, "Failed to withdraw money from the contract");
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Total waves: %d", waveCount);

        return waveCount;
    }
}