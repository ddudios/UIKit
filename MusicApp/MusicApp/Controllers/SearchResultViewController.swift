//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by Suji Jang on 8/17/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let searchController = UISearchController()
    
    // 컬렉션뷰의 레이아웃을 담당하는 객체 (컬렉션뷰의 모든 형태)
    let flowLayout = UICollectionViewFlowLayout()
    
    let networkMnanager = NetworkManager.shared
    var musicArray: [Music] = []
    let musicManager = MusicManager.shared
    
    // (서치바에서) 검색을 위한 단어를 담는 변수 (전화면에서 전달받음)
    var searchTerm: String? {
        didSet {
            setupDatas()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
    }
    
    func setupSearchBar() {
        
        // 네비게이션 아이템에 서치바 세팅
        self.title = "Search"
        // 서치바를 감싸고 있는게 서치컨트롤러이기 때문에
        // 네비게이션아이템에 있는 서치컨트롤러에 할당만 해주면 서치바가 생긴다
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search Image"
                
        // 서치컨트롤러 사용시 설정
        searchController.searchResultsUpdater = self
        
        // 항상 네비게이션 바에 검색창이 고정되도록 설정
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        // 컬렉션뷰의 스크롤 방향 설정
        flowLayout.scrollDirection = .vertical  // 세로로 스크롤
        
        // 셀하나의 넓이 = (스크린 넓이 - 간격 * (한줄에 셀 개수 - 1)) / 한줄에 셀 개수
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWidth * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        
        // 셀의 사이즈: 정사각형으로 설정
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        
        // 아이템 옆방향 사이 간격
        flowLayout.minimumInteritemSpacing = CVCell.spacingWidth
        
        // 아이탬 위아래 사이 간격
        flowLayout.minimumLineSpacing = CVCell.spacingWidth
        
        // 컬렉션뷰의 컬렉션뷰레이아웃에 설정한 flowLayout을 할당
        collectionView.collectionViewLayout = flowLayout
    }
    
    func setupDatas() {
        guard let searchTerm else { return }
        
        // 네트워킹 시작 전에 다시 빈배열로 만들기
        musicArray = []
        print(searchTerm)
        
        networkMnanager.fetchMusic(searchTerm: searchTerm) { result in
            switch result {
            case .success(let musicDatas):
                self.musicArray = musicDatas
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        musicManager.fetchDataFromAPI(withTerm: searchTerm) {
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    
    // 테이블뷰는 Row -> 컬렉션뷰는 Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicManager.getMusicArrayFromAPI().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionViewCellIdentifier, for: indexPath) as! MusicCollectionViewCell
        cell.imageUrl = musicManager.getMusicArrayFromAPI()[indexPath.item].imageUrl
        
        return cell
    }
}

extension SearchResultViewController: UISearchResultsUpdating {
    
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드
    func updateSearchResults(for searchController: UISearchController) {
        searchTerm = searchController.searchBar.text ?? ""
        
        musicManager.fetchDataFromAPI(withTerm: searchController.searchBar.text ?? "") {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
