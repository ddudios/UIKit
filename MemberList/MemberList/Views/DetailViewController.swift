//
//  DetailViewController.swift
//  MemberList
//
//  Created by Suji Jang on 8/10/24.
//

import UIKit
import PhotosUI

// 많은 로직들을 뷰모델한테 전달했기 때문에 간단해졌다
final class DetailViewController: UIViewController {
    
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
    
    lazy var memberIdTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 22
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
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
        tf.keyboardType = .numberPad
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
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
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
    
    // MVC: 모델을 가짐
    //var member: Member?
    
    // MVVM: 뷰모델을 가짐
    var viewModel: MemberViewModel
    
    // 생성자 - 뷰모델 주입
    // 스토리보드가 아닌 코드로 작성했을때 필요한 생성자 구현
    init(viewModel: MemberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 라이프사이클
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupMemberUI()
        setupNotification()
        setupTapGestures()
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        setupConstraints()
    }
    
    func setupMemberUI() {
        memberIdTextField.text = viewModel.idString
        mainImageView.image = viewModel.memberImage
        nameTextField.text = viewModel.nameString
        ageTextField.text = viewModel.ageString
        phoneTextField.text = viewModel.phoneString
        addressTextField.text = viewModel.addressString
        updateButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    // MARK: - 오토레이아웃 설정
    
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
        
        stackViewTopConstraints = stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            stackViewTopConstraints,
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - 이미지뷰 눌렸을 때 동작 설정
    
    func setupTapGestures() {
        
        // 제스처 생성
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        
        // 동작이 없는 객체에 위에서 생성한 제스처 추가
        self.mainImageView.addGestureRecognizer(tapGesture)
        
        // 유저와 상호작용 가능 여부 설정
        self.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        setupImagePicker()
    }
    
    // 피커뷰 세팅
    func setupImagePicker() {
        
        // 피커뷰 설정 인스턴스 생성
        var configuration = PHPickerConfiguration()
        
        // 기본 설정 세팅
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        // 위의 설정을 가진 피커뷰컨트롤러 생성
        let pickerView = PHPickerViewController(configuration: configuration)
        pickerView.delegate = self
        
        // 피커뷰로 이동: present방식
        self.present(pickerView, animated: true, completion: nil)
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func moveUpAction() {
        stackViewTopConstraints.constant = -20
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func moveDownAction() {
        stackViewTopConstraints.constant = 10
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - SAVE버튼 또는 UPDATE버튼이 눌렸을때의 동작
    
    @objc func updateButtonTapped() {
        
        guard nameTextField.text != "", ageTextField.text != "" else {
            if nameTextField.text == "" {
                nameLable.textColor = .red
            } else {
                nameLable.textColor = .black
            }
            if ageTextField.text == "" {
                ageLable.textColor = .red
            } else {
                ageLable.textColor = .black
            }
            return
        }
        
        viewModel.handleButtonTapped(image: mainImageView.image, name: nameTextField.text, age: ageTextField.text, phone: phoneTextField.text, address: addressTextField.text)
        viewModel.backToBeforeVC(fromeCurrentVC: self, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: - 텍스트필드 델리게이트 구현

extension DetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == memberIdTextField {
            return false  // 수정 불가
        }
        
        // 나머지 텍스트필드는 수정 가능
        return true
    }
}

//MARK: - 피커뷰 델리게이트

extension DetailViewController: PHPickerViewControllerDelegate {
    
    // 피커뷰에서 선택이 끝난 후 실행
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.mainImageView.image = image as? UIImage
                }
            }
        } else {
            print("이미지 불러오기 실패")
        }
    }
}
