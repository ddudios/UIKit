//
//  RPSViewModel.swift
//  RPSGame
//
//  Created by Suji Jang on 8/26/24.
//

import UIKit

class RPSViewModel {
    var rpsManager: RPSManagerProtocol  // = RPSManager()
    
    // 뷰를 위한 데이터(모델)
    // result 변화 감지해서 클로저 호출
    private var result: String = "선택하세요" {
        didSet {
            // 시점을 전달하기 위한 클로저
            onCompleted(result)
        }
    }
    
    private var comChoice: Rps = Rps.ready
    private var myChoice: Rps = Rps.ready
    
    // Output: 뷰와 1:1매칭
    // 데이터를 가공해서 보여주는 계산속성
    var resultString: String {
        return result
    }
    
    var comRPSimage: UIImage {
        return comChoice.rpsInfo.image
    }
    
    var comRPStext: String {
        return comChoice.rpsInfo.name
    }
    
    var userRPSimage: UIImage {
        return myChoice.rpsInfo.image
    }
    
    var userRPStext: String {
        return myChoice.rpsInfo.name
    }
    
    var onCompleted: (String) -> () = { _ in }
    
    // 의존성 주입할 수 있도록
    // ViewModel이 생길때 RPSManager를 할당할 수 있음
    init(rpsManager: RPSManagerProtocol) {
        self.rpsManager = rpsManager
    }
    
    // Input: 화면에서 어떤 일이 발생하면 전달
    func reset() {
        comChoice = Rps.ready
        myChoice = Rps.ready
        result = "선택하세요"
    }
    
    // 가위바위보 버튼이 눌렸을때
    func rpsButtonTapped() {
        comChoice = Rps.allCases[Int.random(in: 1...3)]
    }
    
    // 유저의 선택 저장
    func userGetSelected(title: String) {
        myChoice = selectedRPS(withString: title)
    }
    
    // 가위바위보 결과
    func selectButtonTapped() {
        result = rpsManager.getRpsResult(comChoice: comChoice, myChoice: myChoice)
    }
    
    // Logic
    // 뷰모델에 넣어도되고 PRSManager에 넣어도 된다
    private func selectedRPS(withString name: String) -> Rps {
        switch name {
        case "가위":
            return Rps.scissors
        case "바위":
            return Rps.rock
        case "보":
            return Rps.paper
        default:
            return Rps.ready
        }
    }
}
