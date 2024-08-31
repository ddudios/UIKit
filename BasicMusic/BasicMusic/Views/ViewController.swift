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
        
        // 뷰모델에 접근하기 전에 무조건 필요 (생성)
        self.viewModel = MusicViewModel()
        
        /** 기존에는 뷰모델이 가지고 있는 클로저에 할당
        self.viewModel.onCompleted = { [unowned self] _ in
            DispatchQueue.main.async {
                self.albumNameLabel.text = self.viewModel.albumNameString
                self.songNameLabel.text = self.viewModel.songNameString
                self.artistNameLabel.text = self.viewModel.artistNameString
            }
        }*
        
        // 받아온 music데이터를 가지고 클로저 나중에 호출
        self.viewModel.music.나중에호출될수있는함수 = { [weak self] music in
            DispatchQueue.main.async {
                self?.albumNameLabel.text = music.albumName
                self?.songNameLabel.text = music.songName
                self?.artistNameLabel.text = music.artistName
            }
        }**/
        // viewDidLoad에서 한번 호출은 해야함
        // 왜냐하면 클래스로 감싸져있는 데이터의 클로저에다가 할일을 할당은 해야함
        // 클로저를 할당해줘야지 뷰가 바뀔 수 있다
        // music이 가지고 있는 데이터값이 바뀔때마다 클로저를 호출해야되니까 당연히 한번은 할당해줘야한다
        bindViewModel()
    }
    
    func bindViewModel() {
        // 일반적으로 RXSwift에서는 메서드를 만들어놓는다
        // 여기서의 music은 클래스로감싸진데이터라는 클래스이고 거기에 접근해서 사용
        // 일반적으로 위에서 할당하는 것보다 조금 더 간단해보이도록 구현
        // 둘은 완전히 똑같은 코드인데 바인딩하기라는 메서드를 한번 거쳐서
        // 여기에 구현한 클로저를 나중에호출될수있는함수에 할당
        self.viewModel.music.바인딩하기(콜백함수: { [weak self] music in
            DispatchQueue.main.async {
                self?.albumNameLabel.text = music.albumName
                self?.songNameLabel.text = music.songName
                self?.artistNameLabel.text = music.artistName
            }
        })
    }
    
    // Input: 뷰에서 어떤 일이 발생했을때 전달
    // 인풋메서드 안에서는 데이터(Model)를 변형시키는 일을 한다
    // [MVC] 로직도 ViewController가 가지고 있음
    // [MVVM] ViewModel한테 버튼이 눌린걸 알려주기만 하면됨
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 네트워킹 시작
        viewModel.handleStartButtonTapped()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        viewModel.handleStopButtonTapped()
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
