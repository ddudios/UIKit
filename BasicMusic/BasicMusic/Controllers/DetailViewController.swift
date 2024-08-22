//
//  DetailViewController.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/23/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    
    // 데이터(모델) (일반적으로 뷰컨트롤러가 가지고 있음)
    var imageUrl: String?
    var songName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadImage()  // 화면에 들어오면 다운로드 시작
    }
    
    func configureUI() {
        self.songNameLabel.text = self.songName
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension DetailViewController {
    // 이미지 다운로드하는 메서드 구현
    // 네트워킹 코드를 따로 분리하지 않고 확장에 구현
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
                self?.mainImageView.image = image
            }
        }
    }
}
