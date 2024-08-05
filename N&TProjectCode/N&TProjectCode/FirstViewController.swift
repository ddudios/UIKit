//
//  FirstViewController.swift
//  N&TProjectCode
//
//  Created by Suji Jang on 8/5/24.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    // 네비게이션바 코드로 설정
    func makeUI() {
        view.backgroundColor = .gray
        
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        title = "Main"
    }
}
