//
//  EVMNFT.swift
//  
//
//  Created by Austin Feight on 1/13/23.
//

import Foundation

public struct EVMNFT: NFTType, Codable {
    public let chain: String
    public let contractAddress: String
    public let tokenId: String
    public let metadata: Metadata
}

public extension EVMNFT {
    struct Metadata: NFTMetadataType, Codable {
        public let image: String
        public let collection: NFT.Collection?
        public let name: String?
        public let description: String?
        public let attributes: [NFT.Metadata.Attribute]
        public let animationUrl: String?
        public let externalUrl: String?
    }
}

// MARK: - Codable

extension EVMNFT.Metadata {
    enum CodingKeys: String, CodingKey {
        case image
        case collection
        case name
        case description
        case attributes
        case animationUrl = "animation_url"
        case externalUrl = "external_url"
    }
    
    public init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decode(String.self, forKey: .image)
        collection = try values.decodeIfPresent(NFT.Collection.self, forKey: .collection)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        attributes = try values.decodeIfPresent([NFT.Metadata.Attribute].self, forKey: .attributes) ?? []
        animationUrl = try values.decodeIfPresent(String.self, forKey: .animationUrl)
        externalUrl = try values.decodeIfPresent(String.self, forKey: .externalUrl)
    }
}
