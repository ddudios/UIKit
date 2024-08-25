//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/24/24.
//

import Foundation

// ViewModel이 Model(데이터)을 가지는게 MVVM의 핵심
class MusicViewModel {
    
    // ⭐️ 핵심 데이터(모델): 뷰모델이 가지고 있음
    // Model: 실질적인 데이터를 가지고 있음
    var music: Music? {
        didSet {
            // 데이터가 담긴 시점에 didSet을 통해서 클로저를 호출하니까 클로저한테 시점을 알려준다
            // ViewController에서 클로저에 할일 할당
            onCompleted()
        }
    }
    
    // 함수를 담을 수 있는 변수 생성
    // 옵셔널 타입으로 선언해도되고 기본함수를 담아놓아도 된다
//    var onCompleted: (() -> ())?
    var onCompleted: () -> () = {}
    
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
    
    // 버튼이 눌렸을때 어떻게 다룰지에 대한 메서드
    // View에서 버튼이 눌렸다를 전달받음
    func handleButtonTapped() {
        fetchMusic { [unowned self] result in
            switch result {
            case .success(let music):
                // 데이터 생성 완료 (API를 통해 다운로드 -> 파싱 완료된)
                self.music = music
            case .failure(.dataError):
                print("데이터 에러")
            case .failure(.networkingError):
                print("네트워킹 에러")
            case .failure(.parseError):
                print("파싱 에러")
            }
        }
    }
    
    // Logic:
    // MVC패턴에서 ViewController에 존재하던 로직들을
    // 다 분리시켜서 MVVM패턴의 ViewModel에 넣는다
    func fetchMusic(completion: @escaping (Result<Music?, NetworkError>) -> ()) {
        // 네트워킹 관련 로직 (비동기)
        // 코드를 분리하려고 하는 거기 때문에 네트워킹 관련 로직도
        // 역할, 책임이 분리되어있다고 볼 수 있으니까 뷰모델과 네트워킹모델을 분리해서
        // 뷰모델에서 var apiService = APIService()를 소유하도록 만들 수 있다
        let urlString = "https://itunes.apple.com/search?mdeia=music&term=jazz"
        let url = URL(string: urlString)!
        
        // URLSession을 사용해서 데이터가 생기고
        URLSession.shared.dataTask(with: url) { data, reponse, error in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let musicData = try JSONDecoder().decode(MusicData.self, from: safeData)
                
                // MusicData의 results속성에 접근하면 Music배열이 있다
                // 그 배열중에서 가장 마지막에 있는 음악을 꺼내서 반환
                let music = musicData.results.last
                completion(.success(music))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
}
