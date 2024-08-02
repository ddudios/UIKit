//
//  DiceManager.swift
//  DiceGame
//
//  Created by Suji Jang on 8/2/24.
//

import UIKit

struct DiceManager {
    
    // 주사위 이미지 배열
    private var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    
    // 주사위 이미지 접근
    func getFirstDice() -> UIImage {
        return diceArray[0]
    }
    
    func getRandomDice() -> UIImage {
        return diceArray[Int.random(in: 0...5)]
    }
}
