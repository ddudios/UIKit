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
    
    // [MVC] 가위바위보 게임(비즈니스 로직)관리를 위한 인스턴스
//    var rpsManager = RPSManager()
    // [MVVM]
    var viewModel = RPSViewModel(rpsManager: RPSManager())
    
    // 데이터를 뷰컨트롤러가 소유
    // 데이터 저장을 위한 변수 (컴퓨터 선택/나의 선택)
//    var comChoice: Rps = Rps.allCases[Int.random(in: 1...3)]
//    var myChoice: Rps = .ready
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 변하는 시점을 전달받기 위한 클로저
        viewModel.onCompleted = { [unowned self] resultString in
            self.mainLabel.text = resultString
            self.comImageView.image = self.viewModel.comRPSimage
            self.comChoiceLabel.text = self.viewModel.comRPStext
            self.myImageView.image = self.viewModel.userRPSimage
            self.myChoiceLabel.text = self.viewModel.userRPStext
        }
        viewModel.reset()
        
        buttonEnabled(resetButton, enabled: false)
        if mainLabel.text == "선택하세요" {
            buttonEnabled(selectButton, enabled: false)
        }
    }

    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        
        // 버튼이 눌렸다는 것을 뷰모델한테 전달 (간단)
        viewModel.rpsButtonTapped()
        
        buttonEnabled(selectButton, enabled: true)
        
        // 가위/바위/보 타이틀 전달
        guard let title = sender.currentTitle else { return }
        viewModel.userGetSelected(title: title)
    }
    
    // 버튼이 눌린것만 뷰모델한테 전달
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        viewModel.selectButtonTapped()
        
        buttonEnabled(myChoiceButton1, enabled: false)
        buttonEnabled(myChoiceButton2, enabled: false)
        buttonEnabled(myChoiceButton3, enabled: false)
        buttonEnabled(selectButton, enabled: false)
        buttonEnabled(resetButton, enabled: true)
    }
    
    // 버튼이 눌린것만 뷰모델한테 전달
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        viewModel.reset()
        
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
    
    /** MVC
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
     **/
}
