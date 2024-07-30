//
//  SecondViewController.swift
//  BMI
//
//  Created by Suji Jang on 7/30/24.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var bmiNumber: Double?
    var adviceString: String?
    var bmiColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backButton.setTitle("다시 계산하기", for: .normal)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        
        guard let bmiNumber else { return }
        bmiNumberLabel.text = String(bmiNumber)
        
        adviceLabel.text = adviceString
        bmiNumberLabel.backgroundColor = bmiColor
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
