//
//  ViewController.swift
//  MusicApp
//
//  Created by Suji Jang on 8/15/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    
    // 네트워크매니저 생성 (싱글톤)
    var networkManager = NetworkManager.shared
    
    // 음악 데이터를 다루기 위함 (빈배열로 시작)
    // 배열로 음악 데이터 표시
    // 네트워킹을 통해서 서버에서 데이터를 받아와서 배열에 채운다
    var musicArray: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupData()
    }

    func setupTableView() {
        musicTableView.dataSource = self
        musicTableView.delegate = self
        
        // Nib파일을 사용한다면 등록 (셀 등록)
        musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
        
//        musicTableView.rowHeight = 120
    }

    func setupData() {
        
        // 네트워킹 시작: 네트워킹매니저가 서버와 통신하는 일을 담당
        // fetchMusic: 음악 검색
        // searchTerm: 검색하고싶은 단어
        // complition: Result타입으로 성공/실패 데이터가 넘어온다
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            switch result {
                
                // 성공하는 경우
            case Result.success(let musicData):
                
                // MusicData를 받아온 다음에 테이블뷰를 그리는 코드
                print("데이터 제대로 받음")
                self.musicArray = musicData
                
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
                
                // 실패하는 경우
            case Result.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    // 배열의 개수 0개 -> 네트워킹 -> 배열에 데이터 추가 -> 테이블뷰 리로드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return musicArray.count
    }
    
    // 셀 형태
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        cell.imageUrl = musicArray[indexPath.row].imageUrl
        cell.songNameLabel.text = musicArray[indexPath.row].soneName
        cell.artistNameLabel.text = musicArray[indexPath.row].artistName
        cell.albumNameLabel.text = musicArray[indexPath.row].albumName
        cell.releaseDateLabel.text = musicArray[indexPath.row].releaseDate
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // 테이블뷰 셀의 높이를 유동적으로 조절
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
