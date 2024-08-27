//
//  SecondViewController.swift
//  BMI
//
//  Created by Suji Jang on 7/30/24.
//

import UIKit

final class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 전화면에서 전달받은 BMI를 저장하기위한 변수
    var viewModel: BMIViewModel
    
    // 스토리보드 커스텀 생성자
    init(coder: NSCoder, viewModel: BMIViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        setup()
    }
    
    func makeUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backButton.setTitle("다시 계산하기", for: .normal)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
    }
    
    func setup() {
        self.bmiNumberLabel.text = viewModel.bmiNumberString
        self.adviceLabel.text = viewModel.bmiAdviceString
        bmiNumberLabel.backgroundColor = viewModel.bmiColor
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.viewModel.resetBMI()
        self.dismiss(animated: true)
    }
}
