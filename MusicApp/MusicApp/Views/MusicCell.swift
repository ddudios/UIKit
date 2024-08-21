//
//  MusicCell.swift
//  MusicApp
//
//  Created by Suji Jang on 8/16/24.
//

import UIKit

class MusicCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // 이미지 URL을 전달받는 속성
    var music: Music? {
        didSet {
            configureUIWithData()
        }
    }
    
    // (델리게이트 대신에) 실행하고 싶은 클로저 저장
    // 뷰컨트롤러에 있는 클로저 저장할 예정
    // 셀 자신을 전달하고 저장여부(참/거짓)도 전달
    // 저장여부에 따라 다른 Alert창
    // 참(이미저장) -> 삭제Alert / 거짓(저장안되어있음) -> message입력 Alert
    var saveButtonPressed: (MusicCell, Bool) -> Void = { (sender, pressed) in }
    
    // 셀이 재사용되기 전에 호출되는 메서드 (셀 재사용 준비)
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // ⭐️ 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행
        self.mainImageView.image = nil
    }
    
    // 스토리보드 또는 Nib으로 만들때, 사용하게 되는 생성자 메서드
    override func awakeFromNib() {
        saveButton.setImage(UIImage(systemName: "heart"), for: .normal)
        saveButton.tintColor = .gray
        mainImageView.contentMode = .scaleToFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureUIWithData() {
        guard let music else { return }
        loadImage(with: music.imageUrl)
        songNameLabel.text = music.songName
        artistNameLabel.text = music.artistName
        albumNameLabel.text = music.albumName
        releaseDateLabel.text = music.releaseDateString
        setButtonStatus()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let isSaved = music?.isSaved else { return }
        
        // 뷰컨트롤로에서 전달받은 클로저를 실행 (내 자신 MusicCell/저장여부 전달하면서)
        saveButtonPressed(self, isSaved)
        
        // 다시 저장 여부 셋팅
        setButtonStatus()
    }
    
    private func loadImage(with imageUrl: String?) {
        guard let urlString = imageUrl, let url = URL(string: urlString) else { return }
        
        // 비동기 처리
        DispatchQueue.global().async {
            
            // Data(contentsOf: URL) URL로 서버랑 통신해서 데이터를 받아오는 생성자 (동기적으로 처리)
            // 일반적으로 이미지URL을 가지고 데이터로 변형하는 코드를 URLSession을 직접적으로 쓰지 않고 이런 식으로 많이 사용한다
            // 에러를 던질 수 있음
            guard let data = try? Data(contentsOf: url) else { return }
            
            // ⭐️ 오래 걸리는 작업이 일어나고 있는 동안에 URL이 바뀔 가능성 제거
            // imageUrl에 들어있는 문자열인 urlString과 구조체URL로 변형한 문자열이 같은지 확인
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    func setButtonStatus() {
        guard let isSaved = music?.isSaved else { return }
        print("확인: \(isSaved)")
        
        // 저장이 되지 않았으면
        if !isSaved {
            saveButton.setImage(UIImage(systemName: "heart"), for: .normal)
            saveButton.tintColor = .gray
            
            // 저장이 되어 있으면
        } else {
            saveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            saveButton.tintColor = .red
        }
    }
}
