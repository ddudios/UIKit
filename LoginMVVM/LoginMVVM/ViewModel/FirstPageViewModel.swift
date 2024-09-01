//
//  FirstPageViewModel.swift
//  LoginMVVM
//
//  Created by Suji Jang on 9/1/24.
//

import UIKit

final class FirstPageViewModel {
    
    // ⭐️ 데이터 (모델)
    var userEmail: String
    
    // Output
    var userEmailString: String {
        return userEmail
    }
    
    init(userEmail: String) {
        self.userEmail = userEmail
    }
    
    // Logic ...
    
    // MARK: - 얼럿
    
    func logoutAlert(fromCurrentVC: UIViewController) {
        var message: String {
            if userEmailString == "Guest" {
                "게스트 로그아웃시 데이터가 삭제됩니다."
            } else {
                "로그아웃합니다."
            }
        }
        
        let alert = UIAlertController(title: "로그아웃", message: message, preferredStyle: .alert)
        let success = UIAlertAction(title: "로그아웃", style: .default) { action in
            fromCurrentVC.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("로그아웃 취소")
        }
        alert.addAction(success)
        alert.addAction(cancel)
        
        fromCurrentVC.present(alert, animated: true, completion: nil)
    }
}
