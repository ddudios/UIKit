//
//  UpDownManager.swift
//  UpDownGame
//
//  Created by Suji Jang on 8/2/24.
//

import Foundation

struct UpDownManager {
    private var comNumber = Int.random(in: 1...10)
    private var myNumber = 0
    
    mutating func resetNum() {
        comNumber = Int.random(in: 1...10)
        myNumber = 0
    }
    
    mutating func setUserNum(num: Int) {
        myNumber = num
    }
    
    func getUpDownResult() -> String {
        if comNumber > myNumber {
            return "Up"
        } else if comNumber < myNumber {
            return "Down"
        } else {
            return "Bingo😎"
        }
    }
}
