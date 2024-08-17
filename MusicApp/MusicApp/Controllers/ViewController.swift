//
//  ViewController.swift
//  MusicApp
//
//  Created by Suji Jang on 8/15/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    
    // 서치컨트롤러 생성 방법 (🩶🖤)
    // 🩶 서치컨트롤러 사용
//    let searchController = UISearchController()
    
    // 🖤 서치Result컨트롤러 사용
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    // searchResultController 생성: UIViewController타입
    // - UIStoryboard(name:bundle:)
    // - name: 스토리보드 이름
    // - bundle: nil(없음)
    // - .instantiateViewController(withIdentifier:) 뷰컨트롤러 생성
    // - withIdentifier: 생성하는 뷰컨트롤러 이름 (컬렉션뷰컨트롤러의 Storyboard ID)
    // - SearchResultViewController로 타입캐스팅
    
    // 네트워크매니저 생성 (싱글톤)
    var networkManager = NetworkManager.shared
    
    // 음악 데이터를 다루기 위함 (빈배열로 시작)
    // 배열로 음악 데이터 표시
    // 네트워킹을 통해서 서버에서 데이터를 받아와서 배열에 채운다
    var musicArray: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        setupData()
    }
    
    // 서치바 세팅
    func setupSearchBar() {
        
        // 네비게이션 아이템에 서치바 세팅
        self.title = "Music Search"
        // 서치바를 감싸고 있는게 서치컨트롤러이기 때문에
        // 네비게이션아이템에 있는 서치컨트롤러에 할당만 해주면 서치바가 생긴다
        navigationItem.searchController = searchController
        
        // 🩶 서치컨트롤러 사용시 설정 (단순 구현)
//        searchController.searchBar.delegate = self
        
        // 🖤 서치Result컨트롤러 사용시 설정 (복잡한 구현 가능)
        // 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self
        
        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
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
        cell.releaseDateLabel.text = musicArray[indexPath.row].releaseDateString
        
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


// MARK: - 서치바 확장

/*
// 🩶 서치컨트롤러관련 프로토콜
extension ViewController: UISearchBarDelegate {
    
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // 입력되는 글자마다 searchText파라미터로 전달된다
        print(searchText)
        
        // 네트워킹을 시작하기 전에 (이미 검색된)데이터는 다시 빈배열로 만들어줘야 한다
        self.musicArray = []
        
        // 네트워크매니저한테 입력하는 텍스트마다 파라미터로 넣어서 다시 네트워킹 시작
        networkManager.fetchMusic(searchTerm: searchText) { result in
            // 배열을 다시 새롭게 만든 다음에 메인큐에서 테이블뷰 리로드
            switch result {
            case .success(let musicDatas):
                self.musicArray = musicDatas
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /* 둘중 하나만 선택
    // 검색(Search)버튼을 눌렀을때 호출되는 메서드
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 서치바에 있는 텍스트
        guard let text = searchController.searchBar.text else { return }
        
        self.musicArray = []
        networkManager.fetchMusic(searchTerm: text) { result in
            switch result {
            case .success(let musicDatas):
                self.musicArray = musicDatas
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.view.endEditing(true)
    }*/
}*/

// 🖤 서치Result컨트롤러관련 프로토콜
// 검색하는 동안 (새로운 화면을 보여주는) 복잡한 내용 구현 가능
extension ViewController: UISearchResultsUpdating {
    
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text)
        
        // 글자를 치는 순간에 다른 새로운 화면을 보여주기 (여기서 보여주는 다른 화면: 컬렉션뷰)
        let vc = searchController.searchResultsController as! SearchResultViewController
        
        // 컬렉션뷰에 검색어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}
