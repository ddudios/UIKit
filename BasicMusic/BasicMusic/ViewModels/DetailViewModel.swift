//
//  DetailViewModel.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/25/24.
//

import UIKit

// 다음 화면도 MVVM패턴으로 작성하려면 ViewModel이 있다
final class DetailViewModel {
    
    var music: Music?
    
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    // Output: 뷰를 위한 데이터
    var albumImage: UIImage? {
        didSet {
            onCompleted(albumImage)
        }
    }
    
    var songNameString: String? {
        return music?.songName
    }
    
    var onCompleted: (UIImage?) -> () = { _ in }
    
    // Input (데이터를 변하게하기 위한 로직)
    
    // Logic: 기타 순수 로직 등
    func loadImage() {
        // 옵셔널바인딩해서 URL구조체 만들고
        guard let urlString = self.imageUrl,
              let url = URL(string: urlString) else { return }
        
        // URL구조체를 데이터 생성자에 할당
        // (직접 비동기 처리) Date(contentsOf:)는 동기적으로 구현되어 있기 때문에 글로벌큐에서 실행
        // 이미지로 변환해서 image에 할당
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            
            // 이미지에 표시해주는 건 메인쓰레드로 보내서 처리
            DispatchQueue.main.async {
                self?.albumImage = image
            }
        }
    }
}
