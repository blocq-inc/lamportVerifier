// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "./LamportLib.sol";

contract LamportTest2 {
    event Message(string message);

    bool initialized = false;
    // bytes32[2][256] publicKey;
    bytes32 pkh; // lamport public key hash

    // function getPublicKey() public view returns (bytes32[2][256] memory) {
    //     return publicKey;
    // }

    function getPKH() public view returns (bytes32) {
        return pkh;
    }

    // function init(bytes32[2][256] memory firstPublicKey) public {
    function init(bytes32 firstPKH) public {
        require(!initialized, "Already initialized");
        pkh = firstPKH;
        initialized = true;
    }

    function broadcast(
        string memory messageToBroadcast,
        bytes32[2][256] memory currentpub,
        bytes32 nextPKH,
        bytes[256] memory sig
    ) public {
        require(initialized, "LamportTest2 not initialized");

        // expect that hashing currentpub gives pkh
        require(
            keccak256(abi.encodePacked(currentpub)) == pkh,
            "currentpub does not match known PUBLIC KEY HASH"
        );

        require(
            LamportLib.verify_u256(
                uint256(
                    keccak256(abi.encodePacked(messageToBroadcast, nextPKH))
                ),
                sig,
                currentpub
            ),
            "Lamport Signature not valid"
        );

        emit Message(messageToBroadcast);
        pkh = nextPKH;
    }
}
