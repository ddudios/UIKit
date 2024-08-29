//
//  APIService.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/29/24.
//

import Foundation

struct APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchMusic(completion: @escaping (Result<[Music]?, NetworkError>) -> ()) {
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
                completion(.success(musicData.results))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
}
