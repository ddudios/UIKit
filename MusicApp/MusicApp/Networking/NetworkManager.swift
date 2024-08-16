//
//  NetworkManager.swift
//  MusicApp
//
//  Created by Suji Jang on 8/16/24.
//

import Foundation

// MARK: - 네트워크에서 발생할 수 있는 에러 정의

enum NetworkError: Error {
    case networkingError
    case dataError
    case httpRequestError
    case parseError
}


// MARK: - Networking (서버와 통신하는) 클래스 모델

final class NetworkManager {
    
    // 여러화면에서 통신을 한다면 일반적으로 싱글톤으로 만듬
    static let shared = NetworkManager()
    
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    //let musicURL = "https://itunes.apple.com/search?mdeia=music&term=jazz"
    
    // Result타입 자체가 내부에다가 제네릭 문법으로
    // 성공케이스에서는 [Music]을 담고 실패케이스에서는 네트워크에러를 담을 수 있다고 연관값을 정의
    typealias NetworkComplition = (Result<[Music], NetworkError>) -> Void
    
    // 네트워킹 요청하는 함수 (음악데이터 가져오기)
    func fetchMusic(searchTerm: String, complition: @escaping NetworkComplition) {
        
        let urlString = "\(MusicApi.requestUrl)\(MusicApi.mediaParam)&term=\(searchTerm)"
        
        performRequest(with: urlString) { result in
            complition(result)
        }
    }
    
    // Request 함수 (비동기적 실행 => 클로저 방식으로 끝난 시점을 전달 받도록 설계)
    private func performRequest(with urlString: String, complition: @escaping NetworkComplition) {
        
        guard let url = URL(string: urlString) else { return }
        
        // GET
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            // dataTask 에러
            guard error == nil else {
                print(error!)
                complition(.failure(.networkingError))
                return
            }
            
            // 옵셔널 바인딩
            guard let safeData = data else {
                complition(.failure(.dataError))
                return
            }
            
            // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                complition(.failure(.httpRequestError))
                return
            }
            
            // parseJSON메서드 실행해서 결과 받음
            if let musics = self.parseJSON(safeData) {
                print("Parse 실행")
                complition(.success(musics))
            } else {
                print("Parse 실패")
                complition(.failure(.parseError))
            }
        }
        task.resume()
    }
    
    // 받아온 데이터를 분석하는 함수 (동기적 실행)
    private func parseJSON(_ musicData: Data) -> [Music]? {
        
        do {
            // 만들어 놓은 구조체/클래스로 변환
            // JSON 데이터 => MusicData 구조체
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
