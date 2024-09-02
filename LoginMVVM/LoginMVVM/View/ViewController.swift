//
//  ViewController.swift
//  LoginMVVM
//
//  Created by Suji Jang on 9/1/24.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - 뷰모델
    
    let viewModel = LoginViewModel()
    
    // MARK: - UI
    
    // 이메일 입력 뷰
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
        var tf = UITextField()
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
    
    // 비밀번호 입력 뷰
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
    // 아예 private lazy var emailTextField: 바인딩기능있는텍스트필드 = {
    // 로 선언해도되지만 굳이 그렇게 하지않고
    // 클로저내부에서 바인딩기능있는텍스트필드로 생성하고 업캐스팅해서 저장할 뿐이니까
    // 그 내부에 구현한 기능이 없어지는게 아니라 메모리 위에는 어차피 바인딩기능있는텍스트필드가 올라가있다
    // 그래서 어떤 타입으로 선언하든 상관없다
    // 하지만 텍스트필드를 생성할때는 반드시 바인딩기능있는텍스트필드로 생성해야 바인딩기능을 사용할 수 있다
    private lazy var passwordTextField: UITextField = {
        let tf = 바인딩기능있는텍스트필드()
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
        
        // 뷰가 변하면 => 뷰모델이 가지고 있는 데이터가 변하도록
        // 바인딩기능텍스트필드에서 글자가 변할때마다 뷰모델의 emailString을 변하도록 만듦
        tf.바인딩하기 { [weak self] text in
            // 뷰에서 유저가 글자를 입력할때마다
            // 뷰모델이 가지고 있는 emailString의 데이터값을 변하도록 만듦
            self?.viewModel.passwordString.value = text
        }
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
    
    // 로그인 버튼
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
    
    // 게스트 로그인 버튼
    let guestLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Guest Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    // 텍스트필드 및 로그인 버튼 각각의 3개 높이 설정
    private let textViewHeight: CGFloat = 48
    
    // 오토레이아웃 향후 변경을 위한 변수(애니메이션)
    private lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    private lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    // MARK: - 라이프사이클
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupAutoLayout()
        setupAddTargets()
    }
    
    // MARK: - Configure
    
    func configure() {
        view.backgroundColor = .white
        emailTextField.delegate = self
        passwordTextField.delegate = self
        addViews()
    }
    
    // 화면에 객체 띄우기
    func addViews() {
        [stackView, guestLoginButton].forEach { self.view.addSubview($0) }
    }
    
    // 오토 레이아웃
    private func setupAutoLayout() {
        
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
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
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
        guestLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            guestLoginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            guestLoginButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
    
    // MARK: - 추가 편의 기능
    
    func setupAddTargets() {
        self.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        self.guestLoginButton.addTarget(self, action: #selector(guestLoginButtonTapped), for: .touchUpInside)
    }
    
    // 비밀번호 표시/가리기 기능
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    // ⭐️ Input: 로그인 버튼 눌림 => 뷰모델에 전달
    // 뷰컨트롤러에만 present메서드가 있기때문에
    // 뷰컨트롤러에 전달해서 다음화면으로 이동하는 코드 처리
    @objc func loginButtonTapped() {
        viewModel.handleUserLogin(fromCurrentVC: self, animated: true)
    }
    
    @objc func guestLoginButtonTapped() {
        viewModel.handleGuestLogin(fromeCurrentVC: self, animated: true)
    }
    
    // 키보드 내려가기
    @objc func keyboardOff() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // 화면 탭 감지
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 화면 터치시 모든 것 종료
        self.view.endEditing(true)
    }
}

// MARK: - TextField 설정

extension ViewController: UITextFieldDelegate {
    
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
    
    // 텍스트필드 입력
    @objc func textfieldEditingChanged(textField: UITextField) {
        
        // 텍스트필드 수정끝났을 때 첫글자가 공백이면 빈 문자열로 변경
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
            }
        }
        
        // 텍스트필드가 변할때마다 뷰모델에 전달
        // ⭐️ Input: 이메일 주소 입력 => 뷰모델에 전달
        if textField == emailTextField {
            viewModel.setEmailText(textField.text ?? "")
        }
        
        // 바인딩기능텍스트필드로 구현해서 필요없음
        // ⭐️ Input: 비밀번호 입력 => 뷰모델에 전달
//        if textField == passwordTextField {
//            viewModel.setPasswordText(textField.text ?? "")
//        }
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
