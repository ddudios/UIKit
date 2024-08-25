//
//  MusicViewModel.swift
//  BasicMusicModified
//
//  Created by Suji Jang on 8/26/24.
//

import Foundation

final class MusicViewModel {
    
    // 모델
    var music: Music? {
        didSet {
            onCompleted()
        }
    }
    
    let networkManager = APIService()
    
    let detailVM = DetailViewModel()
    
    var onCompleted: () -> () = {}
    
    // Output
    func albumNameString() -> (String?) {
        return music?.albumName
    }
    
    func songNameString() -> (String?) {
        return music?.songName
    }
    
    func artistNameString() -> (String?) {
        return music?.artistName
    }
    
    // Input
    func handleButtonTapped() {
        networkManager.fetchMusic { [weak self] result in
            switch result {
            case .success(let music):
                self?.music = music
            case .failure(.dataError):
                print("데이터 에러")
            case .failure(.networkingError):
                print("네트워킹 에러")
            case .failure(.parseError):
                print("파싱 에러")
            }
        }
    }
    
    // Logic
    func getDetailViewModel() -> DetailViewModel {
        let detailVM = DetailViewModel()
        
        detailVM.music = self.music
        detailVM.imageUrl = self.music?.imageUrl
        
        return detailVM
    }
}
