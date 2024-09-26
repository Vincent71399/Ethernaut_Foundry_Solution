1. create an .env file at root with two keys as follows:
   (you will need to acquire this two by enroll in https://www.infura.io/ and https://etherscan.io/)
```javascript
    export SEPOLIA_RPC_URL=https://xxxxxx
    export ETHERSCAN_API_KEY=xxxxxx
```

2. in Ubuntu/Linux system (if you are using windows system, you need to install linux, https://learn.microsoft.com/en-us/windows/wsl/install)
<br/> run following command to install all necessary libraries
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