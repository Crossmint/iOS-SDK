# Crossmint

A library of components for displaying a list of NFTs as well as the details of an NFT.

## Installation

Installation is currently supported only via Swift Package Manager. To add this package to your Xcode project, follow these steps:

1. Click the `File` menu and select `Add Packages`
<img width="358" alt="image" src="https://user-images.githubusercontent.com/103966567/212243361-3a83cf17-29a2-4728-a74f-f2e6d8ad0657.png">

2. In the search box at the top-right, enter `https://github.com/Crossmint/iOS-SDK` and click `Add Package`
<img width="600" alt="Captura de pantalla 2023-01-12 a la(s) 11 22 29 p m" src="https://user-images.githubusercontent.com/103966567/212243753-1a0460b1-2f79-4c13-ada1-729e2613688c.png">

3. Once the next pop-up loads, ensure that the proper target is selected and click `Add Package` one more time
<img width="400" alt="Captura de pantalla 2023-01-12 a la(s) 11 24 41 p m" src="https://user-images.githubusercontent.com/103966567/212244005-e87823bc-8d48-445f-b999-4cdff40d3d55.png">

Congrats! The package has now been added and is ready to be used in your project.

## Usage

High-level descriptions are provided below, clone this repository locally and check out the example app. 
Included in the demo is a real-world code example to fetch NFTs from an API and display their contents in-app.

Use `NFTsCollectionViewController` to display a list of NFTs:
```swift
let nftsViewController = NFTsCollectionViewController()
nftsViewController.nfts = [
  .solana(
    SolanaNFT(
      mintHash: "123",
      metadata: SolanaNFT.Metadata(
        name: "The NFT",
        symbol: "NF",
        image: "https://twitter.com/crossmint/photo",
        attributes: [.init(traitType: "color", value: "blue")]
      )
    )
  ),
  .evm(
    EVMNFT(
      chain: .polygon,
      contractAddress: "0x01",
      tokenId: "1",
      metadata: EVMNFT.Metadata(
        image: "https://twitter.com/crossmint/photo",
        collection: NFT.Collection(name: "Great collectiojn"),
        name: "The other NFT",
        description: "A fantastic NFT",
        attributes: [.init(traitType: "color", value: "green")]
      )
    )
  )
]
```

Set the `onNFTSelected` callback to respond to an NFT being tapped:
```swift
nftsViewController.onNFTSelected = { nft in
    let nftDetailsViewController = NFTDetailViewController(nft: nft)
    self.present(nftDetailsViewController, animated: true)
}
```
