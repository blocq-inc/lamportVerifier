### Lamport Lib And Tests

## Explanation
A library for verifying Lamport Signatures from within an Ethereum EVM smart contract. Written in Solidity. This library is part of an ongoing effort by Pauli Group to ensure that blockchain technology continues to be viable in the face of Quantum Computing.

## Standard Implementation Notes
- The last function argument MUST be the Lamport Signature
- The second last function argument MUST be the replacemnt lamport public key 
- All the other arguments MUST be transformed to bytes using `abi.encodePacked(arg1, arg2, arg3, ...)`
- These bytes MUST then be hashed using `keccak256(bytes)`
- The hash MUST then be cast to an `uint256` using `uint256(hash)`

## Important files:
 1. LamportLib.sol      - The library that contains the verification logic
 2. LamportTest.sol     - A simple contract with functionality guarded by a lamport signature
 3. LamportTest.spec.ts - A test suite for the LamportTest and LamportLib contracts

## To run the tests:
    bash test.sh
