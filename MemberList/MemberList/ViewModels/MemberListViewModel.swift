//
//  MemberListViewModel.swift
//  MemberList
//
//  Created by Suji Jang on 8/28/24.
//

import UIKit

final class MemberListViewModel {
    
    // 데이터 관리 객체
    let dataManager: MemberListType
    
    // 네비게이션 타이틀
    let title: String
    
    // 멤버리스트의 배열 데이터
    private var memberList: [Member] {
        return dataManager.getMemberList()
    }
    
    // 의존성 주입
    init(dataManager: MemberListType, title: String) {
        self.dataManager = dataManager
        self.title = title
    }
    
    // Output
    // 이 앱은 섹션이 1개이지만 여러개라면 디테일하게 구현할 수 있다
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.memberList.count
    }
    
    // 배열의 몇번째인지 index를 받아서 뷰모델 생성
    func memberViewModelAtIndex(_ index: Int) -> MemberViewModel {
        // 배열에서 어떤 멤버인지 뽑아서
        let member = self.memberList[index]
        // 멤버를 가지고 뷰모델을 만들 수 있게 구현
        return MemberViewModel(dataManager: self.dataManager, member: member, index: index)
    }
    
    // Input
    // 멤버를 새로 만들때 호출하는 메서드
    func makeNewMember(_ member: Member) {
        dataManager.makeNewMember(member)
    }
    
    // 멤버 정보를 업데이트할때 호출하는 메서드
    func updateMemberInfo(index: Int, with member: Member) {
        dataManager.updateMember(index: index, member: member)
    }
    
    // Logic
    // 다음화면으로 이동하는 로직
    // index: 테이블뷰의 몇번째 셀이 눌리는지 알기 위함
    func handleNextVC(_ index: Int? = nil, fromCurrentVC: UIViewController, animated: Bool) {
        // 옵셔널바인딩
        if let index {
            // index에 해당하는 뷰모델 만듦
            let memberVM = memberViewModelAtIndex(index)
            // 다음화면에 갈때 뷰모델 전달
            goToNextVC(with: memberVM, fromeCurrentVC: fromCurrentVC, animated: true)
        } else {
            let newVM = MemberViewModel(dataManager: self.dataManager)
            goToNextVC(with: newVM, fromeCurrentVC: fromCurrentVC, animated: true)
        }
    }
    
    // 직접적으로 다음화면으로 넘어가는 로직
    // 다음화면으로 넘어가기 전에 뷰모델 필요하니까 전달
    private func goToNextVC(with memberVM: MemberViewModel, fromeCurrentVC: UIViewController, animated: Bool) {
        let detailVC = DetailViewController(viewModel: memberVM)
        fromeCurrentVC.navigationController?.pushViewController(detailVC, animated: true)
    }
}
