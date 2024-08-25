//
//  DetailViewController.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/23/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    
    var viewModel: DetailViewModel!
    
    // 데이터(모델)
    // [MVC] 일반적으로 뷰컨트롤러가 가지고 있음
//    var imageUrl: String?
//    var songName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        self.viewModel.onCompleted = { [unowned self] albumImage in
                self.mainImageView.image = albumImage
        }
        self.songNameLabel.text = self.viewModel.songNameString
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// 이미지 다운로드하는 메서드 구현
// 네트워킹 코드를 따로 분리하지 않고 확장에 구현
//extension DetailViewController {}
