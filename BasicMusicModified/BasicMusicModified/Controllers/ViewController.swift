//
//  ViewController.swift
//  BasicMusicModified
//
//  Created by Suji Jang on 8/24/24.
//

import UIKit

final class ViewController: UIViewController {

    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "앨범 제목"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "노래 제목"
        label.font = .systemFont(ofSize: 22)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "아티스트 이름"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [albumNameLabel, songNameLabel, artistNameLabel])
        stview.axis = .vertical
        stview.spacing = 8
        stview.alignment = .fill
        stview.distribution = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var nextButton: UIButton! = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [startButton, nextButton])
        stview.axis = .horizontal
        stview.spacing = 20
        stview.alignment = .fill
        stview.distribution = .fillEqually
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    // 일부로 싱글톤으로 안만듬 (APIService객체에 의존하게됨)
    let apiManager = APIService()
    
    // 데이터(모델) (일반적으로 뷰컨트롤러가 가지고 있음)
    var music: Music? {
        didSet {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAutoLayout()
    }
    
    func setupUI() {
        startButton.isHidden = false
        nextButton.isHidden = true
    }
    
    // 뮤직데이터를 화면에 표시
    func configureUI() {
        self.albumNameLabel.text = self.music?.albumName
        self.songNameLabel.text = self.music?.songName
        self.artistNameLabel.text = self.music?.artistName
        self.startButton.isHidden = true
        self.nextButton.isHidden = false
    }
    
    func setupAutoLayout() {
        self.view.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            labelStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            labelStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40)
        ])
        
        self.view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            buttonStackView.heightAnchor.constraint(equalToConstant: 45),
            buttonStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    // 네트워킹 시작 (로직도 뷰컨트롤러가 가지고 있음)
    @objc func startButtonTapped() {
        
        // Result타입이니까 success, failure 케이스로 나눌 수 있다
        apiManager.fetchMusic { [unowned self] result in
            switch result {
                
                // success케이스일 때 바인딩해서 뮤직을 받아서 저장한다
            case .success(let music):
                self.music = music
            case .failure(.dataError):
                print("데이터 에러")
            case .failure(.networkingError):
                print("네트워킹 에러")
            case .failure(.parseError):
                print("파싱 에러")
            }
        }
    }
    
    @objc func nextButtonTapped() {
        guard let music = self.music else { return }
        
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        
        // 네트워킹 매니저 전달 (힙 주소 복사해서 전달)
        detailVC.apiManager = self.apiManager
        
        detailVC.imageUrl = music.imageUrl
        detailVC.songName = music.songName
        
        self.present(detailVC, animated: true)
    }
    
}
