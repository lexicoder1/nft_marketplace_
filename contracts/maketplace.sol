pragma solidity 0.8.0;

interface nft{
function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function ownerOf(uint256 tokenId) external view returns (address);
}

contract nftmarketplace{



       mapping (address=>uint) balance;
       mapping(address => mapping( uint => uint)) private nftprices;
       

     function sellnft(address nftcontractaddress ,uint tokenid,uint nftprice)public payable {
           nft _nft=nft(nftcontractaddress);
          require(_nft.ownerOf(tokenid)==msg.sender);
          nftprices[nftcontractaddress][tokenid]=nftprice;

           
     }

    
     function buynft(address nftcontractaddress ,uint tokenid)public payable {

          require(msg.value==nftprices[nftcontractaddress][tokenid]);
          require(msg.value>0); 
          // require(_nft.ownerOf(tokenid)==msg.sender);
          nft _nft=nft(nftcontractaddress);
          uint marketplacefees=(nftprices[nftcontractaddress][tokenid]*2)/100; 
          uint price=nftprices[nftcontractaddress][tokenid]-marketplacefees;

          balance[_nft.ownerOf(tokenid)]+=price;

          _nft.transferFrom(_nft.ownerOf(tokenid),msg.sender,tokenid);  
     }

    function withdraw()public {
         require(balance[msg.sender]>0);
         payable(msg.sender).transfer( balance[msg.sender]);


    }
    function checkbal()public view returns(uint){
         return balance[msg.sender];
    }

   
   

}