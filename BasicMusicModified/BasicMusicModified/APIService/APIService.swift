//
//  APIService.swift
//  BasicMusicModified
//
//  Created by Suji Jang on 8/24/24.
//

import UIKit

// 의존성 주입
protocol NetworkType {
    func fetchMusic(completion: @escaping (Result<[Music], NetworkError>) -> ())
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> ())
}

// 일부로 싱글톤으로 구현 안함 (네트워킹 객체 - 일반적으로 싱글톤으로 구현)
final class APIService: NetworkType {
    func fetchMusic(completion: @escaping (Result<[Music], NetworkError>) -> ()) {
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
//                let music = musicData.results.last
                completion(.success(musicData.results))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> ()) {
        guard let urlString = imageUrl,
              let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            // 이미지로 제대로 변환이 된 경우
            completion(image)
            return
        }
    }
    
}
