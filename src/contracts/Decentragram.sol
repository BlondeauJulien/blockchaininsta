pragma solidity ^0.5.0;

contract Decentragram {
    string public name = "Decentragram";
    // Store Images
    uint256 public imageCount = 0;
    mapping(uint256 => Image) public images;

    struct Image {
        uint256 id;
        string hash;
        string description;
        uint256 tipAmount;
        address payable author;
    }

    // Create Images
    function uploadImage(string memory _imgHash, string memory _description)
        public
    {
        // Increment image id
        imageCount = imageCount++;
        //add image to contract
        images[imageCount] = Image(
            imageCount,
            _imgHash,
            _description,
            0,
            msg.sender // msg.sender is the person that send this request (their etherum address)
        );
    }

    //Tip Images
}
