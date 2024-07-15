//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Suji Jang on 7/10/24.
//

import UIKit

class ViewController: UIViewController {

    // 레이블, 버튼 변수 생성
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    // 초기 화면 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.backgroundColor = UIColor.yellow
    }

    // 버튼 작동시 액션
    @IBAction func buttonPressed(_ sender: UIButton) {
        mainLabel.text = "안녕하세요"
        myButton.backgroundColor = UIColor.yellow
        myButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
    }
}
