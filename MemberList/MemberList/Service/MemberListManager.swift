//
//  MemberListManager.swift
//  MemberList
//
//  Created by Suji Jang on 8/10/24.
//

import Foundation

protocol MemberListType {
    func makeMemberListDatas()
    func getMemberList() -> [Member]
    func makeNewMember(_ newMember: Member)
    func updateMember(index: Int, member: Member)
    subscript(index: Int) -> Member { get set }
}

final class MemberListManager: MemberListType {
    private var membersList: [Member] = []
    
    init() {
        makeMemberListDatas()
    }
    
    func makeMemberListDatas() {
        membersList = [
            Member(name: "홍길동", age: 20, phone: "010-1111-2222", address: "서울"),
            Member(name: "임꺽정", age: 23, phone: "010-2222-3333", address: "서울"),
            Member(name: "스티브", age: 50, phone: "010-1234-1234", address: "미국"),
            Member(name: "쿡", age: 30, phone: "010-7777-7777", address: "캘리포니아"),
            Member(name: "배조스", age: 50, phone: "010-2222-7777", address: "하와이"),
            Member(name: "배트맨", age: 40, phone: "010-4321-1234", address: "고담씨티"),
            Member(name: "조커", age: 40, phone: "010-3333-1234", address: "고담씨티")
        ]
    }
    
    // 전체 멤버 리스트 얻기
    func getMemberList() -> [Member] {
        return membersList
    }
    
    // 멤버 추가
    func makeNewMember(_ newMember: Member) {
        membersList.append(newMember)
    }
    
    // 기존 멤버의 정보 업데이트
    func updateMember(index: Int, member: Member) {
        membersList[index] = member
    }
    
    // 특정 멤버 불러오기
    subscript(index: Int) -> Member {
        get {
            return membersList[index]
        }
        set {
            membersList[index] = newValue
        }
    }
}
