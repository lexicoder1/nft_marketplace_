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
       

     function setsellnftprice(address nftcontractaddress ,uint tokenid,uint nftprice)public payable {
           nft _nft=nft(nftcontractaddress);
          require(_nft.ownerOf(tokenid)==msg.sender);
          nftprices[nftcontractaddress][tokenid]=nftprice;

           
     }

    
     function buynft(address nftcontractaddress ,uint tokenid)public payable {

          require(msg.value==nftprices[nftcontractaddress][tokenid]);
          nft _nft=nft(nftcontractaddress);
          uint marketplacefees=(nftprices[nftcontractaddress][tokenid]*2)/100; 
          uint price=nftprices[nftcontractaddress][tokenid]-marketplacefees;

          balance[_nft.ownerOf(tokenid)]+=price;

          _nft.transferFrom(_nft.ownerOf(tokenid),msg.sender,tokenid);  
     }

    functio


}