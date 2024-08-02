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
    
    var rpsManager = RPSManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) 첫번째/두번째 이미지뷰에 준비(묵) 이미지를 띄워야 함
        comImageView.image = rpsManager.getReady().rpsInfo.image
        myImageView.image = rpsManager.getReady().rpsInfo.image
        // 2) 첫번째/두번째 레이블에 "준비" 문자열을 띄워야 함
        comChoiceLabel.text = rpsManager.getReady().rpsInfo.name
        myChoiceLabel.text = rpsManager.getReady().rpsInfo.name
        
        resetButton.isEnabled = false
        resetButton.backgroundColor = .gray
        
        if rpsManager.getUserRPS() == Rps.ready {
            selectButton.isEnabled = false
            selectButton.backgroundColor = .gray
        }
    }

    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        // 가위/바위/보를 선택해서 그 정보를 저장해야 됨
        guard let title = sender.currentTitle else { return }
        rpsManager.userGetSelected(name: title)
        
        selectButton.isEnabled = true
        selectButton.backgroundColor = .link
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        // 1) 컴퓨터가 랜덤 선택한 것을 이미지뷰에 표시
        // 2) 컴퓨터가 랜덤 선택한 것을 레이블에 표시
        comImageView.image = rpsManager.getComputerRps().rpsInfo.image
        comChoiceLabel.text = rpsManager.getComputerRps().rpsInfo.name
        
        // 3) 내가 선택한 것을 이미지 뷰에 표시
        // 4) 내가 선택한 것을 레이블에 표시
        myImageView.image = rpsManager.getUserRPS().rpsInfo.image
        myChoiceLabel.text = rpsManager.getUserRPS().rpsInfo.name
        
        // 5) 컴퓨터가 선택한 것과 내가 선택한 것을 비교해서 이겼는지/졌는지 판단해서 표시
        mainLabel.text = rpsManager.getRpsResult()
        
        myChoiceButton1.isEnabled = false
        myChoiceButton1.backgroundColor = .gray
        myChoiceButton2.isEnabled = false
        myChoiceButton2.backgroundColor = .gray
        myChoiceButton3.isEnabled = false
        myChoiceButton3.backgroundColor = .gray
        selectButton.isEnabled = false
        selectButton.backgroundColor = .gray
        resetButton.isEnabled = true
        resetButton.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 1) 컴퓨터의 선택 이미지 뷰에 다시 준비 이미지 표시
        // 2) 컴퓨터의 선택 레이블에 준비라고 표시
        comImageView.image = rpsManager.getReady().rpsInfo.image
        comChoiceLabel.text = rpsManager.getReady().rpsInfo.name
        
        // 3) 나의 선택 이미지 뷰에 준비 이미지 표시
        // 4) 나의 선택 레이블에 준비 문자열을 표시
        myImageView.image = rpsManager.getReady().rpsInfo.image
        myChoiceLabel.text = rpsManager.getReady().rpsInfo.name
        
        // 5) 메인 레이블 "선택하세요" 표시
        mainLabel.text = "선택하세요"
        
        // 6) 컴퓨터가 다시 랜덤 가위/바위/보를 선택하고 저장
        rpsManager.allReset()
        
        myChoiceButton1.isEnabled = true
        myChoiceButton1.backgroundColor = .systemGreen
        myChoiceButton2.isEnabled = true
        myChoiceButton2.backgroundColor = .systemGreen
        myChoiceButton3.isEnabled = true
        myChoiceButton3.backgroundColor = .systemGreen
        resetButton.isEnabled = false
        resetButton.backgroundColor = .gray
    }
}
