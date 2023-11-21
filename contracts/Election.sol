// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Election{

    //Election Candidate
    struct Candidate{
        string name; 
        uint numOfVotes; 
    }
    
    //Voter
    struct Voter{
        string name; 
        bool isAuthorized; 
        bool hasVoted; 
        uint c_id; //candidate Id
    }
    
    //Address of the Owner of the smart contract
    address public smartContractOwner; 

    //custom modifier to implement OwnerOnly Functionality
    modifier ownerOnly(){
        require(msg.sender == smartContractOwner);
        _;
    }

    //Election state variables
    string public electionName; 
    uint public totalVotes; 

    //mapping voter's address to the Voter{}
    mapping(address => Voter) public voters; 

    //List of candidates
    Candidate[] public candidates; 
    
    //Election init()
    function startElection(string memory _electionName) public {
        smartContractOwner = msg.sender; //the person who is currently interacting with the contract
        electionName = _electionName; 
    }
    
    //Owner Adding candidates
    function addCandidate(string memory _candidateName)ownerOnly public { //owner only modifer used
        candidates.push(Candidate(_candidateName, 0));
    }
    
    //owner authorizing voters
    function AuthorizeVoter(address _voterAddress) ownerOnly public {
        voters[_voterAddress].isAuthorized = true; 
    }
    
    //to show no of candidates
    function getNumOfCandidates() public view returns(uint){
        return candidates.length;
    }

    //voting
    function vote(uint _candidateIndex) public{
        require(!voters[msg.sender].hasVoted);
        require(voters[msg.sender].isAuthorized);
        voters[msg.sender].c_id = _candidateIndex; 
        voters[msg.sender].hasVoted = true; 
        candidates[_candidateIndex].numOfVotes++; 
        totalVotes++; 
    }
}