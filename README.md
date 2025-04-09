**My solutions to the ethernaut challenges in foundry**

1. create an .env file at root with two keys as follows:
   (you will need to acquire this two by enroll in https://www.infura.io/ and https://etherscan.io/)
```javascript
    export SEPOLIA_RPC_URL=https://xxxxxx
    export ETHERSCAN_API_KEY=xxxxxx
    export WALLET_PUBLIC_ADDRESS=0xXXXXX...XXXX
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

4. after start the puzzle in Ethernaut, run the following with input of the level contract address to solve them, 
you will need to enter the wallet password set in step 3 for broadcasting the transaction (maybe multiple times if need to deploy an attacker contract)
```javascript
    make solve_1
    make solve_2
    ...
```

5. then submit the level in Ethernaut page
