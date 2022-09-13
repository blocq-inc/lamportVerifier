import { randomBytes } from 'crypto'
import { ethers } from 'ethers';
const hash = (input: string) => ethers.utils.keccak256(ethers.utils.toUtf8Bytes(input))
const hash_b = (input: string) => ethers.utils.keccak256(input)

console.log(randomBytes(32).toString('hex'))
console.log(hash(randomBytes(32).toString('hex')).substring(2))