//
//  ViewController.swift
//  RPSGame
//
//  Created by Suji Jang on 7/16/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    @IBOutlet weak var myChoiceButton1: UIButton!
    @IBOutlet weak var myChoiceButton2: UIButton!
    @IBOutlet weak var myChoiceButton3: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    // 가위바위보 게임(비즈니스 로직)관리를 위한 인스턴스
    var rpsManager = RPSManager()
    
    // 데이터를 뷰컨트롤러가 소유
    // 데이터 저장을 위한 변수 (컴퓨터 선택/나의 선택)
    var comChoice: Rps = Rps.allCases[Int.random(in: 1...3)]
    var myChoice: Rps = .ready
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getReady()
        buttonEnabled(resetButton, enabled: false)
        
        if myChoice == Rps.ready {
            buttonEnabled(selectButton, enabled: false)
        }
    }

    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        // 가위/바위/보를 선택해서 그 정보를 저장해야 됨
        // 가위바위보중 하나를 선택하면 현재의 타이틀을 가져와서
        guard let title = sender.currentTitle else { return }
        // 메서드를 호출하면 열거형 타입중에 하나의 케이스가 결과로 나온 것을 담는다
        myChoice = selectedRPS(withString: title)
        
        buttonEnabled(selectButton, enabled: true)
    }
    
    // 버튼을 눌렀을때 rpsManager한테 비교 결과를 받아와서 레이블에 표시
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        // 1) 컴퓨터가 랜덤 선택한 것을 이미지뷰에 표시
        // 2) 컴퓨터가 랜덤 선택한 것을 레이블에 표시
        comImageView.image = comChoice.rpsInfo.image
        comChoiceLabel.text = comChoice.rpsInfo.name
        
        // 3) 내가 선택한 것을 이미지 뷰에 표시
        // 4) 내가 선택한 것을 레이블에 표시
        myImageView.image = myChoice.rpsInfo.image
        myChoiceLabel.text = myChoice.rpsInfo.name
        
        // 5) 컴퓨터가 선택한 것과 내가 선택한 것을 비교해서 이겼는지/졌는지 판단해서 표시
        mainLabel.text = rpsManager.getRpsResult(comChoice: self.comChoice, myChoice: self.myChoice)
        
        buttonEnabled(myChoiceButton1, enabled: false)
        buttonEnabled(myChoiceButton2, enabled: false)
        buttonEnabled(myChoiceButton3, enabled: false)
        buttonEnabled(selectButton, enabled: false)
        buttonEnabled(resetButton, enabled: true)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        getReady()
        comChoice = Rps.allCases[Int.random(in: 1...3)]
        buttonEnabled(myChoiceButton1, enabled: true)
        buttonEnabled(myChoiceButton2, enabled: true)
        buttonEnabled(myChoiceButton3, enabled: true)
        buttonEnabled(resetButton, enabled: false)
    }
    
    func buttonEnabled(_ button: UIButton, enabled: Bool) {
        if enabled {
            button.isEnabled = true
            switch button {
            case selectButton:
                button.backgroundColor = .link
            case resetButton:
                button.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
            default:
                button.backgroundColor = .systemGreen
            }
        } else {
            button.isEnabled = false
            button.backgroundColor = .gray
        }
    }
    
    // 아래 코드들은 RPSManager에 넣어도 된다
    // 본인이 생각하는 기준에 따라서 만들면 된다
    
    // 초기화 코드
    func getReady() {
        // 1) 컴퓨터의 선택 이미지 뷰에 다시 준비 이미지 표시
        // 2) 컴퓨터의 선택 레이블에 준비라고 표시
        comImageView.image = Rps.ready.rpsInfo.image
        comChoiceLabel.text = Rps.ready.rpsInfo.name
        
        // 3) 나의 선택 이미지 뷰에 준비 이미지 표시
        // 4) 나의 선택 레이블에 준비 문자열을 표시
        myImageView.image = Rps.ready.rpsInfo.image
        myChoiceLabel.text = Rps.ready.rpsInfo.name
        
        // 5) 메인 레이블 "선택하세요" 표시
        mainLabel.text = "선택하세요"
    }
    
    // 가위바위보 선택
    func selectedRPS(withString name: String) -> Rps {
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
