//
//  NFTCell.swift
//  Crossmint
//
//  Created by Navpreet Kaur on 10/28/22.
//

import UIKit

class NFTCell: UICollectionViewCell {
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func configureCell(nft: NFT) {
        self.name.text = nft.metadata?.name
        self.quantity.text = "\(nft.metadata?.sellerFeeBasisPoints ?? 0)"
        
        if let imageURL = nft.metadata?.image {
            ImageService().downloadImage(from: imageURL, image: { [weak self] data in
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            })
        }
    }
}
