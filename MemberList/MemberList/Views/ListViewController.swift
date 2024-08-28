//
//  ViewController.swift
//  MemberList
//
//  Created by Suji Jang on 8/8/24.
//

import UIKit

final class ListViewController: UIViewController {
    
    // 테이블뷰 생성
    private let tableView = UITableView()
    
    var viewModel: MemberListViewModel
    
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    init(viewModel: MemberListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 뒤의 화면 색 설정
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupTableView()
        setupTableViewConstraints()
        
        // 데이터 생성은 뷰모델에 위임 (자체적으로 생성자에서 하도록)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()  // tableView refresh
    }
    
    func setupNavigationBar() {
        title = viewModel.title
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    //MARK: - 테이블뷰 셋팅
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    //MARK: - 테이블뷰 오토레이아웃 셋팅
    
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
        viewModel.handleNextVC(nil, fromCurrentVC: self, animated: true)
    }
}

//MARK: - 테이블뷰 데이터 소스 구현

// 테이블뷰 셀 형태 설정
extension ListViewController: UITableViewDataSource {
    
    // 섹션에 대한 Row가 몇개인지를 판별
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 몇번째 섹션인지 전달받으면 몇개인지 세는 코드를 뷰모델에 구현
        // 뷰컨트롤러를 비대해지지 않게 만듦
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
        
        // 셀을 그릴때 MVC패턴에서는 멤버를 직접적으로 전달
//        cell.member = memberListManager[indexPath.row]
        
        // MVVM에서는 뷰모델 전달
        // 뷰모델을 꺼내올 수 있는 로직:
        // - 몇번째인지 index를 전달하면 해당 뷰모델 리턴해서 전달
        cell.viewModel = viewModel.memberViewModelAtIndex(indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - 테이블뷰 델리게이트 구현 (셀이 선택되었을때)

extension ListViewController: UITableViewDelegate {
    
    // 셀이 눌렸을 때 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MVC에서는 직접 Push
        // MVVM에서는 뷰모델에게 위임 (로직)
        viewModel.handleNextVC(indexPath.row, fromCurrentVC: self, animated: true)
    }
}
