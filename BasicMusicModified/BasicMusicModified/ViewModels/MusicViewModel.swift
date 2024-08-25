//
//  MusicViewModel.swift
//  BasicMusicModified
//
//  Created by Suji Jang on 8/26/24.
//

import Foundation

final class MusicViewModel {
    
    // 일부러 싱글톤으로 안만듦
    let apiManager: NetworkType
    
    // 모델
    var music: Music? {
        didSet {
            onCompleted()
        }
    }
    
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
    
    // ⭐️ 의존성 주입
    init(apiManager: NetworkType) {
        self.apiManager = apiManager
    }
    
    // Input
    func handleButtonTapped() {
        apiManager.fetchMusic { [weak self] result in
            switch result {
            case .success(let music):
                self?.music = music.last
            case .failure(let error):
                switch error {
                case .dataError:
                    print("데이터 에러")
                case .networkingError:
                    print("네트워킹 에러")
                case .parseError:
                    print("파싱 에러")
                }
            }
        }
    }
    
    // Logic
    func getDetailViewModel() -> DetailViewModel {
        
        // ⭐️ 의존성 주입
        let detailVM = DetailViewModel(apiManager: self.apiManager)
        
        detailVM.music = self.music
        detailVM.imageUrl = self.music?.imageUrl
        
        return detailVM
    }
}
