// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "./LamportLib.sol";

contract LamportTest2 {
    event Message(string message);

    bool initialized = false;
    bytes32[2][256] publicKey;

    function getPublicKey() public view returns (bytes32[2][256] memory) {
        return publicKey;
    }

    function init(bytes32[2][256] memory firstPublicKey) public {
        require(!initialized, "Already initialized");
        publicKey = firstPublicKey;
        initialized = true;
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
