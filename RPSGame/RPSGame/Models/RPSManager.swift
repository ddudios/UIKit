//
//  RPSManager.swift
//  RPSGame
//
//  Created by Suji Jang on 8/2/24.
//

import Foundation

struct RPSManager {
    private var comChoice: Rps = Rps(rawValue: Int.random(in: 1...3))!
    private var myChoice: Rps = .ready
    
    // 준비상태
    func getReady() -> Rps {
        return Rps.ready
    }
    
    // 유저 선택
    func getUserRPS() -> Rps {
        return myChoice
    }
    
    // 컴퓨터 선택
    func getComputerRps() -> Rps {
        return comChoice
    }
    
    // 유저 선택에 따른 열거형값
    mutating func userGetSelected(name: String) {
        switch name {
        case "가위":
            myChoice = Rps.scissors
        case "바위":
            myChoice = Rps.rock
        case "보":
            myChoice = Rps.paper
        default:
            myChoice = Rps.ready
        }
    }
    
    func getRpsResult() -> String {
        if comChoice == myChoice {
            return "비겼다"
        } else if comChoice == .rock && myChoice == .paper {
            return "이겼다"
        } else if comChoice == .paper && myChoice == . scissors {
            return "이겼다"
        } else if comChoice == .scissors && myChoice == .rock {
            return "이겼다"
        } else {
            return "졌다"
        }
    }
    
    mutating func allReset() {
        comChoice = Rps(rawValue: Int.random(in: 1...3))!
        myChoice = .ready
    }
}
