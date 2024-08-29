//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/24/24.
//

import Foundation

// ViewModel이 Model(데이터)을 가지는게 MVVM의 핵심
final class MusicViewModel {
    
    // 타이머를 다루기 위한 변수
    var timer: Timer?
    
    // ⭐️ 핵심 데이터(모델): 뷰모델이 가지고 있음
    // Model: 실질적인 데이터를 가지고 있음
    var music: Music? {
        didSet {
            // 데이터가 담긴 시점에 didSet을 통해서 클로저를 호출하니까 클로저한테 시점을 알려준다
            // ViewController에서 클로저에 할일 할당
            onCompleted(music)
        }
    }
    
    // 함수를 담을 수 있는 변수 생성
    // 옵셔널 타입으로 선언해도되고
//    var onCompleted: ((Music?) -> Void)?
    // 아무 일도 하지 않는 기본 클로저를 할당해도 된다
    // 이 뷰모델이 생성될때 저장속성을 메모리에 올리니까
    // 그 순간에 기본적인 클로저를 만들어서 할당
    var onCompleted: (Music?) -> () = { _ in }
    
    // Output:
    // View가 가져야될 데이터의 모습들과 밀접하게 연관시키고
    // 실질적인 데이터를 다시 가공해서 뿌려준다
    var albumNameString: String? {
        return music?.albumName
    }
    
    var songNameString: String? {
        return music?.songName
    }
    
    var artistNameString: String? {
        return music?.artistName
    }
    
    // Input: 데이터를 변하게 하기위한 로직
    // View에서 버튼이 눌렸다를 전달받음
    // 타이머를 활용해 1초마다 네트워킹
    func handleStartButtonTapped() {
        // 기존에 실행되던게 있으면 타이머에서 일단 종료
        timer?.invalidate()
        
        // 버튼을 누르면 타이머를 실행시켜서 1초마다 fetchMusic실행
        // -> 1초마다 music의 didSet호출 -> onCompleted 클로저 호출
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetchNewMusic), userInfo: nil, repeats: true)
    }
    
    func handleStopButtonTapped() {
        timer?.invalidate()
        timer = nil
    }
    
    // Logic:
    // MVC패턴에서 ViewController에 존재하던 로직들을
    // 다 분리시켜서 MVVM패턴의 ViewModel에 넣는다
    @objc func fetchNewMusic() {
        // 네트워킹은 싱글톤으로 구현
        APIService.shared.fetchMusic { [unowned self] result in
            switch result {
            case .success(let music):
                // 데이터 생성 완료 (API를 통해 다운로드 -> 파싱 완료된)
                // 음악 데이터를 랜덤으로
                self.music = music?.randomElement()
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
    
    deinit {
        timer = nil
    }
    
    // 다음화면을 위한 뷰모델을 생성할 수 있는 메서드 생성
    func getDetailViewModel() -> DetailViewModel {
        // 다음화면의 뷰모델 생성
        let detailVM = DetailViewModel()
        
        // 데이터 전달
        detailVM.music = self.music
        detailVM.imageUrl = self.music?.imageUrl
        
        return detailVM
    }
}
