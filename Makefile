-include .env

# setup wallet
setup_wallet :; cast wallet import sepoliaKey --interactive

list_wallets :; cast wallet list

# install libs
install_libs : remove_libs install_foundry install_foundry-devops install_openzeppelin@3.3.0 install_openzeppelin

remove_libs :; rm -rf lib/*

install_foundry :; forge install foundry-rs/forge-std --no-commit

install_openzeppelin@3.3.0 :; forge install openzeppelin-contracts@v3.3.0=openzeppelin/openzeppelin-contracts@v3.3.0 --no-commit

install_openzeppelin :; forge install openzeppelin-contracts=openzeppelin/openzeppelin-contracts --no-commit

install_foundry-devops :; forge install cyfrin/foundry-devops --no-commit

NETWORK_ARGS := --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv
NETWORK_ARGS_VERIFY := --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast --verify -vvv
NETWORK_ARGS_SENDER := --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --sender $$WALLET_PUBLIC_ADDRESS --broadcast -vvv

# solutions
solve_1 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_1; \
	forge script script/1/FallbackSolution.s.sol --sig "run(address)" $$puzzle_address_1 ${NETWORK_ARGS}

solve_2 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_2; \
	forge script script/2/FalloutSolution.s.sol --sig "run(address)" $$puzzle_address_2 ${NETWORK_ARGS}

deploy_attacker_3 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_3; \
	forge script script/3/DeployCoinFlipAttacker.s.sol --sig "run(address)" $$puzzle_address_3 ${NETWORK_ARGS}

# need to run 10 times, alternatively you can use solve_3_consecutive in one shot
solve_3 :;
	forge script script/3/CoinFlipSolution.s.sol ${NETWORK_ARGS}

solve_3_consecutive :
	$(MAKE) solve_step_3; \
 	$(MAKE) delay; \
	$(MAKE) solve_step_3; \
 	$(MAKE) delay; \
 	$(MAKE) solve_step_3; \
	$(MAKE) delay; \
	$(MAKE) solve_step_3; \
	$(MAKE) delay; \
	$(MAKE) solve_step_3; \
	$(MAKE) delay; \
	$(MAKE) solve_step_3; \
	$(MAKE) delay; \
	$(MAKE) solve_step_3; \
	$(MAKE) delay; \
	$(MAKE) solve_step_3; \
	$(MAKE) delay; \
	$(MAKE) solve_step_3; \
	$(MAKE) delay; \
	$(MAKE) solve_step_3

deploy_attacker_4 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_4; \
	forge script script/4/DeployTelephoneAttacker.s.sol --sig "run(address)" $$puzzle_address_4 ${NETWORK_ARGS}

solve_4 :;
	forge script script/4/TelephoneSolution.s.sol ${NETWORK_ARGS}

solve_5 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_5; \
	forge script script/5/TokenSolution.s.sol --sig "run(address)" $$puzzle_address_5 ${NETWORK_ARGS_SENDER}

solve_6 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_6; \
	forge script script/6/DelegateSolution.s.sol --sig "run(address)" $$puzzle_address_6 ${NETWORK_ARGS}

deploy_attacker_7 :;
	forge script script/7/DeployForceAttacker.s.sol ${NETWORK_ARGS}

solve_7 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_7; \
	forge script script/7/ForceSolution.s.sol --sig "run(address)" $$puzzle_address_7 ${NETWORK_ARGS}

solve_8 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_8; \
	password=$$(cast storage $$puzzle_address_8 1 --rpc-url $$SEPOLIA_RPC_URL); \
	forge script script/8/VaultSolution.s.sol --sig "run(address,bytes32)" $$puzzle_address_8 $$password ${NETWORK_ARGS}

deploy_attacker_9 :;
	forge script script/9/DeployKingAttacker.s.sol ${NETWORK_ARGS}

solve_9 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_9; \
	forge script script/9/KingSolution.s.sol --sig "run(address)" $$puzzle_address_9 ${NETWORK_ARGS}

deploy_attacker_10 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_10; \
	forge script script/10/DeployReentrancyAttacker.s.sol --sig "run(address)" $$puzzle_address_10 ${NETWORK_ARGS}

solve_10 :;
	@read -p "Enter Attacker address (0x...): " attacker_address_10; \
	forge script script/10/ReentrancySolution.s.sol --sig "run(address)" $$attacker_address_10 ${NETWORK_ARGS}

deploy_attacker_11 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_11; \
	forge script script/11/DeployElevatorAttacker.s.sol --sig "run(address)" $$puzzle_address_11 ${NETWORK_ARGS}

solve_11 :;
	forge script script/11/ElevatorSolution.s.sol ${NETWORK_ARGS}

solve_12 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_12; \
	key=$$(cast storage $$puzzle_address_12 5 --rpc-url $$SEPOLIA_RPC_URL); \
	forge script script/12/PrivacySolution.s.sol --sig "run(address,bytes32)" $$puzzle_address_12 $$key ${NETWORK_ARGS}

deploy_attacker_13 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_13; \
	forge script script/13/DeployGateKeeperOneAttacker.s.sol --sig "run(address)" $$puzzle_address_13 ${NETWORK_ARGS}

solve_13 :;
	forge script script/13/GateKeeperOneSolution.s.sol ${NETWORK_ARGS}

solve_14 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_14; \
	forge script script/14/GateKeeperTwoSolution.s.sol --sig "run(address)" $$puzzle_address_14 ${NETWORK_ARGS}

solve_15 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_15; \
	forge script script/15/NaughtCoinSolution.s.sol --sig "run(address)" $$puzzle_address_15 ${NETWORK_ARGS_SENDER}

deploy_attacker_16 :;
	forge script script/16/DeployPreservationAttacker.s.sol ${NETWORK_ARGS}

solve_16 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_16; \
	forge script script/16/PreservationSolution.s.sol --sig "run(address)" $$puzzle_address_16 ${NETWORK_ARGS_SENDER}

# for puzzle 17 read json response
install_jq :;
	sudo apt-get update && sudo apt-get install -y jq

solve_17 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_17; \
	result=$$(curl -s "https://api-sepolia.etherscan.io/api?module=account&action=txlistinternal&address=$$puzzle_address_17&apikey=$$ETHERSCAN_API_KEY"); \
	contractAddress=$$(echo $$result | jq '.result[1].contractAddress'); \
	contractAddress=$$(echo $$contractAddress | tr -d '"'); \
	forge script script/17/RecoverySolution.s.sol --sig "run(address)" $$contractAddress ${NETWORK_ARGS_SENDER}

# steps
solve_step_3 :;
	forge script script/3/CoinFlipSolution.s.sol ${NETWORK_ARGS}

delay :;
	sleep 15

