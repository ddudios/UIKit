//
//  MusicCell.swift
//  MusicApp
//
//  Created by Suji Jang on 8/16/24.
//

import UIKit

class MusicCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // 이미지 URL을 전달받는 속성
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    // 셀이 재사용되기 전에 호출되는 메서드 (셀 재사용 준비)
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // ⭐️ 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행
        self.mainImageView.image = nil
    }
    
    func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
        
        // 비동기 처리
        DispatchQueue.global().async {
            
            // Data(contentsOf: URL) URL로 서버랑 통신해서 데이터를 받아오는 생성자 (동기적으로 처리)
            // 일반적으로 이미지URL을 가지고 데이터로 변형하는 코드를 URLSession을 직접적으로 쓰지 않고 이런 식으로 많이 사용한다
            // 에러를 던질 수 있음
            guard let data = try? Data(contentsOf: url) else { return }
            
            // ⭐️ 오래 걸리는 작업이 일어나고 있는 동안에 URL이 바뀔 가능성 제거
            // imageUrl에 들어있는 문자열인 urlString과 구조체URL로 변형한 문자열이 같은지 확인
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
}
