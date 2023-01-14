//
//  ViewController.swift
//  Crossmint
//
//  Created by Austin Feight on 11/28/22.
//

import UIKit
import Crossmint

class ViewController: UIViewController {
  var nftsViewController: NFTsCollectionViewController!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    addCollectionView()
    loadNFTs()
  }
}

// MARK: - Helpers
private extension ViewController {
  func addCollectionView()
  {
    nftsViewController = NFTsCollectionViewController()
    nftsViewController.onNFTSelected = { nft in
      let nftDetailsViewController = NFTDetailViewController(nft: nft)
      self.present(nftDetailsViewController, animated: true)
    }
    
    view.addSubview(nftsViewController.view)
    
    view.topAnchor.constraint(equalTo: nftsViewController.view.topAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: nftsViewController.view.bottomAnchor).isActive = true
    view.leadingAnchor.constraint(equalTo: nftsViewController.view.leadingAnchor).isActive = true
    view.trailingAnchor.constraint(equalTo: nftsViewController.view.trailingAnchor).isActive = true
    
    addChild(nftsViewController)
    nftsViewController.didMove(toParent: parent)
  }
  
  func loadNFTs()
  {
    Task(priority: .medium) {
      do {
        let address = "D6bDg4DcCpsprQEmnUdcWhpkj2pMDxEJa615oyvS3sQL"
        let nfts = try await NFTService().fetchNFTs(blockchain: .solana, address: address)
        
        DispatchQueue.main.async { [nftsViewController] in
          nftsViewController?.nfts = nfts
        }
      } catch {
        NSLog("failed: \(error)")
      }
    }
  }
}
