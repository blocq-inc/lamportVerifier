import { RandPair, PubPair, LamportKeyPair } from "./Types"
import {mk_key_pair } from "./functions"

// easy key management and generation
export default class KeyTracker {
    privateKeys: RandPair[][] = []
    publicKeys: PubPair[][] = []
    name: string

    constructor (_name : string = 'default') {
        this.name = _name
    }

    save() {
        const s = JSON.stringify({
            privateKeys: this.privateKeys,
            publicKeys: this.publicKeys,
            name: this.name
        }, null, 2)
        const fs = require('fs');
        fs.writeFileSync(`keys/${this.name}.json`, s)
    }

    static load(name: string): KeyTracker {
        // try {
        const fs = require('fs');
        const s = fs.readFileSync(`keys/${name}.json`, 'utf8')
        // return JSON.parse(s) as KeyTracker
        const rval = new KeyTracker()
        return Object.assign(rval, JSON.parse(s))
        // } 
        // catch (e) {
        //     console.log(`could not load keys/${name}.json`)
        //     throw e
        // }
    }

    getNextKeyPair(): LamportKeyPair {
        const { pri, pub } = mk_key_pair()
        this.privateKeys.push(pri)
        this.publicKeys.push(pub)
        return { pri, pub }
    }

    currentKeyPair(): LamportKeyPair {
        if (this.privateKeys.length == 0)
            return this.getNextKeyPair()
        return {
            pri: this.privateKeys[this.privateKeys.length - 1],
            pub: this.publicKeys[this.publicKeys.length - 1]
        }
    }

    previousKeyPair(): LamportKeyPair {
        if (this.privateKeys.length < 2)
            throw new Error('no previous key pair')
        return { pri: this.privateKeys[this.privateKeys.length - 2], pub: this.publicKeys[this.publicKeys.length - 2] }
    }
}