// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintNFT is ERC1155, Ownable {
    string public name;
    string public symbol;
    string metadataURI;
    uint maxTokenId; // 굳이 바깥에서 확인할 필요 없으니 private으로 

    string notRevealedURI;
    bool isRevealed;

    constructor(string memory _name, string memory _symbol, uint _maxTokenId, string memory _notRevealedURI) ERC1155("")  Ownable(msg.sender) { //오픈제플린 보면 원래 안에 메타데이터주소 들어가야 하는데 우린 커스마이징할 예정이라빈 스트링 넣음
 name = _name;
 symbol = _symbol;
maxTokenId = _maxTokenId;
notRevealedURI = _notRevealedURI;
    } 

function mintToken(uint _tokenId, uint _amount) public {
    require(_tokenId <= maxTokenId && _tokenId != 0, "Not exist token id."); // 이 코드는 0번째 토큰도 생성 가능. 원하면 이것도 체크 넣어

    _mint(msg.sender, _tokenId, _amount, "");
}

function uri(uint _tokenId) public override view returns(string memory) { //오픈제플린에서 tokenurl 대응 함수 찾아보면 이 경우는 uri()임

if(!isRevealed) {
    return notRevealedURI;
}

return string(abi.encodePacked(metadataURI, '/', Strings.toString(_tokenId), '.json'));

}

function setMetadataURI(string memory _metadataURI) public onlyOwner {

    metadataURI = _metadataURI;
}

function reveal() public onlyOwner {
    isRevealed = true;
}

}