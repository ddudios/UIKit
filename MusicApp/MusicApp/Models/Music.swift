//
//  Music.swift
//  MusicApp
//
//  Created by Suji Jang on 8/16/24.
//

import Foundation

// MARK: - 데이터 모델

// 실제 API에서 받게 되는 정보
struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

// 실제 우리가 사용하게될 음악(Music) 모델 구조체
// 서버에서 가져온 데이터만 표시해주면 되기 때문에 일반적으로 구조체로 만듬
struct Music: Codable {
    let soneName: String?
    let artistName: String?
    let albumName: String?
    let previewUrl: String?
    let imageUrl: String?
    private let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case soneName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewUrl
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
    
    // 출시 정보에 대한 날짜를 계산하기 위해서 계산 속성으로 선언
    // (서버)"2011-07-05T12:00:00Z" => (앱)"yyyy-MM-dd"
    var releaseDateString: String? {
        
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)를 Date 형식으로 변형
        // date(from:): 날짜화하는 메서드
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else { return "" }
        
        let myFormatter = DateFormatter()
        // 원하는 형태 설정
        myFormatter.dateFormat = "yyyy-MM-dd"
        
        // Date형식으로 바꾼 것을 다시 문자열화
        let dateString = myFormatter.string(from: isoDate)
        return dateString
    }
}
