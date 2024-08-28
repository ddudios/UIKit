//
//  Member.swift
//  MemberList
//
//  Created by Suji Jang on 8/8/24.
//

import UIKit

struct Member {
    // 멤버의 (절대적) 순서를 위한 타입 저장 속성
    static var memberNumbers: Int = 0
    
    // 지연저장속성을 통해서 굳이 이미지에 접근하지 않는다면 메모리 낭비X
    lazy var memberImage: UIImage? = {
        guard let name else {
            return UIImage(systemName: "person")
        }
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    // 새롭게 생성할때
    init(image: UIImage? = nil, name: String? = nil, age: Int? = nil, phone: String? = nil, address: String? = nil) {
                
        // 자동 순번
        self.memberId = Member.memberNumbers
        
        // 외부에서 세팅 가능
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        // 인스턴스 생성시 증가
        Member.memberNumbers += 1
    }
    
    // 기존 멤버 업데이트 할때
    init(exitingMember: Member, image: UIImage? = nil, name: String? = nil, age: Int? = nil, phone: String? = nil, address: String? = nil) {
        self = exitingMember
        
        self.memberImage = image
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
    }
}
