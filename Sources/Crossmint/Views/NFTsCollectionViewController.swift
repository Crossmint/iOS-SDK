//
//  NFTsCollectionViewController.swift
//  Crossmint
//
//  Created by Ramdeep Singh on 10/27/22.
//

import UIKit

public class NFTsCollectionViewController: UIViewController {
    public var nfts: [NFT] = [] {
        didSet { collectionView?.reloadData() }
    }
    public var onNFTSelected: ((NFT) -> Void)?

    @IBOutlet private weak var collectionView: UICollectionView!
    
    public init() { super.init(nibName: "NFTsCollectionViewController", bundle: Bundle.module) }
    required init?(coder: NSCoder) { super.init(nibName: "NFTsCollectionViewController", bundle: Bundle.module) }
}

// MARK: - View Life Cycle
public extension NFTsCollectionViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        self.registerCell()
    }
}

// MARK: - Collection View
extension NFTsCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let nft = nfts[indexPath.row]
        onNFTSelected?(nft)
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (self.view.frame.size.width - Layout.margin * (Layout.itemsPerRow + 1)) / Layout.itemsPerRow
        let height = width * Layout.aspectRatio
        return CGSize(width: width, height: height)
    }
}

extension NFTsCollectionViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        nfts.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt
        indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NFTCell

        let nft = nfts[indexPath.row]
        cell.configureCell(nft: nft)

        return cell
    }
}

// MARK: - Helpers
private extension NFTsCollectionViewController {
    struct Constants {
        static let reuseIdentifier = "cell"
    }
    
    enum Layout {
        static let margin: CGFloat = 12
        static let itemsPerRow: CGFloat = 2
        static let aspectRatio: CGFloat = 1.5
    }
    
    private func registerCell()
    {
        let itemCellNib = UINib(nibName: "NFTCell", bundle: Bundle.module)
        self.collectionView.register(itemCellNib, forCellWithReuseIdentifier: "cell")
    }
}
