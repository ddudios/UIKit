//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
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
        
        clearButtonColors()
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
            
            let color = MyColor(rawValue: toDoData.color)
            setupColorTheme(color: color)
            
        } else {
            // 기존 데이터가 없을 때
            self.title = "새로운 메모 생성하기"
            
            mainTextView.text = "텍스트를 여기에 입력하세요."
            mainTextView.textColor = .lightGray
            
            saveButton.setTitle("SAVE", for: .normal)
            
            setupColorTheme(color: .red)
        }
        setupColorButton(num: temporaryNum ?? 1)
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
    
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        // 임시 숫자 저장
        self.temporaryNum = Int64(sender.tag)
        
        let color = MyColor(rawValue: Int64(sender.tag))
        setupColorTheme(color: color)
        
        clearButtonColors()
        setupColorButton(num: Int64(sender.tag))
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // 기존에 데이터가 있을때 => 기존 데이터에 업데이트
        if let toDoData {
            // 텍스트뷰에 저장되어 있는 내용
            toDoData.memoText = mainTextView.text
            toDoData.color = temporaryNum ?? 1
            
            // 세이브버튼을 눌렀을때 업데이트하려면
            // 코어데이터한테 기존의 데이터를 업데이트하라는 메서드 호출
            toDoManager.updateToDo(newToDoData: toDoData) {
                print("업데이트 완료")
                
                // 다시 이전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            // 기존에 데이터가 없을때 => 새로운 데이터 추가
            let memoText = mainTextView.text
            
            // 데이터가 없는 경우에는 새로운 데이터를 저장해야하니까
            // 투두매니저(코어데이터매니저)한테 데이터를 저장하라는 메서드 호출
            toDoManager.saveToDoData(toDoText: memoText, colorInt: temporaryNum ?? 1) {
                print("저장 완료")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // 텍스트뷰, 저장(업데이트)버튼 색상 설정
    func setupColorTheme(color: MyColor? = .red) {
        backgroundView.backgroundColor = color?.viewColor
        saveButton.backgroundColor = color?.buttonColor
    }
    
    // 눌리지 않은 버튼은 연하게 표시하는 설정
    func clearButtonColors() {
        redButton.backgroundColor = MyColor.red.viewColor
        redButton.setTitleColor(MyColor.red.buttonColor, for: .normal)
        greenButton.backgroundColor = MyColor.green.viewColor
        greenButton.setTitleColor(MyColor.green.buttonColor, for: .normal)
        blueButton.backgroundColor = MyColor.blue.viewColor
        blueButton.setTitleColor(MyColor.blue.buttonColor, for: .normal)
        purpleButton.backgroundColor = MyColor.purple.viewColor
        purpleButton.setTitleColor(MyColor.purple.buttonColor, for: .normal)
    }
    
    // 눌린 버튼을 진하게 표시하는 설정
    func setupColorButton(num: Int64) {
        switch num {
        case 1:
            redButton.backgroundColor = MyColor.red.buttonColor
            redButton.setTitleColor(.white, for: .normal)
        case 2:
            greenButton.backgroundColor = MyColor.green.buttonColor
            greenButton.setTitleColor(.white, for: .normal)
        case 3:
            blueButton.backgroundColor = MyColor.blue.buttonColor
            blueButton.setTitleColor(.white, for: .normal)
        case 4:
            purpleButton.backgroundColor = MyColor.purple.buttonColor
            purpleButton.setTitleColor(.white, for: .normal)
        default:
            redButton.backgroundColor = MyColor.red.buttonColor
            redButton.setTitleColor(.white, for: .normal)
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
