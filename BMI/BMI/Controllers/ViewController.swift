//
//  ViewController.swift
//  BMI
//
//  Created by Suji Jang on 7/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    // BMI계산과 관련된 로직
    var bmiManager = BMICalculatorManager()
    
    // 데이터 (모델)
    // MVC스럽게 작성하기 위해서 뷰컨트롤러가 모델을 소유하도록 만듦
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm단위로 입력해 주세요"
        weightTextField.placeholder = "kg단위로 입력해 주세요"
    }

    /** 세그웨이로 구현
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        // 세그웨이 실행
    }
    
    // 모두 입력돼야 다음 화면 이동 허락
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력해야 합니다"
            mainLabel.textColor = .red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        mainLabel.textColor = .black
        return true
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            
            guard let height = heightTextField.text,
                  let weight = weightTextField.text else { return }
            secondVC.bmi = bmiManager.getBMI(height: height, weight: weight)
        }
        
        // 데이터를 전달한 다음 TextField 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
     **/
    
    // BMI계산하기 - 버튼 누르면 다음화면
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        // 빈 텍스트필드가 있으면 다음 화면으로 넘어갈 수 없음
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력해야 합니다"
            mainLabel.textColor = .red
        } else {
            mainLabel.text = "키와 몸무게를 입력해 주세요"
            mainLabel.textColor = .black
        }
        
        // 세그웨이가 아닌 코드를 통해서 스토리보드에 접근해서 인스턴스 생성 -> 타입캐스팅
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        
        guard let height = heightTextField.text,
              let weight = weightTextField.text else { return }
        self.bmi = bmiManager.getBMI(height: height, weight: weight)
        
        // 지금 뷰컨트롤러가 가지고있는 모델을 다음화면에 전달
        secondVC.bmi = self.bmi
        
        // 화면 이동
        self.present(secondVC, animated: true)
        
        heightTextField.text = ""
        weightTextField.text = ""
    }
}

extension ViewController: UITextFieldDelegate {
    
    // 숫자만 입력 가능
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        }
        return false
    }
    
    // 엔터키 기능
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    // 화면탭
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
}
