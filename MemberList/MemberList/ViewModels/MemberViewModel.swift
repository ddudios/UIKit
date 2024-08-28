//
//  MemberViewModel.swift
//  MemberList
//
//  Created by Suji Jang on 8/28/24.
//

import UIKit

// 데이터를 가공해서 Id, 이름, 나이, 전화번호, 주소, 버튼을 보여줌
final class MemberViewModel {
    // 원래의 배열 데이터에도 접근 필요
    let dataManager: MemberListType
    
    // 멤버를 직접적으로 가짐 (데이터)
    private var member: Member?
    private var index: Int?
    
    // 멤버, 인덱스를 가지고 뷰모델 생성
    // 생성자를 통해서 전달받아야하는 것:
    // - MemberListManager: 동일한 데이터에 접근할 수 있는 동일한 객체
    // - Member
    // - Index: 새로운 멤버 생성하거나 몇번째 멤버를 업데이트할지 알아야함
    init(dataManager: MemberListType, member: Member? = nil, index: Int? = nil) {
        self.dataManager = dataManager
        self.member = member
        self.index = index
    }
    
    // MARK: - Output
    var memberImage: UIImage? {
        member?.memberImage
    }
    
    var idString: String? {
        String(member?.memberId ?? Member.memberNumbers)
    }
    
    var nameString: String? {
        return member?.name
    }
    
    var ageString: String? {
        member != nil ? String(member!.age!) : ""
    }
    
    var phoneString: String? {
        member?.phone
    }
    
    var addressString: String? {
        member?.address
    }
    
    // 버튼의 제목을 세팅하는 것도 계산속성으로 만들어봄
    var buttonTitle: String {
        // 멤버있으면 -> UPDATE
        member != nil ? "UPDATE" : "SAVE"
    }
    
    // MARK: - Input
    func handleButtonTapped(image: UIImage?, name: String?, age: String?, phone: String?, address: String?) {
        let ageInt = Int(age ?? "") ?? 0
        if member != nil {
            updateMember(image: image, name: name, age: ageInt, phone: phone, address: address)
        } else {
            makeNewMember(image: image, name: name, age: ageInt, phone: phone, address: address)
        }
    }
    
    // Logic
    // 기존 멤버를 업데이트
    // 업데이트할때는 이미지, 이름, 나이, 전화번호, 주소를 전달받아야함
    private func updateMember(image: UIImage?, name: String?, age: Int?, phone: String?, address: String?) {
        // 옵셔널바인딩
        guard let member, let index else { return }
        
        // (뷰모델이 가지고 있는) 멤버 업데이트
        self.member = Member(exitingMember: member, image: image, name: name, age: age, phone: phone, address: address)
        
        // 멤버 배열 업데이트
        // 몇번째가 업데이트된지 데이터매니저한테 알려줌
        self.dataManager.updateMember(index: index, member: self.member!)
    }
    
    // 새로운 멤버 생성
    private func makeNewMember(image: UIImage?, name: String?, age: Int?, phone: String?, address: String?) {
        // 새롭게 구조체를 생성해야하니까
        // 이미지, 이름, 나이, 전화번호, 주소를 받음
        let newMember = Member(image: image, name: name, age: age, phone: phone, address: address)
        
        // 생성한 구조체를 데이터매니저한테 전달해서 새로운 멤버 업데이트
        dataManager.makeNewMember(newMember)
    }
    
    func backToBeforeVC(fromeCurrentVC: UIViewController, animated: Bool) {
        fromeCurrentVC.navigationController?.popViewController(animated: animated)
    }
}
