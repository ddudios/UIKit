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
    private init() {}
}
