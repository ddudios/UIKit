//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by Suji Jang on 8/18/24.
//

import UIKit

final class ToDoCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var toDoTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    
    // TodoData를 전달받을 변수
    // ⭐️ 전달받으면 => 표시하는 메서드 실행
    // 데이터가 실제로 들어오면 속성감시자를 통해서 데이터 세팅
    var toDoData: ToDoData? {
        didSet {
            configureUIwithData()
        }
    }
    
    // (델리게이트 대신에) 실행하고싶은 클로저를 저장
    // updateButtonPressed를 실행하면 Viewcontroller에서 전달된 클로저를 실행하는 방식으로 동작
    var updateButtonPressed: (ToDoCell) -> Void = { (sender) in }
    var deleteButtonPressed: (ToDoCell) -> Void = {
        (sender) in }

    // 스토리보드의 생성자
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 8
    }

    func configureUIwithData() {
        toDoTextLabel.text = toDoData?.memoText
        dateTextLabel.text = toDoData?.dataString
        
        guard let colorNum = toDoData?.color else { return }
        let color = MyColor(rawValue: colorNum) ?? .red
        backView.backgroundColor = color.viewColor
        updateButton.backgroundColor = color.buttonColor
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        // ⭐️ 내 자신 ToDoCell을 전달하면서 뷰컨트롤러에서 전달받은 클로저를 실행
        // input파라미터를 ToDoCell타입으로 만들었으니까 self(ToDoCell)를 전달하면 된다
        updateButtonPressed(self)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteButtonPressed(self)
    }
    
}
