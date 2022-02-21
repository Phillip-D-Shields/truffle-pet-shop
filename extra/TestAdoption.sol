pragma solidity ^0.5.0;


// some errors when using this testing method, stick with js for now 


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
    // the address of the adoption contract to be tested
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    // the id of the pet used for testing
    uint256 testPetId = 8;

    // the id of the owner of the pet used for testing
    uint256 expectedAdopter = address(this);

    // testing the adopt() function
    function testUserCanAdoptPet() public {
        uint256 returnedId = adoption.adopt(testPetId);

        Assert.equal(
            returnedId,
            testPetId,
            "The returned id should be the same as the testPetId"
        );
    }

    // Testing retrieval of a single pet's owner
    function testGetAdopterAddressByPetId() public {
        address adopter = adoption.adopters(testPetId);

        Assert.equal(
            adopter,
            expectedAdopter,
            "Owner of the expected pet should be this contract"
        );
    }

    // Testing retrieval of all pet owners
    function testGetAdopterAddressByPetIdInArray() public {
        // Store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();

        Assert.equal(
            adopters[testPetId],
            expectedAdopter,
            "Owner of the expected pet should be this contract"
        );
    }
}
