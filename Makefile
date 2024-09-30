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

# solutions
solve_1 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_1; \
	forge script script/1/FallbackSolution.s.sol --sig "run(address)" $$puzzle_address_1 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_2 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_2; \
	forge script script/2/FalloutSolution.s.sol --sig "run(address)" $$puzzle_address_2 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

deploy_attacker_3 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_3; \
	forge script script/3/DeployCoinFlipAttacker.s.sol --sig "run(address)" $$puzzle_address_3 --verify --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

# need to run 10 times, alternatively you can use solve_3_consecutive in one shot
solve_3 :;
	forge script script/3/CoinFlipSolution.s.sol --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

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
	forge script script/4/DeployTelephoneAttacker.s.sol --sig "run(address)" $$puzzle_address_4 --verify --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_4 :;
	forge script script/4/TelephoneSolution.s.sol --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_5 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_5; \
	forge script script/5/TokenSolution.s.sol --sig "run(address)" $$puzzle_address_5 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --sender $$WALLET_PUBLIC_ADDRESS --broadcast -vvv

solve_6 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_6; \
	forge script script/6/DelegateSolution.s.sol --sig "run(address)" $$puzzle_address_6 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

deploy_attacker_7 :;
	forge script script/7/DeployForceAttacker.s.sol --verify --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_7 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_7; \
	forge script script/7/ForceSolution.s.sol --sig "run(address)" $$puzzle_address_7 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_8 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_8; \
	password=$$(cast storage $$puzzle_address_8 1 --rpc-url $$SEPOLIA_RPC_URL); \
	forge script script/8/VaultSolution.s.sol --sig "run(address,bytes32)" $$puzzle_address_8 $$password --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

deploy_attacker_9 :;
	forge script script/9/DeployKingAttacker.s.sol --verify --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_9 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_9; \
	forge script script/9/KingSolution.s.sol --sig "run(address)" $$puzzle_address_9 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

deploy_attacker_10 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_10; \
	forge script script/10/DeployReentrancyAttacker.s.sol --sig "run(address)" $$puzzle_address_10 --verify --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_10 :;
	@read -p "Enter Attacker address (0x...): " attacker_address_10; \
	forge script script/10/ReentrancySolution.s.sol --sig "run(address)" $$attacker_address_10 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

deploy_attacker_11 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_11; \
	forge script script/11/DeployElevatorAttacker.s.sol --sig "run(address)" $$puzzle_address_11 --verify --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_11 :;
	forge script script/11/ElevatorSolution.s.sol --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_12 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_12; \
	key=$$(cast storage $$puzzle_address_12 5 --rpc-url $$SEPOLIA_RPC_URL); \
	forge script script/12/PrivacySolution.s.sol --sig "run(address,bytes32)" $$puzzle_address_12 $$key --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

deploy_attacker_13 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_13; \
	forge script script/13/DeployGateKeeperOneAttacker.s.sol --sig "run(address)" $$puzzle_address_13 --verify --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_13 :;
	forge script script/13/GateKeeperOneSolution.s.sol --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_14 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_14; \
	forge script script/14/GateKeeperTwoSolution.s.sol --sig "run(address)" $$puzzle_address_14 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_15 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_15; \
	forge script script/15/NaughtCoinSolution.s.sol --sig "run(address)" $$puzzle_address_15 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --sender $$WALLET_PUBLIC_ADDRESS --broadcast -vvv

deploy_attacker_16 :;
	forge script script/16/DeployPreservationAttacker.s.sol --verify --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

solve_16 :;
	@read -p "Enter Puzzle address (0x...): " puzzle_address_16; \
	forge script script/16/PreservationSolution.s.sol --sig "run(address)" $$puzzle_address_16 --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --sender $$WALLET_PUBLIC_ADDRESS --broadcast -vvv

# steps
solve_step_3 :;
	forge script script/3/CoinFlipSolution.s.sol --rpc-url $$SEPOLIA_RPC_URL --account sepoliaKey --broadcast -vvv

delay :;
	sleep 15
