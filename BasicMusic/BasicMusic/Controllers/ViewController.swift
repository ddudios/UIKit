//
//  ViewController.swift
//  BasicMusic
//
//  Created by Suji Jang on 8/23/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
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
        startButton.isHidden = true
        nextButton.isHidden = false
    }
    
    // 네트워킹 시작 (로직도 뷰컨트롤러가 가지고 있음)
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        // Result타입이니까 success, failure 케이스로 나눌 수 있다
        fetchMusic { [unowned self] result in
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
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let music = self.music else { return }
        
        // 스토리보드에 DetailVC아이디를 가진 객체의 인스턴스 생성
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailVC.modalPresentationStyle = .fullScreen
        
        // 다음 화면에서 필요한 데이터 전달
        detailVC.imageUrl = music.imageUrl
        detailVC.songName = music.songName
        
        // 다음화면으로 이동
        self.present(detailVC, animated: true)
    }
    
}

extension ViewController {
    // 네트워킹 관련 함수도 뷰컨트롤러가 가지고 있음 (일반적으로 분리)
    func fetchMusic(completion: @escaping (Result<Music?, NetworkError>) -> ()) {
        let urlString = "https://itunes.apple.com/search?mdeia=music&term=jazz"
        let url = URL(string: urlString)!
        
        // URLSession을 사용해서 데이터가 생기고
        URLSession.shared.dataTask(with: url) { data, reponse, error in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let musicData = try JSONDecoder().decode(MusicData.self, from: safeData)
                
                // MusicData의 results속성에 접근하면 Music배열이 있다
                // 그 배열중에서 가장 첫번째 있는 음악을 꺼내서 반환
                let music = musicData.results.last
                completion(.success(music))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
}
