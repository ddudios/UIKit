//
//  main.swift
//  RandomBingo
//
//  Created by Suji Jang on 7/16/24.
//

import Foundation

var computerChoice = Int.random(in: 1...100)
var myChoice: Int = 0

// 입력값을 계속 읽어올 수 있도록 while true문 사용
while true {
    var userInput = readLine()
    
    if let input = userInput {
        if let number = Int(input) {
            myChoice = number
        }
    }
    
    if computerChoice > myChoice {
        print("Up")
    } else if computerChoice < myChoice {
        print("Down")
    } else {
        print("Bingo")
        break
    }
}
