//
//  ViewController.swift
//  BMI
//
//  Created by Suji Jang on 7/30/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    // 데이터 + (로직) => 뷰모델
    // MVVM패턴에서 ViewController는 ViewModel을 소유한다
    // Non-optional타입으로 만들면 저장속성을 생성자에 만들어야 한다
    var viewModel: BMIViewModel
    
    // 스토리보드로 만들었을때 뷰컨트롤러의 생성자 코드
    // coder: 스토리보드를 통해서 생성할때 필요한 인자
    // viewModel: 외부에서 주입하고싶은 저장속성을 받아서 주입시킬 수 있게 생성자를 만듦
    init(coder: NSCoder, viewModel: BMIViewModel) {
        self.viewModel = viewModel
        
        // super.init 반드시 호출
        super.init(coder: coder)!
    }
    
    // 뷰컨트롤러의 생성자를 구현하면 필수생성자도 구현해야한다
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 라이프사이클
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.resetBMI()
        setupMainText()
    }
    
    func setup() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        // 텍스트필드에 입력이 일어날 때마다 함수 실행
        heightTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    func configureUI() {
        viewModel.resetBMI()
        setupMainText()
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm단위로 입력해 주세요"
        weightTextField.placeholder = "kg단위로 입력해 주세요"
    }
    
    // BMI계산하기 - 버튼 누르면 다음화면
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        // 스토리보드, 뷰컨트롤러 전달
        // ViewController()로 새로운 인스턴스를 만들어서 전달하면 안되고
        // 현재 메모리에 올라가있는 self를 전달해야 제대로 동작하게 만들 수 있다
        // 버튼이 눌리면 뷰모델을 호출하고 -> 뷰모델이 가지고있는 메서드 호출
        viewModel.handleButtonTapped(storyboard: self.storyboard, fromCurrentVC: self, animated: true)
        
        setupMainText()
        
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    func setupMainText() {
        mainLabel.text = viewModel.mainTextString
        mainLabel.textColor = viewModel.mainLabelTextColor
    }
    
    // 텍스트필드 입력값이 변할때마다 호출
    // 뷰모델에 알려주기 위함
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        
        // 뷰에 텍스트필드가 2개 있는데 거기에 글자를 입력할때마다
        // 뷰컨트롤러에서 전체를 처리하는게 아니고 뷰모델한테 전달해야한다
        if textField == heightTextField {
            viewModel.setHeightTextField(textField.text ?? "")
        }
        if textField == weightTextField {
            viewModel.setWeightTextField(textField.text ?? "")
        }
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
