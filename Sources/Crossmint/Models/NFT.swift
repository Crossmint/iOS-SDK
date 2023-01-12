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
    
    public struct Metadata: Codable {
        let name: String?
        let symbol: String?
        let description: String?
        let sellerFeeBasisPoints: Int?
        let image: String?
        let attributes: [Attribute]?
        let properties: Properties?
        
        public struct Attribute: Codable {
            let traitType: String?
            let value: String?
        }

        public struct Properties: Codable {
            let files: [File]?
            let creators: [Creator]?
            let category: String?
            
            public struct File: Codable {
                let uri: String?
                let type: String?
            }
            
            public struct Creator: Codable {
                let address: String?
                let share: Int?
            }
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
