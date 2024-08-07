//
//  ViewController.swift
//  TableView
//
//  Created by Suji Jang on 8/7/24.
//

import UIKit

class ViewController: UIViewController {
    
    // 영화 데이터
//    var moviesArray: [Movie] = []
    
    // 데이터메니저 생성
    var movieDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션바 제목 설정
        title = "영화목록"
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.rowHeight = 120  // 셀 높이 설정
        
        // 데이터 요청
        movieDataManager.makeMovieData()
        
        // 받은 데이터 할당
//        moviesArray = movieDataManager.getMovieData()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        movieDataManager.updateMovieData()
        
        // 테이블뷰 다시 불러오기
        tableView.reloadData()
    }
}

// 테이블 뷰 형태 구현
extension ViewController: UITableViewDataSource {
    
    // 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return movieDataManager.getMovieData().count
    }
    
    // 셀 형태 구현
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let array = movieDataManager.getMovieData()
        let movie = array[indexPath.row]
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        
        cell.selectionStyle = .none  // 셀 선택시 스타일 설정
        
        return cell
    }
}

// 테이블뷰 이벤트 전달
extension ViewController: UITableViewDelegate {
    
    // 간접세그웨이 - 화면 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            let array = movieDataManager.getMovieData()
            let indexPath = sender as! IndexPath
            
            detailVC.movieData = array[indexPath.row]
        }
    }
}
