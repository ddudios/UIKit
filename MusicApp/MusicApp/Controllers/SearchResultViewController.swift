//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by Suji Jang on 8/17/24.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 컬렉션뷰의 레이아웃을 담당하는 객체 (컬렉션뷰의 모든 형태)
    let flowLayout = UICollectionViewFlowLayout()
    
    let networkMnanager = NetworkManager.shared
    var musicArray: [Music] = []
    
    // (서치바에서) 검색을 위한 단어를 담는 변수 (전화면에서 전달받음)
    var searchTerm: String? {
        didSet {
            setupDatas()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
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
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    
    // 테이블뷰는 Row -> 컬렉션뷰는 Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionViewCellIdentifier, for: indexPath) as! MusicCollectionViewCell
        cell.imageUrl = musicArray[indexPath.item].imageUrl
        
        return cell
    }
}
