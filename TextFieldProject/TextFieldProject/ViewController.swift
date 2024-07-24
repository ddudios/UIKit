//
//  ViewController.swift
//  TextFieldProject
//
//  Created by Suji Jang on 7/23/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor.gray
        
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.returnKeyType = .next
        
        textField.becomeFirstResponder()
    }
    
    // 화면의 탭을 감지하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // view 전체 종료
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드에 입력을 시작했다")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 한글자마다 호출, 허락
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 숫자 입력X
        if Int(string) != nil {
            return false
        } else {
            // 10글자 이상 입력X
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
    }
    
    // 텍스트필드가 비어있으면 리턴되지 않도록 구현
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        if textField.text == "" {
            textField.placeholder = "Type Something!"
            return false
        } else {
            return true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 입력이 끝나는 시점
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드의 입력을 끝냈다")
        
        // 텍스트필드의 입력이 끝나면 다시 빈칸으로 바꾸기
        textField.text = ""
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        // 텍스트필드 종료
        textField.resignFirstResponder()
    }
    
}
