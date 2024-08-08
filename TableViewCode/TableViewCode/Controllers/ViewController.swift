//
//  ViewController.swift
//  TableViewCode
//
//  Created by Suji Jang on 8/8/24.
//

import UIKit

final class ViewController: UIViewController {
    
    // 테이블뷰 생성
    private let tableView = UITableView()
    
    var moviesArray: [Movie] = []
    var movieDataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupTableView()
        setupData()
        setupTableViewConstraints()
    }
    
    // 네비게이션바 설정
    func setupNavigationBar() {
        title = "영화목록"
        
        // 지정된 스타일로 일관성있게 표시
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance  // 표준 외관: 대부분의 화면 크기에서 네비게이션 바에 사용되는 기본 외관
        navigationController?.navigationBar.compactAppearance = appearance  // 컴팩트 외관: 작은 화면이나 화면의 일부 영역에서 네비게이션 바가 축소될 때 사용
        navigationController?.navigationBar.scrollEdgeAppearance = appearance  // 스크롤 시 나타나는 외관
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    // 테이블뷰 설정
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // 셀 높이 설정
        tableView.rowHeight = 120
        
        // 셀 등록
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MovieCell")
    }
    
    func setupData() {
        movieDataManager.makeMovieData()
        moviesArray = movieDataManager.getMovieData()
    }
    
    // 테이블뷰의 오토레이아웃 설정
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func addButtonTapped() {
        movieDataManager.updateMovieData()
        moviesArray = movieDataManager.getMovieData()
        tableView.reloadData()
    }
}

// 테이블뷰 셋팅
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MyTableViewCell
        
        let movie = moviesArray[indexPath.row]
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.movieData = moviesArray[indexPath.row]
        
        // 아이패드 show
//        show(detailVC, sender: nil)
        // push
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
