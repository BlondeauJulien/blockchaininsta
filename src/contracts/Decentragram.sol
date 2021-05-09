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

    event ImageCreated(
        uint256 id,
        string hash,
        string description,
        uint256 tipAmount,
        address payable author
    );

    event ImageTipped(
        uint256 id,
        string hash,
        string description,
        uint256 tipAmount,
        address payable author
    );

    // Create Images
    function uploadImage(string memory _imgHash, string memory _description)
        public
    {
        //require: if this doesn't pass the code won't continue
        require(bytes(_description).length > 0, "No descriptions provided");
        require(bytes(_imgHash).length > 0, "No hash");
        require(msg.sender != address(0x0), "No author");

        // Increment image id
        imageCount++;
        //add image to contract
        images[imageCount] = Image(
            imageCount,
            _imgHash,
            _description,
            0,
            msg.sender // msg.sender is the person that send this request (their etherum address)
        );

        //Trigger an event
        emit ImageCreated(imageCount, _imgHash, _description, 0, msg.sender);
    }

    //Tip Images
    function tipImageOwner(uint256 _id) public payable {
        // MAke sure the id is valid
        require(_id > 0 && _id <= imageCount);

        // Fetch the image
        Image memory _image = images[_id]; // memory mean its a local variable and not from storage in the blockchain

        //Fetch the author
        address payable _author = _image.author;

        //Pay the author by sending them Ether
        address(_author).transfer(msg.value);

        //Increment the tip amount
        _image.tipAmount = _image.tipAmount + msg.value;

        // Update the image
        images[_id] = _image;

        //Trigger an event
        emit ImageTipped(
            _id,
            _image.hash,
            _image.description,
            _image.tipAmount,
            _author
        );
    }
}
