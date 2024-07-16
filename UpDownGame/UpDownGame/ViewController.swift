//
//  ViewController.swift
//  UpDownGame
//
//  Created by Suji Jang on 7/16/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    var comNumber = Int.random(in: 1...10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) 메인 레이블에 "선택하세요"
        mainLabel.text = "선택하세요"
        
        // 2) 숫자 레이블은 ""(아무 표시 안함)
        numberLabel.text = ""
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        // 1) 버튼의 숫자를 가져와야 함
        guard let numString = sender.currentTitle else { return }
        
        // 2) 숫자 레이블이 숫자에 따라 변하도록
        numberLabel.text = numString
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        guard let myNumString = numberLabel.text else { return }
        guard let myNumber = Int(myNumString) else { return }
        
        // 1) 컴퓨터의 숫자와 내가 선택한 숫자를 비교 UP / DOWN / BINGO (메인 레이블)
        if comNumber > myNumber {
            mainLabel.text = "Up"
        } else if comNumber < myNumber {
            mainLabel.text = "Down"
        } else {
            mainLabel.text = "Bingo😎"
            selectButton.isHidden = true
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 1) 메인 레이블이 다시 "선택하세요"
        mainLabel.text = "선택하세요"
        
        // 2) 숫자 레이블을 다시 ""(빈 문자열)
        numberLabel.text = ""
        
        // 3) 컴퓨터의 랜덤 숫자를 다시 선택
        comNumber = Int.random(in: 1...10)
        
        selectButton.isHidden = false
    }
}
