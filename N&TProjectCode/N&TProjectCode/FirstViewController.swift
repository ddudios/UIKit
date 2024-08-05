//
//  FirstViewController.swift
//  N&TProjectCode
//
//  Created by Suji Jang on 8/5/24.
//

import UIKit

class FirstViewController: UIViewController {
    
    // 로그인 여부 저장
    var isLoggedIn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 로그인되어있지 않으면 로그인뷰 띄우기
        if !isLoggedIn {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }
    
    func setupNavigationController() {
        view.backgroundColor = .gray
        
        // NavigationBar 설정
        let appearance = UINavigationBarAppearance()
        
        // 색깔 설정
        appearance.backgroundColor = .brown
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = "Main"
    }
}
