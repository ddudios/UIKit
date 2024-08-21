//
//  SavedMusicCell.swift
//  MusicApp
//
//  Created by Suji Jang on 8/20/24.
//

import UIKit

final class SavedMusicCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var saveDateLabel: UILabel!
    @IBOutlet weak var commentMessageLabel: UILabel!
    
    @IBOutlet weak var updateButton: UIButton!
    
    var musicSaved: MusicSaved? {
        didSet {
            configureUIWithData()
        }
    }
    
    // (델리게이트 대신에) 실행하고 싶은 클로저 저장
    // 뷰컨트롤러에 있는 클로저 저장할 예정 (셀 자신을 전달)
    var saveButtonPressed: (SavedMusicCell) -> () = { (sender) in }
    // 뷰컨트롤러에 있는 클로저 저장할 예정 (셀 자신, 텍스트)
    var updateButtonPressed: (SavedMusicCell, String?) -> () = { (sender, text) in }
    
    // 셀이 재사용되기 전에 호출되는 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행 ⭐️
        self.mainImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUpdateButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUpdateButton() {
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 5
    }
    
    func configureUIWithData() {
        guard let musicSaved else { return }
        loadImage(with: musicSaved.imageUrl)
        songNameLabel.text = musicSaved.songName
        artistNameLabel.text = musicSaved.artistName
        albumNameLabel.text = musicSaved.albumName
        releaseDateLabel.text = musicSaved.releaseDate
        saveDateLabel.text = "Saved Date: \(musicSaved.savedDateString ?? "")"
        commentMessageLabel.text = musicSaved.myMessage
        setButtonStatus()
    }
    
    // URL ===> 이미지를 셋팅하는 메서드
    private func loadImage(with imageUrl: String?) {
        guard let urlString = imageUrl, let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // 뷰컨트롤로에서 전달받은 클로저를 실행 (내 자신 SavedMusicCell을 전달하면서) ⭐️
        saveButtonPressed(self)
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        // 뷰컨트롤로에서 전달받은 클로저를 실행 (내 자신, Text를 전달하면서) ⭐️
        updateButtonPressed(self, musicSaved?.myMessage)
    }
    
    // 항상 채워진 하트
    func setButtonStatus() {
        saveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        saveButton.tintColor = .red
    }
    
}
