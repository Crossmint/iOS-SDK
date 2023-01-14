//
//  APIService.swift
//  Crossmint
//
//  Created by Navpreet Kaur on 10/27/22.
//

import Foundation
import Crossmint

class NFTService {
  enum Errors: Error {
    case invalidURL
  }
  
  func fetchNFTs(blockchain: Blockchain, address: String, devnet: Bool = true) async throws -> [NFT]
  {
    let urlString = "https://demo.crossmint.io/api/wallets/nfts\(queryString(blockchain, address, devnet))"
    guard let url = URL(string: urlString) else {
      throw Errors.invalidURL
    }
    
    let request = URLRequest(url: url)
    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode([NFT].self, from: data)
  }
}

private func queryString(_ blockchain: Blockchain, _ address: String, _ devnet: Bool) -> String
{
  var components = URLComponents()
  components.queryItems = [
    URLQueryItem(name: "blockchain", value: blockchain.rawValue),
    URLQueryItem(name: "address", value: address),
    URLQueryItem(name: "devnet", value: "\(devnet)"),
  ]
  return components.string ?? ""
}
