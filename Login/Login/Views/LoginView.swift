//
//  LoginView.swift
//  Login
//
//  Created by Suji Jang on 12/29/23.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - 이메일 입력 뷰
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        view.addSubview(emailInfoLabel)
        view.addSubview(emailTextField)
        return view
    }()
    
    // 이메일 입력 안내문구
    private let emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    // 이메일 입력 텍스트 필드
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 48
        tf.tintColor = .black
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearButtonMode = .whileEditing
        tf.addTarget(self, action: #selector(textfieldEditingChanged(textField:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 비밀번호 입력 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // 비밀번호 안내문구
    private let passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    // 비밀번호 입력 필드
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.tintColor = .black
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.keyboardType = .asciiCapable // 표준 아스키 키보드(이모지사라짐)
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearButtonMode = .whileEditing
        tf.addTarget(self, action: #selector(textfieldEditingChanged(textField:)), for: .editingChanged)
        return tf
    }()
    
    private let passwordSecureButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("표시", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 로그인 버튼
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.isEnabled = false
        button.addTarget(self, action: #selector(keyboardOff), for: .touchUpInside)
        return button
    }()
    
    // VStack - 이메일tf, 비밀번호tf, 로그인bt
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [
            emailTextFieldView,
            passwordTextFieldView,
            loginButton
        ])
        st.axis = .vertical
        st.spacing = 18
        st.alignment = .fill
        st.distribution = .fillEqually
        return st
    }()
    
    // MARK: - 회원가입 버튼
    let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Join", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    // 텍스트필드 및 로그인 버튼 각각의 3개 높이 설정
    private let textViewHeight: CGFloat = 48
    
    // 오토레이아웃 향후 변경을 위한 변수(애니메이션)
    private lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    private lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 화면 설정
    func setup() {
        backgroundColor = .white
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // 화면에 객체 띄우기
    func addViews() {
        [stackView, joinButton].forEach { addSubview($0) }
    }
    
    // 오토 레이아웃
    private func setConstraints() {
        
        stackViewConstraints()
        emailInfoLabelConstraints()
        emailTextFieldConstraints()
        passwordInfoLabelConstraints()
        passwordSecureButtonConstraints()
        passwordTextFieldConstraints()
        joinButtonConstraints()
    }
    
    private func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 18*2)
        ])
    }
    
    private func emailInfoLabelConstraints() {
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 15),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -15),
            emailInfoLabelCenterYConstraint
        ])
    }
    
    private func emailTextFieldConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -2),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2)
        ])
    }
    
    private func passwordInfoLabelConstraints() {
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 15),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -15),
            passwordInfoLabelCenterYConstraint
        ])
    }
    
    private func passwordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordSecureButton.leadingAnchor, constant: 2),
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2)
        ])
    }
    
    private func passwordSecureButtonConstraints() {
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -15),
            passwordSecureButton.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
        ])
    }
    
    private func joinButtonConstraints() {
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            joinButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
    
    // MARK: - 추가 편의 기능
    // 비밀번호 표시/가리기 기능
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    // 키보드 내려가기
    @objc func keyboardOff() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // 화면 탭 감지
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 화면 터치시 모든 것 종료
        self.endEditing(true)
    }
}

// MARK: - TextField 설정
extension LoginView: UITextFieldDelegate {
    
    // 텍스트필드 편집시작할 때 설정
    // 편집하는 텍스트필드의 문구 오토레이아웃 업데이트, 테두리 색깔 변경
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            emailInfoLabel.textColor = .gray
            emailInfoLabelCenterYConstraint.constant = -13
            
            emailTextFieldView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            emailTextFieldView.layer.borderWidth = 1.7
        }
        
        if textField == passwordTextField {
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            passwordInfoLabel.textColor = .gray
            passwordInfoLabelCenterYConstraint.constant = -13
            
            passwordTextFieldView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            passwordTextFieldView.layer.borderWidth = 1.7
        }
        
        // 레이아웃 변경시 애니메이션 효과로 부드럽게 보여준다
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // 텍스트필드 편집 종료시 설정
    // 입력 조건에 충족시 원래 상태로 되돌림
    // 비워져있으면 테두리 빨간색으로 변경
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            emailTextFieldView.layer.borderWidth = 1
            
            if textField.text == "" {
                emailTextFieldView.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                emailInfoLabelCenterYConstraint.constant = 0
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabel.textColor = .black
            }
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            passwordTextFieldView.layer.borderWidth = 1
            
            if passwordTextField.text == "" {
                passwordTextFieldView.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                passwordInfoLabelCenterYConstraint.constant = 0
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabel.textColor = .black
            }
        }
    }
    
    // 텍스트필드 수정끝났을 때 첫글자가 공백이면 빈 문자열로 변경
    @objc func textfieldEditingChanged(textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
            }
        }
        
        // 텍스트필드 이메일, 비밀번호 둘 다 채워지면 버튼 활성화
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        loginButton.isEnabled = true
    }
}

