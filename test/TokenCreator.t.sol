// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TMTokenCreator} from "../src/TokenCreator.sol";

contract CNZATest is Test {
    TMTokenCreator public tokenCreator;

    function setUp() public {
        vm.createSelectFork("https://api.avax.network/ext/bc/C/rpc");
        tokenCreator =
            new TMTokenCreator(0x501ee2D4AA611C906F785e10cC868e145183FCE4, 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7);
    }

    function test() public {
        tokenCreator.createToken{value: 2 ether}();
    }
}
