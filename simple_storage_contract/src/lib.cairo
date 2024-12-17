#[starknet::interface]
pub trait ISimpleStorage<TContractState>{
    fn add_to_storage(ref self: TContractState, amount: u256);
    fn get_from_storage(self: @TContractState) -> u256;
}

#[starknet::contract]
pub mod SimpleStorage {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage{
        balance: u256,
    }

    #[abi(embed_v0)]
    impl SimpleStorageImpl of super::ISimpleStorage<ContractState>{
        fn add_to_storage(ref self: ContractState, amount: u256){
            let _balance: u256 = self.balance.read(); 
            self.balance.write(_balance + amount);
        }
    
        fn get_from_storage(self: @ContractState) -> u256 {
            self.balance.read()
        }
    }

}


#[cfg(test)]
mod test_with_states {
    use super::SimpleStorage;
    
    use super::ISimpleStorage;
    // use SimpleStorage::SimpleStorageImpl;

    // use starknet::contract_address_const;
    // use starknet::testing::set_caller_address;
    // use core::num::traits::Zero;
    // use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    // fn deploy_contract(name: ByteArray) -> ContractAddress {
    //     let contract = declare(name).unwrap().contract_class();
    //     let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    //     contract_address
    // }

    #[test]
    fn test_read_balance() {
        let mut state = SimpleStorage::contract_state_for_testing();

        // assert_eq!(state.balance.read(), 0);
        assert_eq!(state.get_from_storage(), 0);

        
    }

    #[test]
    fn test_add_to_balance() {
        let mut state = SimpleStorage::contract_state_for_testing();

        state.add_to_storage(35);
        // assert_eq!(state.balance.read(), 0);
        assert_eq!(state.get_from_storage(), 35);
    
    }

    #[test]
    #[should_panic]
    fn test_add_to_balance2() {
        let mut state = SimpleStorage::contract_state_for_testing();

        state.add_to_storage(35);
        // assert_eq!(state.balance.read(), 0);
        assert_eq!(state.get_from_storage(), 0);
    
    }

}
