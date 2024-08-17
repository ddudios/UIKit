//
//  MusicCollectionViewCell.swift
//  MusicApp
//
//  Created by Suji Jang on 8/17/24.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainImageView.image = nil
    }
    
    func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
}
