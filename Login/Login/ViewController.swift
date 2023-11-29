//
//  ViewController.swift
//  Login
//
//  Created by Suji Jang on 11/28/23.
//

import UIKit

final class ViewController: UIViewController {
    
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
    private let emailTextField: UITextField = {
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
    private let passwordTextField: UITextField = {
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
    private let loginButton: UIButton = {
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
        button.addTarget(self, action: #selector(alertTest), for: .touchUpInside)
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
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Join", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(goJoinView), for: .touchUpInside)
        return button
    }()
    
    private let textViewHeight: CGFloat = 48
    
    private lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    private lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        makeUI()
    }
    
    // 오토 레이아웃
    func makeUI() {
        view.addSubview(stackView)
        view.addSubview(joinButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 18*2),
            
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 15),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -15),
            emailInfoLabelCenterYConstraint,
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -2),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
            
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 15),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -15),
            passwordInfoLabelCenterYConstraint,
            
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -15),
            passwordSecureButton.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordSecureButton.leadingAnchor, constant: 2),
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2),
            
            joinButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            joinButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
    
    // 비밀번호 표시
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    // 키보드 내려가기
    @objc func keyboardOff() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // 알럿 만들어봄
    @objc func alertTest() {
        let alert = UIAlertController(title: "로그인 성공", message: "로그인되었습니다.", preferredStyle: .alert)
        
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func goJoinView() {
        print("회원가입 화면으로 넘어가기")
    }
    
    // 화면 탭 감지
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
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
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
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
    
    @objc func textfieldEditingChanged(textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
            }
        }
        
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
