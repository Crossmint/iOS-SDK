//
//  SolanaNFT.swift
//  
//
//  Created by Austin Feight on 1/13/23.
//

import Foundation

public struct SolanaNFT: NFTType {    
    public let chain: String
    public let mintHash: String?
    public let metadata: Metadata
    public let locator: String?

    public init(
        chain: String,
        mintHash: String,
        metadata: Metadata,
        locator: String
    ) {
        self.chain = chain
        self.mintHash = mintHash
        self.metadata = metadata
        self.locator = locator
    }
}

public extension SolanaNFT {
    struct Metadata: NFTMetadataType, Codable {
        public let name: String?
        public let symbol: String
        public let description: String?
        public let image: String
        public let collection: NFT.Collection?
        public let attributes: [NFT.Metadata.Attribute]
        public let animationUrl: String?
        public let externalUrl: String?
        public let sellerFeeBasisPoints: Int?
    
        public init(
            name: String? = nil,
            symbol: String,
            description: String? = nil,
            image: String,
            collection: NFT.Collection? = nil,
            attributes: [NFT.Metadata.Attribute],
            animationUrl: String? = nil,
            externalUrl: String? = nil,
            sellerFeeBasisPoints: Int? = nil
        ) {
            self.name = name
            self.symbol = symbol
            self.description = description
            self.image = image
            self.collection = collection
            self.attributes = attributes
            self.animationUrl = animationUrl
            self.externalUrl = externalUrl
            self.sellerFeeBasisPoints = sellerFeeBasisPoints
        }
    }    
}

extension SolanaNFT.Metadata {
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case description
        case image
        case collection
        case attributes
        case animationUrl = "animation_url"
        case externalUrl = "external_url"
        case sellerFeeBasisPoints = "seller_fee_basis_points"
    }
}
