1. create an .env file at root with two keys as follows:
   (you will need to acquire this two by enroll in https://www.infura.io/ and https://etherscan.io/)
```javascript
    export SEPOLIA_RPC_URL=https://xxxxxx
    export ETHERSCAN_API_KEY=xxxxxx
```

2. run
```javascript
    make install_libs
```

3. prepare a metamask wallet with sepolia ETHs, use following to save it to local wallet
run
```javascript
    make setup_wallet
```
if success, you can view it by running
```javascript
    make list_wallets
```
you should see "sepoliaKey (Local)"