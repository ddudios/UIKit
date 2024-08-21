//
//  ViewController.swift
//  MusicApp
//
//  Created by Suji Jang on 8/15/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    
    // 서치컨트롤러 사용
    let searchController = UISearchController()
    /** 🖤 서치Result컨트롤러 사용
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    // searchResultController 생성: UIViewController타입
    // - UIStoryboard(name:bundle:)
    // - name: 스토리보드 이름
    // - bundle: nil(없음)
    // - .instantiateViewController(withIdentifier:) 뷰컨트롤러 생성
    // - withIdentifier: 생성하는 뷰컨트롤러 이름 (컬렉션뷰컨트롤러의 Storyboard ID)
    // - SearchResultViewController로 타입캐스팅**/
    
    /** 음악 관리하는 매니저 (싱글톤): 아예 음악을 전체 관리하는 것으로 대체
    var networkManager = NetworkManager.shared
    var musicArray: [Music] = []
     **/
    let musicManager = MusicManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicTableView.reloadData()
    }
    
    // 서치바 세팅
    func setupSearchBar() {
        
        // 네비게이션 아이템에 서치바 세팅
        self.title = "Home"
        // 서치바를 감싸고 있는게 서치컨트롤러이기 때문에
        // 네비게이션아이템에 있는 서치컨트롤러에 할당만 해주면 서치바가 생긴다
        navigationItem.searchController = searchController
        
        // 서치컨트롤러 사용시 설정 (단순 구현)
        searchController.searchBar.delegate = self
        /** 🖤 서치Result컨트롤러 사용시 설정 (복잡한 구현 가능)
        // 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self**/
        
        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }

    func setupTableView() {
        musicTableView.dataSource = self
        musicTableView.delegate = self
        
        // Nib파일을 사용한다면 등록 (셀 등록)
        musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
/**
    func setupData() {
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
 **/
    // 데이터 셋업하면 테이블뷰 리로드
    func setupData() {
        musicManager.setupDataFromAPI {
            
            // 서버에서 데이터 다 가지고 온 다음에 테이블뷰 리로드
            DispatchQueue.main.async {
                self.musicTableView.reloadData()
            }
        }
    }
}


extension ViewController: UITableViewDataSource {
    
    // 배열의 개수 0개 -> 네트워킹 -> 배열에 데이터 추가 -> 테이블뷰 리로드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicManager.getMusicArrayFromAPI().count
    }
    
    // 셀 형태
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        // 모델에서 받아온 데이터 전달
        let music = musicManager.getMusicArrayFromAPI()[indexPath.row]
        cell.music = music
        
        // (델리게이트 대신에) 클로저 방식 활용
        // isSaved파라미터로 저장되어 있는지 여부가 전달된다
        cell.saveButtonPressed = { [weak self] (senderCell, isSaved) in
            guard let self else { return }
            
            // 저장이 안되어있던 것이면
            if !isSaved {
                
                // 저장하는 Alert 띄우기
                makeMessageAlert { text, savedAction in
                    
                    // 저장(확인) 선택시
                    if savedAction {
                        self.musicManager.saveMusicData(with: music, message: text) {
                                
                                // 저장 여부 설정과 버튼 스타일 변경
                                // 셀이 음악 가지고 있음
                                senderCell.music?.isSaved = true
                                
                                // 저장 여부 바뀌었으니 재설정
                                senderCell.setButtonStatus()
                                print("저장 완료")
                        }
                    } else {
                        print("저장 취소")
                    }
                }
                // 이미 저장이 되어있던 것이면
            } else {
                self.makeRemoveCheckAlert { removeAction in
                    if removeAction {
                        self.musicManager.deleteMusic(with: music) {
                            senderCell.music?.isSaved = false
                            senderCell.setButtonStatus()
                            print("삭제 완료")
                        }
                    } else {
                        print("삭제 취소")
                    }
                }
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    // 두 알럿을 합쳐서 하나의 함수로도 구현 가능
    func makeMessageAlert(completion: @escaping (String?, Bool) -> ()) {
        let alert = UIAlertController(title: "음악을 저장합니다.", message: "음악과 함께 저장할 문장을 입력하세요.", preferredStyle: .alert)
        
        // 텍스트필드의 클로저부분을 통해서 텍스트필드가 전달된다
        alert.addTextField { textField in
            textField.placeholder = "저장할 메세지 입력"
        }
        var savedText: String? = ""
        let ok = UIAlertAction(title: "저장", style: .default) { okAction in
            savedText = alert.textFields?[0].text
            completion(savedText, true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancelAction in
            completion(nil, false)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func makeRemoveCheckAlert(completion: @escaping (Bool) -> ()) {
        let alert = UIAlertController(title: "저장한 음악을 삭제합니다.", message: "저장한 메세지는 복구할 수 없습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .default) { okAction in
            completion(true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancelAction in
            completion(false)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
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
    
    // 유저가 스크롤하는 것이 끝나려는 시점에 호출되는 메서드
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0.3) {
            guard velocity.y != 0 else { return }
            if velocity.y < 0 {
                let height = self.tabBarController?.tabBar.frame.height ?? 0.0
                self.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY - height)
            } else {
                self.tabBarController?.tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.maxY)
            }
        }
    }
}


// MARK: - 서치바 확장

// 서치컨트롤러관련 프로토콜
extension ViewController: UISearchBarDelegate {
    /** 둘중 하나만 선택
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
    }**/
     
    // 검색(Search)버튼을 눌렀을때 호출되는 메서드
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 서치바에 있는 텍스트
        guard let text = searchController.searchBar.text else { return }
        
        musicManager.fetchDataFromAPI(withTerm: text) {
            DispatchQueue.main.async {
                self.musicTableView.reloadData()
            }
        }
    }
}

/** 🖤 서치Result컨트롤러관련 프로토콜
// 검색하는 동안 (새로운 화면을 보여주는) 복잡한 내용 구현 가능
extension ViewController: UISearchResultsUpdating {
    
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text)
        
        // 글자를 치는 순간에 다른 새로운 화면을 보여주기 (여기서 보여주는 다른 화면: 컬렉션뷰)
        let vc = searchController.searchResultsController as! SearchResultViewController
        
        // 컬렉션뷰에 검색어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
        
        musicManager.fetchDataFromAPI(withTerm: searchController.searchBar.text ?? "") {
            DispatchQueue.main.async {
                self.musicTableView.reloadData()
            }
        }
    }
}**/
