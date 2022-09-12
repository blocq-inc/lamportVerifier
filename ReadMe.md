### Lamport Lib And Tests

## Explanation



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