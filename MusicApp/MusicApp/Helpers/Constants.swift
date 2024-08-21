//
//  Constants.swift
//  MusicApp
//
//  Created by Suji Jang on 8/15/24.
//

import UIKit

// MARK: - Name Space

// 사용하게될 API 문자열 묶음
public enum MusicApi {
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "mdeia=music"
}

// 사용하게될 Cell 문자열 묶음
public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    static let savedMusicCellIdentifier = "SavedMusicCell"
    private init() {}
}

// 컬렉션뷰 구성을 위한 설정
public struct CVCell {
    static let spacingWidth: CGFloat = 1  // 간격
    static let cellColumns: CGFloat = 3  // 한줄에 보일 컨텐츠 개수
    private init() {}
}
