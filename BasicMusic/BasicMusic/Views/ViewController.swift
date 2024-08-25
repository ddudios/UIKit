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
//    var viewModel = MusicViewModel()  // 의존성 O
    var viewModel: MusicViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        viewModel.onCompleted = {
//            self.configureUI()
//        }
        
        // 뷰모델에 접근하기 전에 무조건 필요 (생성)
        self.viewModel = MusicViewModel()
        
        // 데이터 변경이 완료된 후 클로저에서 어떤 일을 할지 정의 (할당)
        self.viewModel.onCompleted = { [unowned self] _ in
            DispatchQueue.main.async {
                self.albumNameLabel.text = self.viewModel.albumNameString
                self.songNameLabel.text = self.viewModel.songNameString
                self.artistNameLabel.text = self.viewModel.artistNameString
                
                self.startButton.isHidden = true
                self.nextButton.isHidden = false
            }
        }
    }
    
    func setupUI() {
        startButton.isHidden = false
        nextButton.isHidden = true
    }
    
    // 뮤직데이터를 화면에 표시
//    func configureUI() {
//        DispatchQueue.main.async {
//            self.albumNameLabel.text = self.viewModel.albumNameString
//            self.songNameLabel.text = self.viewModel.songNameString
//            self.artistNameLabel.text = self.viewModel.artistNameString
//            
//            self.startButton.isHidden = true
//            self.nextButton.isHidden = false
//        }
//    }
    
    // Input: 뷰에서 어떤 일이 발생했을때 전달
    // 인풋메서드 안에서는 데이터(Model)를 변형시키는 일을 한다
    // [MVC] 로직도 ViewController가 가지고 있음
    // [MVVM] ViewModel한테 버튼이 눌린걸 알려주기만 하면됨
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 네트워킹 시작
        viewModel.handleButtonTapped()
    }
    
    // [MVC] 다음 화면에 필요한 데이터를 전달하고 그냥 다음 화면으로 가면 된다
    // [MVVM] 다음 화면이 뷰모델을 가지니까 뷰모델을 전달해야한다
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard viewModel.music != nil else { return }
        
        /** [원칙] 뷰모델을 생성할때 뷰모델한테 데이터 전달해줘야 한다 =========
        // ⭐️ 다음 화면의 뷰컨트롤러가 가져야하는 뷰모델
        let detailVM = DetailViewModel()
        
        // ⭐️ 뷰모델이 가져야하는 데이터
        // 이화면이 가지고 있는 뷰모델로부터
        // 전달받아야하는 다음화면 뷰모델의 데이터를 전달
        detailVM.music = self.viewModel.music
        detailVM.imageUrl = self.viewModel.music?.imageUrl
        ===================================================== **/
        
        // [일반적으로]
        // 이 화면의 뷰모델에 메서드를 만들어서 호출만 하면 다음화면에 뷰모델이 전달된다
        let detailVM = viewModel.getDetailViewModel()
        
        // ⭐️ 다음 화면 뷰컨트롤러(인스턴스)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        
        // 다음 화면에서 필요한 데이터 전달
//        detailVC.imageUrl = music.imageUrl
//        detailVC.songName = music.songName
        // ⭐️ 뷰모델 전달: viewDidLoad호출되기 전에 전달
        // 이화면의 데이터를 할당한 뷰모델을 다음화면의 뷰컨트롤러에 있는 해당 뷰모델에 할당
        detailVC.viewModel = detailVM
        
        // 다음화면으로 이동
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true)
    }
    
}

// [MVC] 네트워킹 관련 함수도 뷰컨트롤러가 가지고 있음 (일반적으로 분리)
//extension ViewController {}
