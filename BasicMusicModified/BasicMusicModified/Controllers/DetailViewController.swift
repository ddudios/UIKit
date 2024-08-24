//
//  File.swift
//  BasicMusicModified
//
//  Created by Suji Jang on 8/24/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "아티스트 이름"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkGray
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var apiManager: APIService?
    var imageUrl: String?
    var songName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupAutoLayout()
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        self.songNameLabel.text = self.songName
        apiManager?.loadImage(imageUrl: imageUrl) { image in
            DispatchQueue.main.async {
                self.mainImageView.image = image
            }
        }
    }
    
    func setupAutoLayout() {
        self.view.addSubview(mainImageView)
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor),
            mainImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60 ),
            mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40)
        ])
        
        self.view.addSubview(songNameLabel)
        NSLayoutConstraint.activate([
            songNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            songNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            songNameLabel.topAnchor.constraint(equalTo: self.mainImageView.bottomAnchor, constant: 8)
        ])
        
        self.view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            backButton.heightAnchor.constraint(equalToConstant: 45),
            backButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
}
