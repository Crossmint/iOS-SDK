//
//  NFT.swift
//  Crossmint
//
//  Created by Austin Feight on 11/12/22.
//

import Foundation

public protocol NFTType: Decodable {
    associatedtype MetadataType: NFTMetadataType

    var chain: String { get }
    var metadata: MetadataType { get }
}

public enum NFT: NFTType {
    public typealias MetadataType = NFT.Metadata
    
    case solana(SolanaNFT)
    case evm(EVMNFT)
    
    public var chain: String {
        switch (self) {
            case .solana(let nft): return nft.chain
            case .evm(let nft): return nft.chain
        }
    }
    
    public var metadata: NFT.Metadata {
        switch (self) {
            case .solana(let nft): return NFT.Metadata(metadataType: nft.metadata)
            case .evm(let nft): return NFT.Metadata(metadataType: nft.metadata)
        }
    }
}

extension NFT {
    enum CodingKeys: CodingKey { case chain }
    
    public init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let container = try decoder.singleValueContainer()
        let chain = try values.decode(Blockchain.self, forKey: .chain)
        
        switch chain {
            case .solana:
                let nft = try container.decode(SolanaNFT.self)
                self = .solana(nft)
            case .polygon, .ethereum:
                let nft = try container.decode(EVMNFT.self)
                self = .evm(nft)
        }
    }
}

extension NFT {
    public struct Metadata: NFTMetadataType, Codable {
        public let name: String?
        public let description: String?
        public let image: String
        public let collection: NFT.Collection?
        public let attributes: [NFT.Metadata.Attribute]
        public let animationUrl: String?
        public let externalUrl: String?
        
        init(metadataType: NFTMetadataType)
        {
            self.name = metadataType.name
            self.description = metadataType.description
            self.image = metadataType.image
            self.collection = metadataType.collection
            self.attributes = metadataType.attributes
            self.animationUrl = metadataType.animationUrl
            self.externalUrl = metadataType.externalUrl
        }
    }
    
    public struct Collection: Codable {
        let name: String
        
        public init(name: String)
        {
            self.name = name
        }
    }
}

public protocol NFTMetadataType: Encodable, Decodable {
    var name: String? { get }
    var description: String? { get }
    var image: String { get }
    var collection: NFT.Collection? { get }
    var attributes: [NFT.Metadata.Attribute] { get }
    var animationUrl: String? { get }
    var externalUrl: String? { get }
}

extension NFT.Metadata {
    public struct Attribute: Codable {
        let traitType: String
        let value: String
        
        public init(traitType: String, value: String)
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
        let uri: String
        let type: String
            
        public init(uri: String, type: String)
        {
            self.uri = uri
            self.type = type
        }
    }
        
    public struct Creator: Codable {
        let address: String
        let share: Int
        
        public init(address: String, share: Int)
        {
            self.address = address
            self.share = share
        }
    }
}

// MARK: - CodingKeys

extension NFT.Metadata.Attribute {
    enum CodingKeys: String, CodingKey {
        case traitType = "trait_type"
        case value
    }
}
