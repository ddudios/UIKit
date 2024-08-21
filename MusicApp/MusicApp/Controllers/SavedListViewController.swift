//
//  SavedListViewController.swift
//  MusicApp
//
//  Created by Suji Jang on 8/21/24.
//

import UIKit

class SavedListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let musicManager = MusicManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func setupNavigationBar() {
        title = "Saved Music List"
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Cell.savedMusicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.savedMusicCellIdentifier)
    }
}

extension SavedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicManager.getMusicDataFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.savedMusicCellIdentifier, for: indexPath) as! SavedMusicCell
        let savedMusic = musicManager.getMusicDataFromCoreData()[indexPath.row]
        cell.musicSaved = savedMusic
        
        // (어차피 다 저장되어 있으니) 저장을 없앨 것인지 얼럿 띄우기
        cell.saveButtonPressed = { [weak self] (senderCell) in
            guard let self else { return }
            self.makeRemoveCheckAlert { okAction in
                
                // 삭제 확인 버튼
                if okAction {
                    
                    // 코어데이터 삭제하도록 전달
                    self.musicManager.deleteMusicFromCoreData(with: savedMusic) {
                        self.tableView.reloadData()
                        print("삭제, 테이블뷰 리로드 완료")
                        self.musicManager.checkWhetherSaved()
                    }
                } else {
                    print("삭제 취소")
                }
            }
        }
        
        // 수정관련 얼럿창 띄우기
        cell.updateButtonPressed = { [weak self] (senderCell, message) in
            guard let self else { return }
            self.makeMessageAlert(myMessage: message) { updateMessage, okAction in
                
                // 수정 확인 버튼
                if okAction {

                    // 새로운 메세지로 바꾸고
                    senderCell.musicSaved?.myMessage = updateMessage
                    // 옵셔널 바인딩해서 코어데이터에 업데이트하도록 전달
                    guard let musicSaved = senderCell.musicSaved else { return }
                    self.musicManager.updateMusicToCoreData(with: musicSaved) {
                        tableView.reloadData()
                    }
                } else {
                    print("업데이트 취소")
                }
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func makeRemoveCheckAlert(completion: @escaping (Bool) -> ()) {
        let alert = UIAlertController(title: "저장된 음악 삭제", message: "복구할 수 없습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .default) { okAction in
            completion(true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancelAction in
            completion(false)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeMessageAlert(myMessage message: String?, completion: @escaping (String?, Bool) -> ()) {
        let alert = UIAlertController(title: "음악 관련 메세지 수정", message: "이전 메세지는 사라집니다.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = message
        }
        var savedText: String? = ""
        let ok = UIAlertAction(title: "수정", style: .default) { okAction in
            savedText = alert.textFields?[0].text
            completion(savedText, true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancelAction in
            completion(nil, false)
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension SavedListViewController: UITableViewDelegate {
    // 테이블뷰 셀의 높이를 유동적으로 조절하고 싶다면 구현할 수 있는 메서드
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
