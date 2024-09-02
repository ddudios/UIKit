//
//  LoginViewModel.swift
//  LoginMVVM
//
//  Created by Suji Jang on 9/1/24.
//

import UIKit

enum LoginStatus {
    case none               // 로그인 전
    case validationFailed   // 입력 실패
    case loginDenied        // 로그인 거절
    case authenticated      // 인증 완료
}

final class LoginViewModel {
    
    // 유저가 입력한 글자 데이터
    // 입력을 받아야하니까 입력받은 문자열을 저장할 수 있게 구현
    private var emailString: String = ""
//    private var passwordString: String = ""  // 바인딩으로 구현 ↓↓↓
    // 클래스로 감싸서 직접적으로 문자열데이터를 가진다
//    var emailString = Observable("")
    var passwordString: Observable<String> = Observable("")
    
    // ⭐️ 로그인 상태 데이터 (네트워크 통신 결과)
    private var loginStatus: LoginStatus = .none
    
    // Input: 뷰에서 일어난 일을 전달받음
    func setEmailText(_ email: String) {
        emailString = email
    }
    // 바인딩 기능을 넣으니까 굳이 Output, Input 구현할 필요없음
//    func setPasswordText(_ password: String) {
//        passwordString = password
//    }
    
    func handleUserLogin(fromCurrentVC: UIViewController, animated: Bool) {
        
        // 입력창이 비어있는지 확인
        guard !emailString.isEmpty && !passwordString.value.isEmpty else {
            self.loginStatus = .validationFailed
            return
        }
        
        // 네트워크 통신한 후 결과 처리
        APIService.shared.loginTest(username: emailString, password: passwordString.value) { [unowned self] result in
            switch result {
            case .success():
                // 로그인 데이터 상태 변경
                self.loginStatus = .authenticated
                self.goToNextVC(fromCurrentVC: fromCurrentVC, animated: true)
            case .failure(_):
                // 로그인 데이터 상태 변경
                self.loginStatus = .loginDenied
                print("로그인 실패")
            }
        }
    }
    
    func handleGuestLogin(fromeCurrentVC: UIViewController, animated: Bool) {
        let firstVM = FirstPageViewModel(userEmail: "Guest")
        let nextVC = FirstPageViewController(viewModel: firstVM)
        
        nextVC.modalPresentationStyle = .fullScreen
        fromeCurrentVC.present(nextVC, animated: true)
    }
    
    // Logic
    // ⭐️ 화면 이동을 뷰모델에서 처리
    private func goToNextVC(fromCurrentVC: UIViewController, animated: Bool) {
        
        // 다음화면도 뷰모델을 가져야하니까 현재 뷰모델의 데이터를 전달하면서 다음화면의 뷰모델 생성
        let firstVM = FirstPageViewModel(userEmail: self.emailString)
        let nextVC = FirstPageViewController(viewModel: firstVM)
        
        nextVC.modalPresentationStyle = .fullScreen
        fromCurrentVC.present(nextVC, animated: true)
    }
}
