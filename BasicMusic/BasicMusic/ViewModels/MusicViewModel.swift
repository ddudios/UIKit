//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/24/24.
//

import Foundation

// ViewModel이 Model(데이터)을 가지는게 MVVM의 핵심
final class MusicViewModel {
    /**바인딩의 구현 방법 - 클로저 (함수호출)
    // 핵심 데이터(모델): 뷰모델이 가지고 있음
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
    
    // Output
    // 음악데이터가 변했을때 바뀐 모습을 뷰에 보여줄거니까
    // 계산속성으로 구현한 1:1매칭 데이터도 지움
    var albumNameString: String? {
        return music?.albumName
    }
    
    var songNameString: String? {
        return music?.songName
    }
    
    var artistNameString: String? {
        return music?.artistName
    }
     **/
    
    // 타이머를 다루기 위한 변수
    var timer: Timer?
    
    // 핵심 데이터(모델): 뷰모델이 가지고 있음
    // Music데이터를 클래스로 감싼다는 뜻
    // 초기값은 음악데이터를 생성해서 가지는 인스턴스 생성
    // music저장속성에 클래스타입 할당
    // 클래스타입 내부에 제네릭타입으로 Music데이터를 가지고 있는 형태
    // 기존에는 var music: Music?이었는데 -> 제네릭타입으로 선언해서 클래스로 감쌌을 뿐이다
    var music: 클래스로감싸진데이터<Music> = 클래스로감싸진데이터(Music(songName: nil, artistName: nil, albumName: nil, imageUrl: nil))
    
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
        APIService.shared.fetchMusic { [weak self] result in
            switch result {
            case .success(let music):
                // 데이터 생성 완료 (API를 통해 다운로드 -> 파싱 완료된)
                // Music데이터를 직접적으로 할당할 수 없다
                // 음악 데이터를 랜덤으로 무조건 가져온다고 옵셔널바인딩
                let randomMusic = music?.randomElement()!
                
                // music은 클래스로감싼타입 (Observable파일에 있음)
                // 데이터값 저장속성에 Music(T)을 넣기로 했으니까 그걸 활용
                // self?.클래스로감싼타입.내부저장속성 에 랜덤음악 할당
                self?.music.데이터값 = randomMusic!
                
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
        detailVM.music = self.music.데이터값
        detailVM.imageUrl = self.music.데이터값.imageUrl
        
        return detailVM
    }
}
