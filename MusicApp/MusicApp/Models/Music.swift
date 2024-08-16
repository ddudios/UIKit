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
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case soneName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewUrl
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
}
