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
    @IBOutlet weak var resetButton: UIButton!
    
    var updownManager = UpDownManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    func reset() {
        mainLabel.text = "선택하세요"
        numberLabel.text = ""
        resetButton.isHidden = true
        selectButton.isHidden = false
        updownManager.resetNum()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        // 1) 버튼의 숫자를 가져와야 함
        guard let numString = sender.currentTitle else { return }
        
        // 2) 숫자 레이블이 숫자에 따라 변하도록
        numberLabel.text = numString
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        guard let myNumString = numberLabel.text,
              let myNumber = Int(myNumString) else { return }
        
        // 1) 컴퓨터의 숫자와 내가 선택한 숫자를 비교 UP / DOWN / BINGO (메인 레이블)
        updownManager.setUserNum(num: myNumber)
        mainLabel.text = updownManager.getUpDownResult()
        
        if mainLabel.text == "Bingo😎" {
            resetButton.isHidden = false
            selectButton.isHidden = true
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        reset()
    }
}
