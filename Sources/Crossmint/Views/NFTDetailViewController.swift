//
//  NFTDetailViewController.swift
//  Crossmint
//
//  Created by Austin Feight on 11/12/22.
//

import UIKit

public class NFTDetailViewController: UIViewController {
    public let nft: NFT
    
    @IBOutlet private(set) weak var nftDescription: UITextView!
    @IBOutlet private(set) weak var subtitle: UILabel!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var imageView: UIImageView!

    public init(nft: NFT)
    {
        self.nft = nft
        super.init(nibName: nil, bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - View Life Cycle
public extension NFTDetailViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bindData()
    }
}

// MARK: - Helpers
private extension NFTDetailViewController {
    func bindData()
    {
        titleLabel.text = nft.metadata.name
//        subtitle.text = nft.metadata.symbol
        nftDescription.text = nft.metadata.description
        
        ImageService().downloadImage(from: nft.metadata.image) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}
