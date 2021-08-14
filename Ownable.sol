// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
contract OwnableData {
    // V1 - V5: OK
    address public owner;
    // V1 - V5: OK
    address public pendingOwner;
}
// T1 - T4: OK
contract Ownable is OwnableData {
    // E1: OK
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () public {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }

    function renounceOwnership() public onlyOwner { 
        emit OwnershipTransferred(owner, address(0)); 
        owner = address(0);
        pendingOwner = address(0);
    }


    function transferOwnership(address newOwner) public onlyOwner {
        require(address(0) != newOwner, "pendingOwner set to the zero address."); 
        pendingOwner = newOwner;
    }


    function transferOwnershipDirectly(address newOwner) public onlyOwner { 
        require(address(0)!=newOwner,"not allowed to transfer owner to address(0)"); 
        owner = newOwner;
        emit OwnershipTransferred(owner, newOwner);
        pendingOwner = address(0);
    }

   
    // M1 - M5: OK
    // C1 - C21: OK
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }



    
}