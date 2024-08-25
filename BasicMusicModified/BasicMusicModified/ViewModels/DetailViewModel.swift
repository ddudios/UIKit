//
//  DetailViewModel.swift
//  BasicMusicModified
//
//  Created by Suji Jang on 8/26/24.
//

import UIKit

final class DetailViewModel {
    var apiManager: NetworkType
    var music: Music?
    
    // 변화에 따라 할당
    var imageUrl: String? {
        didSet {
            apiManager.loadImage(imageUrl: imageUrl, completion: { image in
                self.albumImage = image
            })
        }
    }
    
    var albumImage: UIImage? {
        didSet {
            onCompleted(albumImage)
        }
    }
    
    // 그냥 할당
    var songNameString: String? {
        return music?.songName
    }
    
    var onCompleted: (UIImage?) -> () = { _ in }
    
    init(apiManager: NetworkType) {
        self.apiManager = apiManager
    }
}
