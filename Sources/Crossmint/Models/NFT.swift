//
//  NFT.swift
//  Crossmint
//
//  Created by Austin Feight on 11/12/22.
//

import Foundation

public struct NFT: Codable {
    let chain: String?
    let mintHash: String?
    let metadata: Metadata?
    let locator: String?
    
    public init(
        chain: String? = nil,
        mintHash: String? = nil,
        metadata: NFT.Metadata? = nil,
        locator: String? = nil
    ) {
        self.chain = chain
        self.mintHash = mintHash
        self.metadata = metadata
        self.locator = locator
    }
}

extension NFT {
    public struct Metadata: Codable {
        let name: String?
        let symbol: String?
        let description: String?
        let sellerFeeBasisPoints: Int?
        let image: String?
        let attributes: [Attribute]?
        let properties: Properties?
        
        public init(
            name: String? = nil,
            symbol: String? = nil,
            description: String? = nil,
            sellerFeeBasisPoints: Int? = nil,
            image: String? = nil,
            attributes: [NFT.Metadata.Attribute]? = nil,
            properties: NFT.Metadata.Properties? = nil
        ) {
            self.name = name
            self.symbol = symbol
            self.description = description
            self.sellerFeeBasisPoints = sellerFeeBasisPoints
            self.image = image
            self.attributes = attributes
            self.properties = properties
        }
    }
}

extension NFT.Metadata {
    public struct Attribute: Codable {
        let traitType: String?
        let value: String?
        
        public init(traitType: String? = nil, value: String? = nil)
        {
            self.traitType = traitType
            self.value = value
        }
    }
    
    public struct Properties: Codable {
        let files: [File]?
        let creators: [Creator]?
        let category: String?
        
        public init(
            files: [NFT.Metadata.Properties.File]? = nil,
            creators: [NFT.Metadata.Properties.Creator]? = nil,
            category: String? = nil
        ) {
            self.files = files
            self.creators = creators
            self.category = category
        }
    }
}

extension NFT.Metadata.Properties {
    public struct File: Codable {
        let uri: String?
        let type: String?
            
        public init(uri: String? = nil, type: String? = nil)
        {
            self.uri = uri
            self.type = type
        }
    }
        
    public struct Creator: Codable {
        let address: String?
        let share: Int?
        
        public init(address: String? = nil, share: Int? = nil)
        {
            self.address = address
            self.share = share
        }
    }
}

// MARK: - CodingKeys

extension NFT.Metadata {
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case description
        case sellerFeeBasisPoints = "seller_fee_basis_points"
        case image
        case attributes
        case properties
    }
}

extension NFT.Metadata.Attribute {
    enum CodingKeys: String, CodingKey {
        case traitType = "trait_type"
        case value
    }
}
