// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;
/// @title Voting with delegation.
contract Voting {
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can perform this action");
    _; }

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    uint public  candidatesCount;
      mapping(address => bool) public voters;
    
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    
    function removeCandidate(uint _id) public onlyOwner {
        require(_id > 0 && _id <= candidatesCount, "Invalid candidate ID");
        delete candidates[_id];
    }
    
    function vote(uint _candidateId) public {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        require(!voters[msg.sender], "You have already voted");
        
        candidates[_candidateId].voteCount++;
        voters[msg.sender] = true;
    }
    
    function getCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory _candidates = new Candidate[](candidatesCount);
        
        for (uint i = 1; i <= candidatesCount; i++) {
            _candidates[i - 1] = candidates[i];
        }
        
        return _candidates;
    }
}