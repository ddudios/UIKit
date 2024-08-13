//
//  ViewController.swift
//  MemberList
//
//  Created by Suji Jang on 8/8/24.
//

import UIKit

final class ViewController: UIViewController {
    
    // 테이블뷰 생성
    private let tableView = UITableView()
    
    let memberListManager = MemberListManager()
    
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 뒤의 화면 색 설정
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupData()
        setupTableView()
        setupTableViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()  // tableView refresh
    }
    
    func setupNavigationBar() {
        title = "회원 목록"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    func setupData() {
        memberListManager.makeMemberListDatas()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 60
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    // 테이블뷰 오토레이아웃 설정
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func plusButtonTapped() {
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// 테이블뷰 셀 형태 설정
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMemberList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
        
//        cell.mainImageView.image = memberListManager[indexPath.row].memberImage
//        cell.memberNameLabel.text = memberListManager[indexPath.row].name
//        cell.addressLabel.text = memberListManager[indexPath.row].address
        cell.member = memberListManager[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // 셀이 눌렸을 때 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let array = memberListManager.getMemberList()
        
        detailVC.member = array[indexPath.row]
        
        // 네비게이션컨트롤러를 이용한 화면 이동
        navigationController?.pushViewController(detailVC, animated: true)
        // viewController: 이동할 다음 화면
        // animated: 자연스럽게 넘어가려면 true
    }
}
