//
//  ViewController.swift
//  N&TProjectCode
//
//  Created by Suji Jang on 8/5/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    // 로그인 버튼
    private let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .blue
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() {
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func loginButtonTapped() {
        // 탭바컨트롤러 생성
        let tabBarVC = UITabBarController()
        
        // 첫번째 화면은 네비게이션 컨트롤러로 생성 (기본로트뷰 설정)
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        let vc4 = FourthViewController()
        let vc5 = FifthViewController()
        
        // 탭바 이름 설정
        vc1.title = "Main"
        vc2.title = "Search"
        vc3.title = "Post"
        vc4.title = "Likes"
        vc5.title = "Me"
        
        // 탭바로 사용할 ViewController 설정
        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        
        // 탭바 PresentStyle 설정
        tabBarVC.modalPresentationStyle = .fullScreen
        
        // 탭바 배경색 설정
        tabBarVC.tabBar.backgroundColor = .white
        
        // 탭바 이미지 설정
        guard let items = tabBarVC.tabBar.items else { return }
        items[0].image = UIImage(systemName: "house")
        items[1].image = UIImage(systemName: "magnifyingglass")
        items[2].image = UIImage(systemName: "bubble.left.and.bubble.right")
        items[3].image = UIImage(systemName: "suit.heart")
        items[4].image = UIImage(systemName: "person")
        
        // 화면 이동
        present(tabBarVC, animated: true, completion: nil)
    }
}

