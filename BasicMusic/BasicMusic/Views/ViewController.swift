//
//  ViewController.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/23/24.
//

import UIKit

// [MVVM] 뷰컨트롤러는 뷰모델을 가진다
final class ViewController: UIViewController {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // 데이터(모델): Music
    // [MVC] 일반적으로 ViewController가 가지고 있음
    // [MVVM] ViewModel이 가지고 있음
    var viewModel = MusicViewModel()  // 의존성 O
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.onCompleted = {
            self.configureUI()
        }
    }
    
    func setupUI() {
        startButton.isHidden = false
        nextButton.isHidden = true
    }
    
    // 뮤직데이터를 화면에 표시
    func configureUI() {
        DispatchQueue.main.async {
            self.albumNameLabel.text = self.viewModel.albumNameString
            self.songNameLabel.text = self.viewModel.songNameString
            self.artistNameLabel.text = self.viewModel.artistNameString
            
            self.startButton.isHidden = true
            self.nextButton.isHidden = false
        }
    }
    
    // Input: 뷰에서 어떤 일이 발생했을때 전달
    // 인풋메서드 안에서는 데이터(Model)를 변형시키는 일을 한다
    // [MVC] 로직도 ViewController가 가지고 있음
    // [MVVM] ViewModel한테 버튼이 눌린걸 알려주기만 하면됨
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 네트워킹 시작
        viewModel.handleButtonTapped()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let music = self.viewModel.music else { return }
        
        // 스토리보드에 DetailVC아이디를 가진 객체의 인스턴스 생성
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailVC.modalPresentationStyle = .fullScreen
        
        // 다음 화면에서 필요한 데이터 전달
        detailVC.imageUrl = music.imageUrl
        detailVC.songName = music.songName
        
        // 다음화면으로 이동
        self.present(detailVC, animated: true)
    }
    
}

// [MVC] 네트워킹 관련 함수도 뷰컨트롤러가 가지고 있음 (일반적으로 분리)
//extension ViewController {}
