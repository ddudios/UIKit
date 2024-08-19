//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // 색을 바꿀때 접근할 버튼
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    
    // 버튼에 쉽게 접근하기 위해 배열로 만들어 놓기 (고차함수 사용 가능)
    lazy var buttons: [UIButton] = {
        return [redButton, greenButton, blueButton, purpleButton]
    }()
    
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    let toDoManager = CoreDataManager.shared
    
    // ToDo 색깔 구분을 위해 임시적인 숫자를 저장하는 변수 (기본 빨강)
    // 나중에 어떤 색상이 선택되어 있는지 쉽게 파악하기 위함
    var temporaryNum: Int64? = 1
    
    var toDoData: ToDoData? {
        didSet {
            // 전달받은 데이터에서 색깔을 가지고 있다면 변경
            temporaryNum = toDoData?.color
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    func setup() {
        mainTextView.delegate = self
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 8
    }
    
    func configureUI() {
        // 기존 데이터가 있을 때
        if let toDoData {
            self.title = "메모 수정하기"
            
            guard let text = toDoData.memoText else { return }
            mainTextView.text = text
            mainTextView.textColor = .black
            mainTextView.becomeFirstResponder()
            
            saveButton.setTitle("UPDATE", for: .normal)
        } else {
            // 기존 데이터가 없을 때
            self.title = "새로운 메모 생성하기"
            
            mainTextView.text = "텍스트를 여기에 입력하세요."
            mainTextView.textColor = .lightGray
            
            saveButton.setTitle("SAVE", for: .normal)
        }
    }
    
    // 버튼을 둥글게 깎는 정확한 시점
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 모든 버튼의 설정 변경
        // 버튼을 배열로 만들어놨기 때문에 고차함수forEach 사용 가능
        // 배열에 있는 버튼 전부 중괄호의 내용을 한꺼번에 적용
        buttons.forEach { button in
            button.clipsToBounds = true
            button.layer.cornerRadius = button.bounds.height / 2
        }
    }
    
    // 눌리지 않은 버튼은 연하게 표시하는 설정
    func clearButtonColors() {
        
    }
    
    // 눌린 버튼을 진하게 표시하는 설정
    func setupColorButton(num: Int64) {
        
    }
    
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        // 임시 숫자 저장
        self.temporaryNum = Int64(sender.tag)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // 기존에 데이터가 있을때 => 기존 데이터에 업데이트
        if let toDoData {
            // 텍스트뷰에 저장되어 있는 내용
            toDoData.memoText = mainTextView.text
            toDoData.color = temporaryNum ?? 1
        } else {
            // 기존에 데이터가 없을때 => 새로운 데이터 추가
            let memoText = mainTextView.text
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension DetailViewController: UITextViewDelegate {
    // 입력을 시작할때
    // 텍스트뷰에는 플레이스홀더가 따로 존재하지 않아서 플레이스홀더처럼 동작하도록 직접 구현
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "텍스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스홀더처럼 띄워주기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}
