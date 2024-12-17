// #[cfg(test)]
// mod test_with_states {
//     use super::SimpleStorage;
//     use SimpleStorage::SimpleStorageImpl;

//     // use starknet::contract_address_const;
//     // use starknet::testing::set_caller_address;
//     // use core::num::traits::Zero;
//     use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

//     // fn deploy_contract(name: ByteArray) -> ContractAddress {
//     //     let contract = declare(name).unwrap().contract_class();
//     //     let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
//     //     contract_address
//     // }

//     #[test]
//     fn test_read_balance() {
//         let mut state = SimpleStorage::contract_state_for_testing();

//         assert_eq!(state.balance.read(), 0);
//         // assert_eq!(state.get_from_storage(), 0);

        
//     }

// }

// #[test]
// #[feature("safe_dispatcher")]
// fn test_cannot_increase_balance_with_zero_value() {
//     let contract_address = deploy_contract("HelloStarknet");

//     let safe_dispatcher = IHelloStarknetSafeDispatcher { contract_address };

//     let balance_before = safe_dispatcher.get_from_storage().unwrap();
//     assert(balance_before == 0, 'Invalid balance');

//     match safe_dispatcher.add_to_storage(0) {
//         Result::Ok(_) => core::panic_with_felt252('Should have panicked'),
//         Result::Err(panic_data) => {
//             assert(*panic_data.at(0) == 'Amount cannot be 0', *panic_data.at(0));
//         }
//     };
// }
