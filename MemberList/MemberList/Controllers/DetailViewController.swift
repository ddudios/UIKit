//
//  DetailViewController.swift
//  MemberList
//
//  Created by Suji Jang on 8/10/24.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
    
    // 해당 뷰 생성해서 담기
    private let detailView = DetailView()
    
    // 대리자 역할을 할 수 있는 변수 생성
    // DetailViewController의 대리자는
    // MemberDelegate프로토콜을 채택한 타입만 가능하다
    weak var delegate: MemberDelegate?
    
    // 이전 화면에서 전달받은 데이터를 저장할 속성
    // 테이블뷰를 가지고 있는 ViewController의 데이터 -> DetailViewController
    var member: Member?
    
    // 기본뷰 교체
    // 내부적인 메커니즘이 없기 때문에 super 없음
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        
        // 버튼이 눌렸을 때 실행될 동작을 설정
        setupButtonAction()
        setupTapGestures()
    }
    
    // 전달받은 데이터 -> DetailView에게 전달
    func setupData() {
        detailView.member = member
    }
    
    // 뷰에 있는 버튼의 타겟 설정
    func setupButtonAction() {
        detailView.updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
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
    
    // MARK: - 이미지뷰 눌렸을 때 동작 설정
    
    func setupTapGestures() {
        
        // 제스처 생성
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        
        // 동작이 없는 객체에 위에서 생성한 제스처 추가
        detailView.mainImageView.addGestureRecognizer(tapGesture)
        
        // 유저와 상호작용 가능 여부 설정
        detailView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        setupImagePicker()
    }
    
    @objc func updateButtonTapped() {
        
        // 멤버가 없다면 (새로운 멤버 추가 화면)
        if member == nil {
            let name = detailView.nameTextField.text ?? ""
            let age = Int(detailView.ageTextField.text ?? "")
            let phone = detailView.phoneTextField.text ?? ""
            let address = detailView.addressTextField.text ?? ""
            
            var newMemeber = Member(name: name, age: age, phone: phone, address: address)
            newMemeber.memberImage = detailView.mainImageView.image
            
//            let index = navigationController!.viewControllers.count - 2
//            let vc = navigationController?.viewControllers[index] as! ViewController
//            vc.memberListManager.makeNewMember(newMemeber)
            
            delegate?.addNewMember(newMemeber)
            
            navigationController?.popViewController(animated: true)
            
        // 멤버가 있다면 (멤버의 내용 업데이트: 원래의 데이터가 있을 테니까)
        } else {
            
            // 디테일뷰의 이미지를 멤버에 저장
            member?.memberImage = detailView.mainImageView.image
            
            // 디테일뷰의 텍스트필드 내용을 멤버에 저장 -> 전달받은 멤버의 데이터 변경
            // memberId는 member모델에 업데이트할 때 몇번째 멤버인지 인덱스 역할을 위해 저장 속성 생성
            // non-optional타입만 형변환 가능
            let memberId = Int(detailView.memberIdTextField.text!) ?? 0
            member?.name = detailView.nameTextField.text ?? ""
            member?.age = Int(detailView.ageTextField.text!) ?? 0
            member?.phone = detailView.phoneTextField.text ?? ""
            member?.address = detailView.addressTextField.text ?? ""
            
            detailView.member = member
            
            /* viewWillAppear로 업데이트 하는 방식
            // 네비게이션컨트롤러를 통해서 이전 화면 접근
            let index = navigationController!.viewControllers.count - 2
            let vc = navigationController?.viewControllers[index] as! ViewController
            
            // 변경된 데이터를 뷰컨트롤러에 있는 비즈니스로직을 관리하는 매니저에게 전달
            vc.memberListManager.updateMember(index: memberId, member: member!)
            
            navigationController?.popViewController(animated: true)
             */
            
            // 델리게이트 방식으로 구현
            // 대리자의 메서드 호출
            delegate?.update(index: memberId, member!)
            
            navigationController?.popViewController(animated: true)
        }
    }
}

extension DetailViewController: PHPickerViewControllerDelegate {
    
    // 피커뷰에서 선택이 끝난 후 실행
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.detailView.mainImageView.image = image as? UIImage
                }
            }
        } else {
            print("이미지 불러오기 실패")
        }
    }
}
