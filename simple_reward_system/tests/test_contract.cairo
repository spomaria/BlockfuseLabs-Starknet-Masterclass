use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

// use simple_reward_system::IHelloStarknetSafeDispatcher;
// use simple_reward_system::IHelloStarknetSafeDispatcherTrait;
use simple_reward_system::IRewardSystemDispatcher;
use simple_reward_system::IRewardSystemDispatcherTrait;

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address
}

// Deploy the contract and return its dispatcher.
// fn deploy() -> IRewardSystemDispatcher {
//     // Declare and deploy
//     let (contract_address, _) = deploy_syscall(
//         RewardSystem::TEST_CLASS_HASH.try_into().unwrap(),
//         0,
//         array![initial_value.into()].span(),
//         false
//     )
//         .unwrap_syscall();

//     // Return the dispatcher.
//     // The dispatcher allows to interact with the contract based on its interface.
//     IRewardSystemDispatcher { contract_address }
// }

#[test]
fn test_view_user_points() {
    let contract_address = deploy_contract("RewardSystem");

    let dispatcher = IRewardSystemDispatcher { contract_address };

    let balance_before = dispatcher.view_points();
    assert(balance_before == 0, 'Invalid balance');
}

// #[test]
// fn test_user_can_add_points() {
//     let contract_address = deploy();

//     let dispatcher = IRewardSystemDispatcher { contract_address };

//     dipatcher.add_points(100);
//     let points_after = dispatcher.view_points();
//     assert(points_after == 100, 'Invalid balance');
    
// }