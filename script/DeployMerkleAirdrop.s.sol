// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {PizzaToken} from "../src/PizzaToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Script} from "forge-std/Script.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 s_amountToTransfer = 4 * (25 * 1e18);

    function deployMerkleAirdrop() public returns (MerkleAirdrop, PizzaToken) {
        vm.startBroadcast();
        PizzaToken pizzaToken = new PizzaToken();
        MerkleAirdrop airdrop = new MerkleAirdrop(s_merkleRoot, pizzaToken);
        pizzaToken.mint(pizzaToken.owner(), s_amountToTransfer);
        pizzaToken.transfer(address(airdrop), s_amountToTransfer);
        vm.stopBroadcast();
        return (airdrop, pizzaToken);
    }

    function run() public returns (MerkleAirdrop, PizzaToken) {
        return deployMerkleAirdrop();
    }
}
