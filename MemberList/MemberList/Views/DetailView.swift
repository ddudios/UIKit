//
//  DetailView.swift
//  MemberList
//
//  Created by Suji Jang on 8/10/24.
//

import UIKit

class DetailView: UIView {
    
    var member: Member? {
        didSet {
            guard var member else {
                updateButton.setTitle("SAVE", for: .normal)
                memberIdTextField.text = "\(Member.memberNumbers)"
                return
            }
            mainImageView.image = member.memberImage
            memberIdTextField.text = "\(member.memberId)"
            nameTextField.text = member.name
            phoneTextField.text = member.phone
            addressTextField.text = member.address
            
            ageTextField.text = member.age != nil ? "\(member.age!)" : ""
        }
    }
    
    // MARK: - UI구현
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 정렬을 깔끔하게 하기 위한 컨테이너뷰
    lazy var imageContainView: UIView = {
        let view = UIView()
        view.addSubview(mainImageView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let memberIdLable: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "멤버번호:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberIdTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var memberIdStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [memberIdLable, memberIdTextField])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let nameLable: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "이       름:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var nameStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLable, nameTextField])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let ageLable: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "나       이:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var ageStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [ageLable, ageTextField])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let phoneLable: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "전화번호:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var phoneStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [phoneLable, phoneTextField])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let addressLable: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "주       소:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var addressStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [addressLable, addressTextField])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPDATE", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageContainView, memberIdStackView, nameStackView, ageStackView, phoneStackView, addressStackView, updateButton])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // 레이블 넓이 저장 속성
    let labelWidth: CGFloat = 70
    
    // 애니메이션을 적용하기 위한 저장 속성
    var stackViewTopConstraints: NSLayoutConstraint!
    
    // MARK: - UIView 생성자
    
    // 어떤 크기와 위치 frame을 가지고 view 생성
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        view?.backgroundColor = .white
        // 에러: 뷰컨트롤러가 갖고 있는 뷰의 백그라운드 설정할 때 사용
        // 여기서는 DetailView자체가 view니까 self로 접근
        self.backgroundColor = .white
        
        addSubviews()
        setupNotification()
        setupMemberIdTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(stackView)
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupMemberIdTextField() {
        memberIdTextField.delegate = self
    }
    
    // MARK: - 오토레이아웃 설정
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainImageView.heightAnchor.constraint(equalToConstant: 150),
            mainImageView.widthAnchor.constraint(equalToConstant: 150),
            mainImageView.centerXAnchor.constraint(equalTo: self.imageContainView.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: self.imageContainView.centerYAnchor),
            
            imageContainView.heightAnchor.constraint(equalToConstant: 180),
            
            memberIdLable.widthAnchor.constraint(equalToConstant: labelWidth),
            nameLable.widthAnchor.constraint(equalToConstant: labelWidth),
            ageLable.widthAnchor.constraint(equalToConstant: labelWidth),
            phoneLable.widthAnchor.constraint(equalToConstant: labelWidth),
            addressLable.widthAnchor.constraint(equalToConstant: labelWidth),
        ])
        
        stackViewTopConstraints = stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            stackViewTopConstraints,
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func moveUpAction() {
        stackViewTopConstraints.constant = -20
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func moveDownAction() {
        stackViewTopConstraints.constant = 10
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - 텍스트필드 델리게이트 구현

extension DetailView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == memberIdTextField {
            return false  // 수정 불가
        }
        
        // 나머지 텍스트필드는 수정 가능
        return true
    }
}
