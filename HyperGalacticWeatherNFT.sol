// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract HyperGalacticWeatherNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct WeatherData {
        uint256 temperature;
        uint256 pressure;
        uint256 humidity;
    }

    mapping(uint256 => WeatherData) private _tokenWeatherData;

    constructor() ERC721("Hyper Galactic Weather NFT", "HGNFT") {}

    function mintWeatherNFT(address recipient) public returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);

        // Generate random weather data for the new NFT
        uint256 temperature = uint256(keccak256(abi.encodePacked(block.timestamp, newItemId, "Temperature"))) % 100;
        uint256 pressure = uint256(keccak256(abi.encodePacked(block.timestamp, newItemId, "Pressure"))) % 100;
        uint256 humidity = uint256(keccak256(abi.encodePacked(block.timestamp, newItemId, "Humidity"))) % 100;

        WeatherData memory weatherData = WeatherData(temperature, pressure, humidity);
        _tokenWeatherData[newItemId] = weatherData;

        return newItemId;
    }

    function getWeatherData(uint256 tokenId) public view returns (WeatherData memory) {
        return _tokenWeatherData[tokenId];
    }
}
