
#[starknet::interface]
pub trait IRewardSystem<TContractState>{
    fn add_points(ref self: TContractState, points: u256);

    fn redeem_points(ref self: TContractState, points: u256);

    fn view_points(self: @TContractState) -> u256;
}


/// Simple contract for user rewards.
#[starknet::contract]
mod RewardSystem {
    use starknet::storage::{
        StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map,
    };

    use core::starknet::{ContractAddress, get_caller_address};

    #[storage]
    struct Storage {
        user_balance: Map<ContractAddress, u256>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        PointsAdded: PointsAdded,
        PointsRedeemed: PointsRedeemed,
    }

    #[derive(Drop, starknet::Event)]
    pub struct PointsAdded {
        pub user_address: ContractAddress,
        pub points: u256,
    }

    #[derive(Drop, starknet::Event)]
    pub struct PointsRedeemed {
        pub user_address: ContractAddress,
        pub points: u256,
    }

    #[abi(embed_v0)]
    impl RewardSystemImp of super::IRewardSystem<ContractState>{
        fn add_points(ref self: ContractState, points: u256) {
            let user_address = get_caller_address();
            // read previous balance
            let _prev_balance: u256 = self.user_balance.entry(user_address).read();
            // add points to the previous balance
            self.user_balance.entry(user_address).write(_prev_balance + points);
    
            // emit event
            self.emit(PointsAdded{user_address, points});
        }
    
        fn redeem_points(ref self: ContractState, points: u256) {
            let user_address = get_caller_address();
            // read previous balance
            let _prev_balance: u256 = self.user_balance.entry(user_address).read();
    
            assert(points <= _prev_balance, 'Amount Exceeded');
    
            // adjust points after redemption
            self.user_balance.entry(user_address).write(_prev_balance - points);
    
            // emit event
            self.emit(PointsRedeemed{user_address, points});
        }
    
        fn view_points(self: @ContractState) -> u256 {
            let user_address = get_caller_address();
    
            self.user_balance.entry(user_address).read()
        }    
    }
    
}
