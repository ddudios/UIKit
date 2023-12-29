//
//  ViewController.swift
//  Login
//
//  Created by Suji Jang on 11/28/23.
//

import UIKit

final class ViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTargets()
    }
    
    func setupAddTargets() {
        loginView.loginButton.addTarget(self, action: #selector(alertTest), for: .touchUpInside)
        loginView.joinButton.addTarget(self, action: #selector(goJoinView), for: .touchUpInside)
    }
    
    // MARK: - 알럿
    @objc func alertTest() {
        let alert = UIAlertController(title: "로그인 성공", message: "로그인되었습니다.", preferredStyle: .alert)
        
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 다음 화면 준비
    @objc func goJoinView() {
        print("회원가입 화면으로 넘어가기")
    }
}
