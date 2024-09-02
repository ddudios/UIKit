//
//  BindingTextField.swift
//  LoginMVVM
//
//  Created by Suji Jang on 9/1/24.
//

import UIKit

// 기존의 UITextField상속해서 바인딩기능이 있는 텍스트필드 클래스 구현 (기능 추가)
// 뷰에서 유저가 입력할 때마다 -> 데이터가 바뀌게 만들 수 있다
class 바인딩기능있는텍스트필드: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // addTarget => 메서드 호출
    // 바인딩기능텍스트필드는 생성될때부터 addTarget기능을 가지고 있다
    // 글자가 할때마다 메서드를 호출하는 기능
    private func commonAddTarget() {
        self.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    // 글자가 변할때마다 호출되는 메서드
    @objc func textFieldDidChanged(_ textField: UITextField) {
        if let text = textField.text {
            // 텍스트필드의 글자를 input으로 받는 함수 호출
            나중에호출될수있는함수(text)
        }
    }
    
    // 텍스트필드를 통해서 입력되고 있는 문자열의 글자가 변할때마다 클로저 호출
    // 글자가 입력될때마다 어떤 일을 할 수 있도록 여기에 정의해 놓으면 그 일을 할 수 있게된다
    private var 나중에호출될수있는함수: (String) -> Void = { _ in }
    
    func 바인딩하기(callback: @escaping (String) -> Void) {
        나중에호출될수있는함수 = callback
    }
}
