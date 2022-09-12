// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "./LamportLib.sol";

contract LamportTest {
    event Message(string message);

    bool initialized = false;
    bytes32[2][256] publicKey;
    address tipjar;

    function getPublicKey() public view returns (bytes32[2][256] memory) {
        return publicKey;
    }

    function getTipJar() public view returns (address) {
        return tipjar;
    }

    function init(bytes32[2][256] memory firstPublicKey) public {
        require(!initialized, "Already initialized");
        publicKey = firstPublicKey;
        tipjar = msg.sender;
        initialized = true;
    }

    function change_tip_jar(
        address newTipJar,
        bytes32[2][256] memory nextpub,
        bytes[256] memory sig
    ) public {
        require(initialized, "LamportTest not initialized");
        require(
            LamportLib.verify_u256(
                uint256(keccak256(abi.encodePacked(newTipJar, nextpub))),
                sig,
                publicKey
            ),
            "Lamport Signature not valid"
        );
        tipjar = newTipJar;
        publicKey = nextpub;
    }

    function broadcast(
        string memory messageToBroadcast,
        bytes32[2][256] memory nextpub,
        bytes[256] memory sig
    ) public {
        require(initialized, "LamportTest not initialized");
        require(
            LamportLib.verify_u256(
                uint256(
                    keccak256(abi.encodePacked(messageToBroadcast, nextpub))
                ),
                sig,
                publicKey
            ),
            "Lamport Signature not valid"
        );

        emit Message(messageToBroadcast);
        publicKey = nextpub;
    }
}
