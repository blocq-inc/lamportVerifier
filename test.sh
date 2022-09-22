# DELETE JAVASCRIPT FILE
rm javascript_build/test/LamportTest.spec.js 

# COMPILE TYPECRIPT FILE
npx tsc 

# RUN JAVASCRIPT FILE
truffle test javascript_build/test/LamportTest.spec.js --bail --show-events --network rinkeby 
# truffle test javascript_build/test/LamportTest.spec.js --bail --show-events 